From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 7 Feb 2017 02:52:10 +0800
Subject: [hisi:topic-lpc-4.10-libio 137/148] lib/libio.c:94:36: error:
 passing argument 1 of 'acpi_libio_supported_resource' from incompatible
 pointer type
Message-ID: <201702070205.yev0u0m7%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/hisilicon/linux-hisi topic-lpc-4.10-libio
head:   06443d85dc35b64a704f7be84cc538281a1598f4
commit: d00a25ce31fe04e883575c46eededb6f3531a6fe [137/148] libio: replace extio with libio
config: x86_64-acpi-redef (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        git checkout d00a25ce31fe04e883575c46eededb6f3531a6fe
        # save the attached .config to linux build tree
        make ARCH=x86_64 

Note: the hisi/topic-lpc-4.10-libio HEAD 06443d85dc35b64a704f7be84cc538281a1598f4 builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   include/linux/list.h:376:2: note: in expansion of macro 'list_entry'
     list_entry((ptr)->next, type, member)
     ^~~~~~~~~~
   include/linux/list.h:463:13: note: in expansion of macro 'list_first_entry'
     for (pos = list_first_entry(head, typeof(*pos), member); \
                ^~~~~~~~~~~~~~~~
   lib/libio.c:36:2: note: in expansion of macro 'list_for_each_entry'
     list_for_each_entry(libio_entry, &libio_dev_list, list) {
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
   lib/libio.c:36:2: note: in expansion of macro 'list_for_each_entry'
     list_for_each_entry(libio_entry, &libio_dev_list, list) {
     ^~~~~~~~~~~~~~~~~~~
   lib/libio.c: At top level:
   lib/libio.c:45:43: warning: 'struct fwnode_handle' declared inside parameter list will not be visible outside of this definition or declaration
    struct libio_node *libio_find_node(struct fwnode_handle *node)
                                              ^~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:13:0,
                    from arch/x86/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/io.h:23,
                    from lib/libio.c:18:
   lib/libio.c: In function 'libio_find_node':
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
   lib/libio.c:50:2: note: in expansion of macro 'list_for_each_entry'
     list_for_each_entry(entry, &libio_dev_list, list) {
     ^~~~~~~~~~~~~~~~~~~
   lib/libio.c: At top level:
   lib/libio.c:59:38: warning: 'struct fwnode_handle' declared inside parameter list will not be visible outside of this definition or declaration
    unsigned long libio_translate(struct fwnode_handle *node,
                                         ^~~~~~~~~~~~~
   In file included from include/asm-generic/bug.h:13:0,
                    from arch/x86/include/asm/bug.h:35,
                    from include/linux/bug.h:4,
                    from include/linux/io.h:23,
                    from lib/libio.c:18:
   lib/libio.c: In function 'libio_translate':
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
   lib/libio.c:66:2: note: in expansion of macro 'list_for_each_entry'
     list_for_each_entry(entry, &libio_dev_list, list) {
     ^~~~~~~~~~~~~~~~~~~
   lib/libio.c: At top level:
   lib/libio.c:78:57: warning: 'struct acpi_resource' declared inside parameter list will not be visible outside of this definition or declaration
    static inline bool acpi_libio_supported_resource(struct acpi_resource *res)
                                                            ^~~~~~~~~~~~~
   lib/libio.c: In function 'acpi_libio_supported_resource':
   lib/libio.c:80:13: error: dereferencing pointer to incomplete type 'struct acpi_resource'
     switch (res->type) {
                ^~
   lib/libio.c:81:7: error: 'ACPI_RESOURCE_TYPE_ADDRESS16' undeclared (first use in this function)
     case ACPI_RESOURCE_TYPE_ADDRESS16:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/libio.c:81:7: note: each undeclared identifier is reported only once for each function it appears in
   lib/libio.c:82:7: error: 'ACPI_RESOURCE_TYPE_ADDRESS32' undeclared (first use in this function)
     case ACPI_RESOURCE_TYPE_ADDRESS32:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/libio.c:83:7: error: 'ACPI_RESOURCE_TYPE_ADDRESS64' undeclared (first use in this function)
     case ACPI_RESOURCE_TYPE_ADDRESS64:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/libio.c: At top level:
   lib/libio.c:89:8: error: unknown type name 'acpi_status'
    static acpi_status acpi_count_libiores(struct acpi_resource *res,
           ^~~~~~~~~~~
   lib/libio.c:89:47: warning: 'struct acpi_resource' declared inside parameter list will not be visible outside of this definition or declaration
    static acpi_status acpi_count_libiores(struct acpi_resource *res,
                                                  ^~~~~~~~~~~~~
   lib/libio.c: In function 'acpi_count_libiores':
>> lib/libio.c:94:36: error: passing argument 1 of 'acpi_libio_supported_resource' from incompatible pointer type [-Werror=incompatible-pointer-types]
     if (acpi_libio_supported_resource(res) &&
                                       ^~~
   lib/libio.c:78:20: note: expected 'struct acpi_resource *' but argument is of type 'struct acpi_resource *'
    static inline bool acpi_libio_supported_resource(struct acpi_resource *res)
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/libio.c:95:4: error: implicit declaration of function 'acpi_dev_filter_resource_type' [-Werror=implicit-function-declaration]
      !acpi_dev_filter_resource_type(res, IORESOURCE_IO))
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/libio.c:95:39: error: 'IORESOURCE_IO' undeclared (first use in this function)
      !acpi_dev_filter_resource_type(res, IORESOURCE_IO))
                                          ^~~~~~~~~~~~~
   lib/libio.c:98:9: error: 'AE_OK' undeclared (first use in this function)
     return AE_OK;
            ^~~~~
   lib/libio.c: At top level:
   lib/libio.c:101:8: error: unknown type name 'acpi_status'
    static acpi_status acpi_read_one_libiores(struct acpi_resource *res,
           ^~~~~~~~~~~
   lib/libio.c:101:50: warning: 'struct acpi_resource' declared inside parameter list will not be visible outside of this definition or declaration
    static acpi_status acpi_read_one_libiores(struct acpi_resource *res,
                                                     ^~~~~~~~~~~~~
   lib/libio.c: In function 'acpi_read_one_libiores':
   lib/libio.c:106:36: error: passing argument 1 of 'acpi_libio_supported_resource' from incompatible pointer type [-Werror=incompatible-pointer-types]
     if (acpi_libio_supported_resource(res) &&
                                       ^~~
   lib/libio.c:78:20: note: expected 'struct acpi_resource *' but argument is of type 'struct acpi_resource *'
    static inline bool acpi_libio_supported_resource(struct acpi_resource *res)
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/libio.c:107:39: error: 'IORESOURCE_IO' undeclared (first use in this function)
      !acpi_dev_filter_resource_type(res, IORESOURCE_IO)) {
                                          ^~~~~~~~~~~~~
   lib/libio.c:108:35: error: invalid application of 'sizeof' to incomplete type 'struct acpi_resource'
      memcpy((*resource), res, sizeof(struct acpi_resource));
                                      ^~~~~~
   lib/libio.c:109:14: error: dereferencing pointer to incomplete type 'struct acpi_resource'
      (*resource)->length = sizeof(struct acpi_resource);
                 ^~
   lib/libio.c:109:32: error: invalid application of 'sizeof' to incomplete type 'struct acpi_resource'
      (*resource)->length = sizeof(struct acpi_resource);
                                   ^~~~~~
   lib/libio.c:111:14: error: increment of pointer to an incomplete type 'struct acpi_resource'
      (*resource)++;
                 ^~
   lib/libio.c:114:9: error: 'AE_OK' undeclared (first use in this function)
     return AE_OK;
            ^~~~~
   lib/libio.c: At top level:
   lib/libio.c:117:8: error: unknown type name 'acpi_status'
    static acpi_status
           ^~~~~~~~~~~
   lib/libio.c:119:11: warning: 'struct acpi_buffer' declared inside parameter list will not be visible outside of this definition or declaration
       struct acpi_buffer *buffer)
              ^~~~~~~~~~~
   lib/libio.c:118:37: warning: 'struct acpi_device' declared inside parameter list will not be visible outside of this definition or declaration
    acpi_build_libiores_template(struct acpi_device *adev,
                                        ^~~~~~~~~~~
   lib/libio.c: In function 'acpi_build_libiores_template':
   lib/libio.c:121:2: error: unknown type name 'acpi_handle'
     acpi_handle handle = adev->handle;
     ^~~~~~~~~~~
   lib/libio.c:121:27: error: dereferencing pointer to incomplete type 'struct acpi_device'
     acpi_handle handle = adev->handle;
                              ^~
   lib/libio.c:123:2: error: unknown type name 'acpi_status'
     acpi_status status;
     ^~~~~~~~~~~
   lib/libio.c:126:11: error: implicit declaration of function 'acpi_walk_resources' [-Werror=implicit-function-declaration]
     status = acpi_walk_resources(handle, METHOD_NAME__PRS,
              ^~~~~~~~~~~~~~~~~~~
   lib/libio.c:126:39: error: 'METHOD_NAME__PRS' undeclared (first use in this function)
     status = acpi_walk_resources(handle, METHOD_NAME__PRS,
                                          ^~~~~~~~~~~~~~~~
   lib/libio.c:128:6: error: implicit declaration of function 'ACPI_FAILURE' [-Werror=implicit-function-declaration]
     if (ACPI_FAILURE(status) || !res_cnt) {
         ^~~~~~~~~~~~
   lib/libio.c:129:3: error: implicit declaration of function 'dev_err' [-Werror=implicit-function-declaration]
      dev_err(&adev->dev, "can't evaluate _CRS: %d\n", status);
      ^~~~~~~
   lib/libio.c:133:8: error: dereferencing pointer to incomplete type 'struct acpi_buffer'
     buffer->length = sizeof(struct acpi_resource) * (res_cnt + 1) + 1;
           ^~
   lib/libio.c:133:26: error: invalid application of 'sizeof' to incomplete type 'struct acpi_resource'
     buffer->length = sizeof(struct acpi_resource) * (res_cnt + 1) + 1;
                             ^~~~~~
   lib/libio.c:134:20: error: implicit declaration of function 'kzalloc' [-Werror=implicit-function-declaration]
     buffer->pointer = kzalloc(buffer->length - 1, GFP_KERNEL);
                       ^~~~~~~
   lib/libio.c:134:48: error: 'GFP_KERNEL' undeclared (first use in this function)
     buffer->pointer = kzalloc(buffer->length - 1, GFP_KERNEL);
                                                   ^~~~~~~~~~
   lib/libio.c:142:3: error: implicit declaration of function 'kfree' [-Werror=implicit-function-declaration]
      kfree(buffer->pointer);
      ^~~~~
   lib/libio.c:147:10: error: dereferencing pointer to incomplete type 'struct acpi_resource'
     resource->type = ACPI_RESOURCE_TYPE_END_TAG;
             ^~
   lib/libio.c:147:19: error: 'ACPI_RESOURCE_TYPE_END_TAG' undeclared (first use in this function)
     resource->type = ACPI_RESOURCE_TYPE_END_TAG;
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/libio.c:148:28: error: invalid application of 'sizeof' to incomplete type 'struct acpi_resource'
     resource->length = sizeof(struct acpi_resource);
                               ^~~~~~
   lib/libio.c: At top level:
   lib/libio.c:154:36: warning: 'struct acpi_buffer' declared inside parameter list will not be visible outside of this definition or declaration
      struct acpi_device *host, struct acpi_buffer *buffer)
                                       ^~~~~~~~~~~
   lib/libio.c:153:43: warning: 'struct acpi_device' declared inside parameter list will not be visible outside of this definition or declaration
    static int acpi_translate_libiores(struct acpi_device *adev,
                                              ^~~~~~~~~~~
   lib/libio.c: In function 'acpi_translate_libiores':
   lib/libio.c:156:23: error: dereferencing pointer to incomplete type 'struct acpi_buffer'
     int res_cnt = (buffer->length - 1) / sizeof(struct acpi_resource) - 1;
                          ^~
   lib/libio.c:156:46: error: invalid application of 'sizeof' to incomplete type 'struct acpi_resource'
     int res_cnt = (buffer->length - 1) / sizeof(struct acpi_resource) - 1;
                                                 ^~~~~~
   lib/libio.c:158:33: error: storage size of 'addr' isn't known
     struct acpi_resource_address64 addr;
                                    ^~~~
   lib/libio.c:160:28: error: dereferencing pointer to incomplete type 'struct acpi_device'
     struct device *dev = &adev->dev;
                               ^~
   lib/libio.c:165:21: error: dereferencing pointer to incomplete type 'struct acpi_resource'
       res_cnt, resource->type);
                        ^~
   lib/libio.c:169:19: error: implicit declaration of function 'acpi_resource_to_address64' [-Werror=implicit-function-declaration]
     if (ACPI_FAILURE(acpi_resource_to_address64(resource, &addr))) {
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/libio.c:178:3: error: implicit declaration of function 'dev_warn' [-Werror=implicit-function-declaration]
      dev_warn(dev, "variable I/O resource is invalid!\n");
      ^~~~~~~~
   lib/libio.c:190:7: error: 'ACPI_RESOURCE_TYPE_ADDRESS16' undeclared (first use in this function)
     case ACPI_RESOURCE_TYPE_ADDRESS16:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/libio.c:195:10: error: dereferencing pointer to incomplete type 'struct acpi_resource_address16'
      out_res->address.minimum = sys_port;
             ^~
   lib/libio.c:199:3: error: implicit declaration of function 'dev_info' [-Werror=implicit-function-declaration]
      dev_info(dev, "_SRS 16IO: [0x%x - 0x%x]\n",
      ^~~~~~~~
   lib/libio.c:206:7: error: 'ACPI_RESOURCE_TYPE_ADDRESS32' undeclared (first use in this function)
     case ACPI_RESOURCE_TYPE_ADDRESS32:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/libio.c:211:10: error: dereferencing pointer to incomplete type 'struct acpi_resource_address32'
      out_res->address.minimum = sys_port;
             ^~
   lib/libio.c:222:7: error: 'ACPI_RESOURCE_TYPE_ADDRESS64' undeclared (first use in this function)
     case ACPI_RESOURCE_TYPE_ADDRESS64:
          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/libio.c:227:10: error: dereferencing pointer to incomplete type 'struct acpi_resource_address64'
      out_res->address.minimum = sys_port;
             ^~
   lib/libio.c:158:33: warning: unused variable 'addr' [-Wunused-variable]
     struct acpi_resource_address64 addr;
                                    ^~~~
   lib/libio.c: At top level:
   lib/libio.c:257:36: warning: 'struct acpi_device' declared inside parameter list will not be visible outside of this definition or declaration
    int acpi_set_libio_resource(struct acpi_device *adev,
                                       ^~~~~~~~~~~
   lib/libio.c: In function 'acpi_set_libio_resource':
   lib/libio.c:260:28: error: dereferencing pointer to incomplete type 'struct acpi_device'
     struct device *dev = &adev->dev;
                               ^~
   lib/libio.c:261:21: error: storage size of 'buffer' isn't known
     struct acpi_buffer buffer;
                        ^~~~~~
   lib/libio.c:262:2: error: unknown type name 'acpi_status'
     acpi_status status;
     ^~~~~~~~~~~
   lib/libio.c:274:6: error: implicit declaration of function 'acpi_device_enumerated' [-Werror=implicit-function-declaration]
     if (acpi_device_enumerated(adev)) {
         ^~~~~~~~~~~~~~~~~~~~~~
>> lib/libio.c:280:40: error: passing argument 1 of 'acpi_build_libiores_template' from incompatible pointer type [-Werror=incompatible-pointer-types]
     status = acpi_build_libiores_template(adev, &buffer);
                                           ^~~~
   lib/libio.c:118:1: note: expected 'struct acpi_device *' but argument is of type 'struct acpi_device *'
    acpi_build_libiores_template(struct acpi_device *adev,
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/libio.c:283:5: error: 'METHOD_NAME__PRS' undeclared (first use in this function)
        METHOD_NAME__PRS);
        ^~~~~~~~~~~~~~~~
>> lib/libio.c:288:32: error: passing argument 1 of 'acpi_translate_libiores' from incompatible pointer type [-Werror=incompatible-pointer-types]
     ret = acpi_translate_libiores(adev, host, &buffer);
                                   ^~~~
   lib/libio.c:153:12: note: expected 'struct acpi_device *' but argument is of type 'struct acpi_device *'
    static int acpi_translate_libiores(struct acpi_device *adev,
               ^~~~~~~~~~~~~~~~~~~~~~~
   lib/libio.c:288:38: error: passing argument 2 of 'acpi_translate_libiores' from incompatible pointer type [-Werror=incompatible-pointer-types]
     ret = acpi_translate_libiores(adev, host, &buffer);
                                         ^~~~
   lib/libio.c:153:12: note: expected 'struct acpi_device *' but argument is of type 'struct acpi_device *'
    static int acpi_translate_libiores(struct acpi_device *adev,
               ^~~~~~~~~~~~~~~~~~~~~~~
   lib/libio.c:296:11: error: implicit declaration of function 'acpi_set_current_resources' [-Werror=implicit-function-declaration]
     status = acpi_set_current_resources(adev->handle, &buffer);
              ^~~~~~~~~~~~~~~~~~~~~~~~~~
   lib/libio.c:261:21: warning: unused variable 'buffer' [-Wunused-variable]
     struct acpi_buffer buffer;
                        ^~~~~~
   lib/libio.c: In function 'libio_find_node':
   lib/libio.c:57:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   At top level:
   lib/libio.c:31:27: warning: 'find_libio_token' defined but not used [-Wunused-function]
    static struct libio_node *find_libio_token(unsigned long addr)
                              ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/acpi_libio_supported_resource +94 lib/libio.c

    83		case ACPI_RESOURCE_TYPE_ADDRESS64:
    84			return true;
    85		}
    86		return false;
    87	}
    88	
  > 89	static acpi_status acpi_count_libiores(struct acpi_resource *res,
    90						   void *data)
    91	{
    92		int *res_cnt = data;
    93	
  > 94		if (acpi_libio_supported_resource(res) &&
    95			!acpi_dev_filter_resource_type(res, IORESOURCE_IO))
    96			(*res_cnt)++;
    97	
    98		return AE_OK;
    99	}
   100	
   101	static acpi_status acpi_read_one_libiores(struct acpi_resource *res,
   102			void *data)
   103	{
   104		struct acpi_resource **resource = data;
   105	
   106		if (acpi_libio_supported_resource(res) &&
   107			!acpi_dev_filter_resource_type(res, IORESOURCE_IO)) {
   108			memcpy((*resource), res, sizeof(struct acpi_resource));
   109			(*resource)->length = sizeof(struct acpi_resource);
   110			(*resource)->type = res->type;
   111			(*resource)++;
   112		}
   113	
   114		return AE_OK;
   115	}
   116	
   117	static acpi_status
   118	acpi_build_libiores_template(struct acpi_device *adev,
   119				struct acpi_buffer *buffer)
   120	{
   121		acpi_handle handle = adev->handle;
   122		struct acpi_resource *resource;
   123		acpi_status status;
   124		int res_cnt = 0;
   125	
   126		status = acpi_walk_resources(handle, METHOD_NAME__PRS,
   127					     acpi_count_libiores, &res_cnt);
   128		if (ACPI_FAILURE(status) || !res_cnt) {
   129			dev_err(&adev->dev, "can't evaluate _CRS: %d\n", status);
   130			return -EINVAL;
   131		}
   132	
   133		buffer->length = sizeof(struct acpi_resource) * (res_cnt + 1) + 1;
   134		buffer->pointer = kzalloc(buffer->length - 1, GFP_KERNEL);
   135		if (!buffer->pointer)
   136			return -ENOMEM;
   137	
   138		resource = (struct acpi_resource *)buffer->pointer;
   139		status = acpi_walk_resources(handle, METHOD_NAME__PRS,
   140					     acpi_read_one_libiores, &resource);
   141		if (ACPI_FAILURE(status)) {
   142			kfree(buffer->pointer);
   143			dev_err(&adev->dev, "can't evaluate _PRS: %d\n", status);
   144			return -EINVAL;
   145		}
   146	
   147		resource->type = ACPI_RESOURCE_TYPE_END_TAG;
   148		resource->length = sizeof(struct acpi_resource);
   149	
   150		return 0;
   151	}
   152	
   153	static int acpi_translate_libiores(struct acpi_device *adev,
   154			struct acpi_device *host, struct acpi_buffer *buffer)
   155	{
   156		int res_cnt = (buffer->length - 1) / sizeof(struct acpi_resource) - 1;
   157		struct acpi_resource *resource = buffer->pointer;
   158		struct acpi_resource_address64 addr;
   159		unsigned long sys_port;
   160		struct device *dev = &adev->dev;
   161	
   162		/* only one I/O resource now */
   163		if (res_cnt != 1) {
   164			dev_err(dev, "encode %d resources whose type is(%d)!\n",
   165				res_cnt, resource->type);
   166			return -EINVAL;
   167		}
   168	
   169		if (ACPI_FAILURE(acpi_resource_to_address64(resource, &addr))) {
   170			dev_err(dev, "convert acpi resource(%d) as addr64 FAIL!\n",
   171				resource->type);
   172			return -EFAULT;
   173		}
   174	
   175		/* For indirect-IO, addr length must be fixed. (>0, 0, 0) */
   176		if (!addr.address.address_length || addr.min_address_fixed ||
   177			addr.max_address_fixed) {
   178			dev_warn(dev, "variable I/O resource is invalid!\n");
   179			return -EINVAL;
   180		}
   181	
   182		sys_port = libio_translate(&host->fwnode, addr.address.minimum);
   183		if (sys_port == -1) {
   184			dev_err(dev, "translate bus-addr(0x%llx) fail!\n",
   185				addr.address.minimum);
   186			return -EFAULT;
   187		}
   188	
   189		switch (resource->type) {
   190		case ACPI_RESOURCE_TYPE_ADDRESS16:
   191		{
   192			struct acpi_resource_address16 *out_res;
   193	
   194			out_res = &resource->data.address16;
   195			out_res->address.minimum = sys_port;
   196			out_res->address.maximum = sys_port +
   197				addr.address.address_length - 1;
   198	
   199			dev_info(dev, "_SRS 16IO: [0x%x - 0x%x]\n",
   200				out_res->address.minimum,
   201				out_res->address.maximum);
   202	
   203			break;
   204		}
   205	
   206		case ACPI_RESOURCE_TYPE_ADDRESS32:
   207		{
   208			struct acpi_resource_address32 *out_res;
   209	
   210			out_res = &resource->data.address32;
   211			out_res->address.minimum = sys_port;
   212			out_res->address.maximum = sys_port +
   213				addr.address.address_length - 1;
   214	
   215			dev_info(dev, "_SRS 32IO: [0x%x - 0x%x]\n",
   216				out_res->address.minimum,
   217				out_res->address.maximum);
   218	
   219			break;
   220		}
   221	
   222		case ACPI_RESOURCE_TYPE_ADDRESS64:
   223		{
   224			struct acpi_resource_address64 *out_res;
   225	
   226			out_res = &resource->data.address64;
   227			out_res->address.minimum = sys_port;
   228			out_res->address.maximum = sys_port +
   229				addr.address.address_length - 1;
   230	
   231			dev_info(dev, "_SRS 64IO: [0x%llx - 0x%llx]\n",
   232				out_res->address.minimum,
   233				out_res->address.maximum);
   234	
   235			break;
   236		}
   237	
   238		default:
   239			return -EINVAL;
   240	
   241		}
   242	
   243		return 0;
   244	}
   245	
   246	/*
   247	 * update/set the current I/O resource of the designated device node.
   248	 * after this calling, the enumeration can be started as the I/O resource
   249	 * had been translated to logicial I/O from bus-local I/O.
   250	 *
   251	 * @adev: the device node to be updated the I/O resource;
   252	 * @host: the device node where 'adev' is attached, which can be not
   253	 *	the parent of 'adev';
   254	 *
   255	 * return 0 when successful, negative is for failure.
   256	 */
   257	int acpi_set_libio_resource(struct acpi_device *adev,
   258			struct acpi_device *host)
   259	{
   260		struct device *dev = &adev->dev;
 > 261		struct acpi_buffer buffer;
   262		acpi_status status;
   263		int ret;
   264	
   265		if (!host)
   266			return -EINVAL;
   267	
   268		/* check the device state */
   269		if (!adev->status.present) {
   270			dev_info(dev, "ACPI: device is not present!\n");
   271			return 0;
   272		}
   273		/* whether the child had been enumerated? */
   274		if (acpi_device_enumerated(adev)) {
   275			dev_info(dev, "ACPI: had been enumerated!\n");
   276			return 0;
   277		}
   278	
   279		/* read the _PRS and convert as acpi_buffer */
 > 280		status = acpi_build_libiores_template(adev, &buffer);
   281		if (ACPI_FAILURE(status)) {
   282			dev_warn(dev, "Failure evaluating %s\n",
   283					METHOD_NAME__PRS);
   284			return -ENODEV;
   285		}
   286	
   287		/* translate the I/O resources */
 > 288		ret = acpi_translate_libiores(adev, host, &buffer);
   289		if (ret) {
   290			kfree(buffer.pointer);
   291			dev_err(dev, "Translate I/O range FAIL!\n");

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 28928 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170207/cb445d08/attachment-0001.gz>
