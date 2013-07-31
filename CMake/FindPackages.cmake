# generated by Buildyard, do not edit.

include(System)
list(APPEND FIND_PACKAGES_DEFINES ${SYSTEM})

find_package(OpenGL )
find_package(Qt4 4.6 COMPONENTS QtNetwork)
find_package(X11 )
find_package(Lunchbox 1.9.0 REQUIRED)
find_package(Boost 1.41.0 REQUIRED program_options regex)

if(EXISTS ${CMAKE_SOURCE_DIR}/CMake/FindPackagesPost.cmake)
  include(${CMAKE_SOURCE_DIR}/CMake/FindPackagesPost.cmake)
endif()

if(OpenGL_FOUND)
  set(OpenGL_name OpenGL)
endif()
if(OPENGL_FOUND)
  set(OpenGL_name OPENGL)
endif()
if(OpenGL_name)
  list(APPEND FIND_PACKAGES_DEFINES HWSD_USE_OPENGL)
  set(FIND_PACKAGES_FOUND "${FIND_PACKAGES_FOUND} OpenGL")
  link_directories(${${OpenGL_name}_LIBRARY_DIRS})
  if(NOT "${${OpenGL_name}_INCLUDE_DIRS}" MATCHES "-NOTFOUND")
    include_directories(${${OpenGL_name}_INCLUDE_DIRS})
  endif()
endif()

if(Qt4_FOUND)
  set(Qt4_name Qt4)
endif()
if(QT4_FOUND)
  set(Qt4_name QT4)
endif()
if(Qt4_name)
  list(APPEND FIND_PACKAGES_DEFINES HWSD_USE_QT4)
  set(FIND_PACKAGES_FOUND "${FIND_PACKAGES_FOUND} Qt4")
  link_directories(${${Qt4_name}_LIBRARY_DIRS})
  if(NOT "${${Qt4_name}_INCLUDE_DIRS}" MATCHES "-NOTFOUND")
    include_directories(${${Qt4_name}_INCLUDE_DIRS})
  endif()
endif()

if(X11_FOUND)
  set(X11_name X11)
endif()
if(X11_FOUND)
  set(X11_name X11)
endif()
if(X11_name)
  list(APPEND FIND_PACKAGES_DEFINES HWSD_USE_X11)
  set(FIND_PACKAGES_FOUND "${FIND_PACKAGES_FOUND} X11")
  link_directories(${${X11_name}_LIBRARY_DIRS})
  if(NOT "${${X11_name}_INCLUDE_DIRS}" MATCHES "-NOTFOUND")
    include_directories(${${X11_name}_INCLUDE_DIRS})
  endif()
endif()

if(Lunchbox_FOUND)
  set(Lunchbox_name Lunchbox)
endif()
if(LUNCHBOX_FOUND)
  set(Lunchbox_name LUNCHBOX)
endif()
if(Lunchbox_name)
  list(APPEND FIND_PACKAGES_DEFINES HWSD_USE_LUNCHBOX)
  set(FIND_PACKAGES_FOUND "${FIND_PACKAGES_FOUND} Lunchbox")
  link_directories(${${Lunchbox_name}_LIBRARY_DIRS})
  if(NOT "${${Lunchbox_name}_INCLUDE_DIRS}" MATCHES "-NOTFOUND")
    include_directories(${${Lunchbox_name}_INCLUDE_DIRS})
  endif()
endif()

if(Boost_FOUND)
  set(Boost_name Boost)
endif()
if(BOOST_FOUND)
  set(Boost_name BOOST)
endif()
if(Boost_name)
  list(APPEND FIND_PACKAGES_DEFINES HWSD_USE_BOOST)
  set(FIND_PACKAGES_FOUND "${FIND_PACKAGES_FOUND} Boost")
  link_directories(${${Boost_name}_LIBRARY_DIRS})
  if(NOT "SYSTEM ${${Boost_name}_INCLUDE_DIRS}" MATCHES "-NOTFOUND")
    include_directories(SYSTEM ${${Boost_name}_INCLUDE_DIRS})
  endif()
endif()

set(HWSD_BUILD_DEBS cmake;git;git-svn;libavahi-compat-libdnssd-dev;libboost-program-options-dev;libboost-regex-dev;libboost-serialization-dev;libgl1-mesa-dev;libhwloc-dev;libjpeg-turbo8-dev;libqt4-dev;libturbojpeg;libx11-dev;pkg-config;subversion)

set(HWSD_DEPENDS OpenGL;Qt4;X11;Lunchbox;Boost)

# Write defines.h and options.cmake
if(NOT PROJECT_INCLUDE_NAME)
  set(PROJECT_INCLUDE_NAME ${CMAKE_PROJECT_NAME})
endif()
if(NOT OPTIONS_CMAKE)
  set(OPTIONS_CMAKE ${CMAKE_BINARY_DIR}/options.cmake)
endif()
set(DEFINES_FILE "${CMAKE_BINARY_DIR}/include/${PROJECT_INCLUDE_NAME}/defines${SYSTEM}.h")
set(DEFINES_FILE_IN ${DEFINES_FILE}.in)
file(WRITE ${DEFINES_FILE_IN}
  "// generated by CMake/FindPackages.cmake, do not edit.\n\n"
  "#ifndef ${CMAKE_PROJECT_NAME}_DEFINES_${SYSTEM}_H\n"
  "#define ${CMAKE_PROJECT_NAME}_DEFINES_${SYSTEM}_H\n\n")
file(WRITE ${OPTIONS_CMAKE} "# Optional modules enabled during build\n")
foreach(DEF ${FIND_PACKAGES_DEFINES})
  add_definitions(-D${DEF})
  file(APPEND ${DEFINES_FILE_IN}
  "#ifndef ${DEF}\n"
  "#  define ${DEF}\n"
  "#endif\n")
if(NOT DEF STREQUAL SYSTEM)
  file(APPEND ${OPTIONS_CMAKE} "set(${DEF} ON)\n")
endif()
endforeach()
file(APPEND ${DEFINES_FILE_IN}
  "\n#endif\n")

include(UpdateFile)
update_file(${DEFINES_FILE_IN} ${DEFINES_FILE})
if(Boost_FOUND) # another WAR for broken boost stuff...
  set(Boost_VERSION ${Boost_MAJOR_VERSION}.${Boost_MINOR_VERSION}.${Boost_SUBMINOR_VERSION})
endif()
if(CUDA_FOUND)
  string(REPLACE "-std=c++11" "" CUDA_HOST_FLAGS "${CUDA_HOST_FLAGS}")
  string(REPLACE "-std=c++0x" "" CUDA_HOST_FLAGS "${CUDA_HOST_FLAGS}")
endif()
if(FIND_PACKAGES_FOUND)
  if(MSVC)
    message(STATUS "Configured with ${FIND_PACKAGES_FOUND}")
  else()
    message(STATUS "Configured with ${CMAKE_BUILD_TYPE}${FIND_PACKAGES_FOUND}")
  endif()
endif()
