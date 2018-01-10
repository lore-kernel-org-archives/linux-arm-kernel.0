From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 11 Jan 2018 07:18:29 +0800
Subject: [nomadik:gemini-ethernet 18/18] include/linux/module.h:129:42:
 error: redefinition of '__inittest'
Message-ID: <201801110724.NXy6uwOz%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini-ethernet
head:   de0cb586c9e534c926cd7c74c92dc3d4104ea569
commit: de0cb586c9e534c926cd7c74c92dc3d4104ea569 [18/18] net: ethernet: Add a driver for Gemini gigabit ethernet
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout de0cb586c9e534c926cd7c74c92dc3d4104ea569
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:329:0,
                    from include/linux/kernel.h:14,
                    from include/linux/list.h:9,
                    from include/linux/module.h:9,
                    from drivers/net//ethernet/cortina/gemini.c:16:
   drivers/net//ethernet/cortina/gemini.c: In function 'geth_freeq_alloc_map_page':
>> drivers/net//ethernet/cortina/gemini.c:821:21: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t {aka long long unsigned int}' [-Wformat=]
     dev_dbg(geth->dev, "page %d, DMA addr: %08x, page %p\n",
                        ^
   include/linux/dynamic_debug.h:135:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
>> drivers/net//ethernet/cortina/gemini.c:821:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(geth->dev, "page %d, DMA addr: %08x, page %p\n",
     ^~~~~~~
   drivers/net//ethernet/cortina/gemini.c: In function 'gmac_rx':
   drivers/net//ethernet/cortina/gemini.c:1410:50: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'dma_addr_t {aka long long unsigned int}' [-Wformat=]
       dev_err(geth->dev, "could not find mapping %08x (page = %08x, page off = %08x)\n",
                                                  ~~~^
                                                  %08llx
>> drivers/net//ethernet/cortina/gemini.c:1410:63: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'long long unsigned int' [-Wformat=]
       dev_err(geth->dev, "could not find mapping %08x (page = %08x, page off = %08x)\n",
                                                               ~~~^
                                                               %08llx
   drivers/net//ethernet/cortina/gemini.c: In function 'gemini_ethernet_port_probe':
>> drivers/net//ethernet/cortina/gemini.c:2456:28: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t {aka long long unsigned int}' [-Wformat=]
           "irq %d, DMA @ 0x%08x, GMAC @ 0x%08x\n",
                            ~~~^
                            %08llx
           port->irq, dmares->start,
                      ~~~~~~~~~~~~~
   drivers/net//ethernet/cortina/gemini.c:2456:43: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'resource_size_t {aka long long unsigned int}' [-Wformat=]
           "irq %d, DMA @ 0x%08x, GMAC @ 0x%08x\n",
                                           ~~~^
                                           %08llx
   drivers/net//ethernet/cortina/gemini.c:2458:8:
           gmacres->start);
           ~~~~~~~~~~~~~~                      
   In file included from drivers/net//ethernet/cortina/gemini.c:16:0:
   drivers/net//ethernet/cortina/gemini.c: At top level:
>> include/linux/module.h:129:42: error: redefinition of '__inittest'
     static inline initcall_t __maybe_unused __inittest(void)  \
                                             ^
   include/linux/device.h:1513:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^~~~~~~~~~~
>> include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
>> drivers/net//ethernet/cortina/gemini.c:2567:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:129:42: note: previous definition of '__inittest' was here
     static inline initcall_t __maybe_unused __inittest(void)  \
                                             ^
   include/linux/device.h:1513:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^~~~~~~~~~~
>> include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net//ethernet/cortina/gemini.c:2495:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_port_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
>> include/linux/module.h:131:6: error: redefinition of 'init_module'
     int init_module(void) __attribute__((alias(#initfn)));
         ^
   include/linux/device.h:1513:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^~~~~~~~~~~
>> include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
>> drivers/net//ethernet/cortina/gemini.c:2567:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:131:6: note: previous definition of 'init_module' was here
     int init_module(void) __attribute__((alias(#initfn)));
         ^
   include/linux/device.h:1513:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^~~~~~~~~~~
>> include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net//ethernet/cortina/gemini.c:2495:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_port_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
>> include/linux/module.h:135:42: error: redefinition of '__exittest'
     static inline exitcall_t __maybe_unused __exittest(void)  \
                                             ^
   include/linux/device.h:1518:1: note: in expansion of macro 'module_exit'
    module_exit(__driver##_exit);
    ^~~~~~~~~~~
>> include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
>> drivers/net//ethernet/cortina/gemini.c:2567:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:135:42: note: previous definition of '__exittest' was here
     static inline exitcall_t __maybe_unused __exittest(void)  \
                                             ^
   include/linux/device.h:1518:1: note: in expansion of macro 'module_exit'
    module_exit(__driver##_exit);
    ^~~~~~~~~~~
>> include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net//ethernet/cortina/gemini.c:2495:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_port_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
>> include/linux/module.h:137:7: error: redefinition of 'cleanup_module'
     void cleanup_module(void) __attribute__((alias(#exitfn)));
          ^
   include/linux/device.h:1518:1: note: in expansion of macro 'module_exit'
    module_exit(__driver##_exit);
    ^~~~~~~~~~~
>> include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
>> drivers/net//ethernet/cortina/gemini.c:2567:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:137:7: note: previous definition of 'cleanup_module' was here
     void cleanup_module(void) __attribute__((alias(#exitfn)));
          ^
   include/linux/device.h:1518:1: note: in expansion of macro 'module_exit'
    module_exit(__driver##_exit);
    ^~~~~~~~~~~
>> include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net//ethernet/cortina/gemini.c:2495:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_port_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/printk.h:329:0,
                    from include/linux/kernel.h:14,
                    from include/linux/list.h:9,
                    from include/linux/module.h:9,
                    from drivers/net/ethernet/cortina/gemini.c:16:
   drivers/net/ethernet/cortina/gemini.c: In function 'geth_freeq_alloc_map_page':
   drivers/net/ethernet/cortina/gemini.c:821:21: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t {aka long long unsigned int}' [-Wformat=]
     dev_dbg(geth->dev, "page %d, DMA addr: %08x, page %p\n",
                        ^
   include/linux/dynamic_debug.h:135:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
   drivers/net/ethernet/cortina/gemini.c:821:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(geth->dev, "page %d, DMA addr: %08x, page %p\n",
     ^~~~~~~
   drivers/net/ethernet/cortina/gemini.c: In function 'gmac_rx':
   drivers/net/ethernet/cortina/gemini.c:1410:50: warning: format '%x' expects argument of type 'unsigned int', but argument 3 has type 'dma_addr_t {aka long long unsigned int}' [-Wformat=]
       dev_err(geth->dev, "could not find mapping %08x (page = %08x, page off = %08x)\n",
                                                  ~~~^
                                                  %08llx
   drivers/net/ethernet/cortina/gemini.c:1410:63: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'long long unsigned int' [-Wformat=]
       dev_err(geth->dev, "could not find mapping %08x (page = %08x, page off = %08x)\n",
                                                               ~~~^
                                                               %08llx
   drivers/net/ethernet/cortina/gemini.c: In function 'gemini_ethernet_port_probe':
   drivers/net/ethernet/cortina/gemini.c:2456:28: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'resource_size_t {aka long long unsigned int}' [-Wformat=]
           "irq %d, DMA @ 0x%08x, GMAC @ 0x%08x\n",
                            ~~~^
                            %08llx
           port->irq, dmares->start,
                      ~~~~~~~~~~~~~
   drivers/net/ethernet/cortina/gemini.c:2456:43: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'resource_size_t {aka long long unsigned int}' [-Wformat=]
           "irq %d, DMA @ 0x%08x, GMAC @ 0x%08x\n",
                                           ~~~^
                                           %08llx
   drivers/net/ethernet/cortina/gemini.c:2458:8:
           gmacres->start);
           ~~~~~~~~~~~~~~                      
   In file included from drivers/net/ethernet/cortina/gemini.c:16:0:
   drivers/net/ethernet/cortina/gemini.c: At top level:
>> include/linux/module.h:129:42: error: redefinition of '__inittest'
     static inline initcall_t __maybe_unused __inittest(void)  \
                                             ^
   include/linux/device.h:1513:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^~~~~~~~~~~
>> include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net/ethernet/cortina/gemini.c:2567:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:129:42: note: previous definition of '__inittest' was here
     static inline initcall_t __maybe_unused __inittest(void)  \
                                             ^
   include/linux/device.h:1513:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^~~~~~~~~~~
>> include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net/ethernet/cortina/gemini.c:2495:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_port_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
>> include/linux/module.h:131:6: error: redefinition of 'init_module'
     int init_module(void) __attribute__((alias(#initfn)));
         ^
   include/linux/device.h:1513:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^~~~~~~~~~~
>> include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net/ethernet/cortina/gemini.c:2567:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:131:6: note: previous definition of 'init_module' was here
     int init_module(void) __attribute__((alias(#initfn)));
         ^
   include/linux/device.h:1513:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^~~~~~~~~~~
>> include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net/ethernet/cortina/gemini.c:2495:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_port_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
>> include/linux/module.h:135:42: error: redefinition of '__exittest'
     static inline exitcall_t __maybe_unused __exittest(void)  \
                                             ^
   include/linux/device.h:1518:1: note: in expansion of macro 'module_exit'
    module_exit(__driver##_exit);
    ^~~~~~~~~~~
>> include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net/ethernet/cortina/gemini.c:2567:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:135:42: note: previous definition of '__exittest' was here
     static inline exitcall_t __maybe_unused __exittest(void)  \
                                             ^
   include/linux/device.h:1518:1: note: in expansion of macro 'module_exit'
    module_exit(__driver##_exit);
    ^~~~~~~~~~~
>> include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net/ethernet/cortina/gemini.c:2495:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_port_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
>> include/linux/module.h:137:7: error: redefinition of 'cleanup_module'
     void cleanup_module(void) __attribute__((alias(#exitfn)));
          ^
   include/linux/device.h:1518:1: note: in expansion of macro 'module_exit'
    module_exit(__driver##_exit);
    ^~~~~~~~~~~
>> include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net/ethernet/cortina/gemini.c:2567:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:137:7: note: previous definition of 'cleanup_module' was here
     void cleanup_module(void) __attribute__((alias(#exitfn)));
          ^
   include/linux/device.h:1518:1: note: in expansion of macro 'module_exit'
    module_exit(__driver##_exit);
    ^~~~~~~~~~~
>> include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net/ethernet/cortina/gemini.c:2495:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_port_driver);
    ^~~~~~~~~~~~~~~~~~~~~~

vim +/__inittest +129 include/linux/module.h

0fd972a7 Paul Gortmaker 2015-05-01  126  
0fd972a7 Paul Gortmaker 2015-05-01  127  /* Each module must use one module_init(). */
0fd972a7 Paul Gortmaker 2015-05-01  128  #define module_init(initfn)					\
1f318a8b Arnd Bergmann  2017-02-01 @129  	static inline initcall_t __maybe_unused __inittest(void)		\
0fd972a7 Paul Gortmaker 2015-05-01  130  	{ return initfn; }					\
0fd972a7 Paul Gortmaker 2015-05-01 @131  	int init_module(void) __attribute__((alias(#initfn)));
0fd972a7 Paul Gortmaker 2015-05-01  132  
0fd972a7 Paul Gortmaker 2015-05-01  133  /* This is only required if you want to be unloadable. */
0fd972a7 Paul Gortmaker 2015-05-01  134  #define module_exit(exitfn)					\
1f318a8b Arnd Bergmann  2017-02-01 @135  	static inline exitcall_t __maybe_unused __exittest(void)		\
0fd972a7 Paul Gortmaker 2015-05-01  136  	{ return exitfn; }					\
0fd972a7 Paul Gortmaker 2015-05-01 @137  	void cleanup_module(void) __attribute__((alias(#exitfn)));
0fd972a7 Paul Gortmaker 2015-05-01  138  

:::::: The code at line 129 was first introduced by commit
:::::: 1f318a8bafcfba9f0d623f4870c4e890fd22e659 modules: mark __inittest/__exittest as __maybe_unused

:::::: TO: Arnd Bergmann <arnd@arndb.de>
:::::: CC: Jessica Yu <jeyu@redhat.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 49802 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180111/ec884718/attachment-0001.gz>
