From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 7 Feb 2017 03:09:40 +0800
Subject: [hisi:topic-lpc-4.10-libio 139/148] include/linux/list.h:463:43:
 error: dereferencing pointer to incomplete type 'struct io_range'
Message-ID: <201702070330.UWvtaT64%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/hisilicon/linux-hisi topic-lpc-4.10-libio
head:   06443d85dc35b64a704f7be84cc538281a1598f4
commit: b7bc5eec71294f8df5db8a1e0be4c4eb09c007cd [139/148] libio: relocate pci io functions
config: x86_64-acpi-redef (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout b7bc5eec71294f8df5db8a1e0be4c4eb09c007cd
        # save the attached .config to linux build tree
        make ARCH=x86_64 

Note: the hisi/topic-lpc-4.10-libio HEAD 06443d85dc35b64a704f7be84cc538281a1598f4 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   In file included from include/linux/list.h:8:0,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:21,
                    from lib/libio.c:18:
   lib/libio.c: In function 'find_io_range':
>> include/linux/list.h:463:43: error: dereferencing pointer to incomplete type 'struct io_range'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                                               
   include/linux/kernel.h:850:18: note: in definition of macro 'container_of'
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                     ^~~~
   include/linux/list.h:376:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/list.h:463:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^~~~~~~~~~~~~~~~
   lib/libio.c:30:2: note: in expansion of macro 'list_for_each_entry'
     list_for_each_entry(io_range, &io_range_list, list) {
     ^~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:850:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   include/linux/list.h:365:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^~~~~~~~~~~~
   include/linux/list.h:376:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/list.h:463:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^~~~~~~~~~~~~~~~
   lib/libio.c:30:2: note: in expansion of macro 'list_for_each_entry'
     list_for_each_entry(io_range, &io_range_list, list) {
     ^~~~~~~~~~~~~~~~~~~
   lib/libio.c: In function 'find_io_range_from_fwnode':
   include/linux/kernel.h:850:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   include/linux/list.h:365:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^~~~~~~~~~~~
   include/linux/list.h:376:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/list.h:463:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^~~~~~~~~~~~~~~~
   lib/libio.c:44:2: note: in expansion of macro 'list_for_each_entry'
     list_for_each_entry(io_range, &io_range_list, list) {
     ^~~~~~~~~~~~~~~~~~~
   lib/libio.c: In function 'io_translate':
   include/linux/kernel.h:850:48: error: initialization from incompatible pointer type [-Werror=incompatible-pointer-types]
     const typeof( ((type *)0)->member ) *__mptr = (ptr); \
                                                   ^
   include/linux/list.h:365:2: note: in expansion of macro 'container_of'
     container_of(ptr, type, member)
     ^~~~~~~~~~~~
   include/linux/list.h:376:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/list.h:463:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^~~~~~~~~~~~~~~~
   lib/libio.c:60:2: note: in expansion of macro 'list_for_each_entry'
     list_for_each_entry(entry, &io_range_list, list) {
     ^~~~~~~~~~~~~~~~~~~
   lib/libio.c: At top level:
   lib/libio.c:202:57: warning: 'struct acpi_resource' declared inside parameter list will not be visible outside of this definition or declaration
    static inline bool acpi_libio_supported_resource(struct acpi_resource *res)
                                                            ^~~~~~~~~~~~~
   lib/libio.c: In function 'acpi_libio_supported_resource':
   lib/libio.c:204:13: error: dereferencing pointer to incomplete type 'struct acpi_resource'
     switch (res->type) {
                ^~
   lib/libio.c:205:7: error: 'ACPI_RESOURCE_TYPE_ADDRESS16' undeclared (first use in this function)
     case ACPI_RESOURCE_TYPE_ADDRESS16:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/libio.c:205:7: note: each undeclared identifier is reported only once for each function it appears in
   lib/libio.c:206:7: error: 'ACPI_RESOURCE_TYPE_ADDRESS32' undeclared (first use in this function)
     case ACPI_RESOURCE_TYPE_ADDRESS32:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/libio.c:207:7: error: 'ACPI_RESOURCE_TYPE_ADDRESS64' undeclared (first use in this function)
     case ACPI_RESOURCE_TYPE_ADDRESS64:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/libio.c: At top level:
   lib/libio.c:213:8: error: unknown type name 'acpi_status'
    static acpi_status acpi_count_libiores(struct acpi_resource *res,
           ^~~~~~~~~~~
   lib/libio.c:213:47: warning: 'struct acpi_resource' declared inside parameter list will not be visible outside of this definition or declaration
    static acpi_status acpi_count_libiores(struct acpi_resource *res,
                                                  ^~~~~~~~~~~~~
   lib/libio.c: In function 'acpi_count_libiores':
   lib/libio.c:218:36: error: passing argument 1 of 'acpi_libio_supported_resource' from incompatible pointer type [-Werror=incompatible-pointer-types]
     if (acpi_libio_supported_resource(res) &&
                                       ^~~
   lib/libio.c:202:20: note: expected 'struct acpi_resource *' but argument is of type 'struct acpi_resource *'
    static inline bool acpi_libio_supported_resource(struct acpi_resource *res)
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/libio.c:219:4: error: implicit declaration of function 'acpi_dev_filter_resource_type' [-Werror=implicit-function-declaration]
      !acpi_dev_filter_resource_type(res, IORESOURCE_IO))
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/libio.c:222:9: error: 'AE_OK' undeclared (first use in this function)
     return AE_OK;
            ^~~~~
   lib/libio.c: At top level:

vim +463 include/linux/list.h

^1da177e Linus Torvalds 2005-04-16  457   * list_for_each_entry	-	iterate over list of given type
8e3a67a9 Randy Dunlap   2006-06-25  458   * @pos:	the type * to use as a loop cursor.
^1da177e Linus Torvalds 2005-04-16  459   * @head:	the head for your list.
3943f42c Andrey Utkin   2014-11-14  460   * @member:	the name of the list_head within the struct.
^1da177e Linus Torvalds 2005-04-16  461   */
^1da177e Linus Torvalds 2005-04-16  462  #define list_for_each_entry(pos, head, member)				\
93be3c2e Oleg Nesterov  2013-11-12 @463  	for (pos = list_first_entry(head, typeof(*pos), member);	\
e66eed65 Linus Torvalds 2011-05-19  464  	     &pos->member != (head);					\
8120e2e5 Oleg Nesterov  2013-11-12  465  	     pos = list_next_entry(pos, member))
^1da177e Linus Torvalds 2005-04-16  466  

:::::: The code at line 463 was first introduced by commit
:::::: 93be3c2eb3371f022ad88acf1ab6bee8e3c38378 list: introduce list_last_entry(), use list_{first,last}_entry()

:::::: TO: Oleg Nesterov <oleg@redhat.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28928 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170207/675fd32a/attachment-0001.gz>
