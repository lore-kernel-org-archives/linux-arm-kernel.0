From: fengguang.wu@intel.com (kbuild test robot)
Date: Sun, 17 Dec 2017 06:48:59 +0800
Subject: [nomadik:gemini-ethernet 18/18]
 drivers/net//ethernet/cortina/gemini.c:715:22: error: implicit declaration
 of function 'dma_to_pfn'
Message-ID: <201712170656.4U46NVRs%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git gemini-ethernet
head:   502a2864e5e43c51a3a2689586d9c61d060a3b7d
commit: 502a2864e5e43c51a3a2689586d9c61d060a3b7d [18/18] net: ethernet: Add a driver for Gemini gigabit ethernet
config: openrisc-allmodconfig (attached as .config)
compiler: or1k-linux-gcc (GCC) 6.0.0 20160327 (experimental)
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 502a2864e5e43c51a3a2689586d9c61d060a3b7d
        # save the attached .config to linux build tree
        make.cross ARCH=openrisc 

All errors (new ones prefixed by >>):

   In file included from arch/openrisc/include/asm/page.h:98:0,
                    from arch/openrisc/include/asm/processor.h:23,
                    from arch/openrisc/include/asm/thread_info.h:26,
                    from include/linux/thread_info.h:38,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/openrisc/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:81,
                    from include/linux/spinlock.h:51,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:10,
                    from drivers/net//ethernet/cortina/gemini.c:16:
   drivers/net//ethernet/cortina/gemini.c: In function 'gmac_cleanup_rxq':
>> drivers/net//ethernet/cortina/gemini.c:715:22: error: implicit declaration of function 'dma_to_pfn' [-Werror=implicit-function-declaration]
      page = pfn_to_page(dma_to_pfn(geth->dev, mapping));
                         ^
   include/asm-generic/memory_model.h:33:41: note: in definition of macro '__pfn_to_page'
    #define __pfn_to_page(pfn) (mem_map + ((pfn) - ARCH_PFN_OFFSET))
                                            ^~~
   drivers/net//ethernet/cortina/gemini.c:715:10: note: in expansion of macro 'pfn_to_page'
      page = pfn_to_page(dma_to_pfn(geth->dev, mapping));
             ^~~~~~~~~~~
   In file included from drivers/net//ethernet/cortina/gemini.c:16:0:
   drivers/net//ethernet/cortina/gemini.c: At top level:
   include/linux/module.h:129:42: error: redefinition of '__inittest'
     static inline initcall_t __maybe_unused __inittest(void)  \
                                             ^
   include/linux/device.h:1513:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^~~~~~~~~~~
   include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net//ethernet/cortina/gemini.c:2465:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:129:42: note: previous definition of '__inittest' was here
     static inline initcall_t __maybe_unused __inittest(void)  \
                                             ^
   include/linux/device.h:1513:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^~~~~~~~~~~
   include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net//ethernet/cortina/gemini.c:2393:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_port_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:131:6: error: redefinition of 'init_module'
     int init_module(void) __attribute__((alias(#initfn)));
         ^
   include/linux/device.h:1513:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^~~~~~~~~~~
   include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net//ethernet/cortina/gemini.c:2465:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:131:6: note: previous definition of 'init_module' was here
     int init_module(void) __attribute__((alias(#initfn)));
         ^
   include/linux/device.h:1513:1: note: in expansion of macro 'module_init'
    module_init(__driver##_init); \
    ^~~~~~~~~~~
   include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net//ethernet/cortina/gemini.c:2393:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_port_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:135:42: error: redefinition of '__exittest'
     static inline exitcall_t __maybe_unused __exittest(void)  \
                                             ^
   include/linux/device.h:1518:1: note: in expansion of macro 'module_exit'
    module_exit(__driver##_exit);
    ^~~~~~~~~~~
   include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net//ethernet/cortina/gemini.c:2465:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:135:42: note: previous definition of '__exittest' was here
     static inline exitcall_t __maybe_unused __exittest(void)  \
                                             ^
   include/linux/device.h:1518:1: note: in expansion of macro 'module_exit'
    module_exit(__driver##_exit);
    ^~~~~~~~~~~
   include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net//ethernet/cortina/gemini.c:2393:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_port_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:137:7: error: redefinition of 'cleanup_module'
     void cleanup_module(void) __attribute__((alias(#exitfn)));
          ^
   include/linux/device.h:1518:1: note: in expansion of macro 'module_exit'
    module_exit(__driver##_exit);
    ^~~~~~~~~~~
   include/linux/platform_device.h:228:2: note: in expansion of macro 'module_driver'
     module_driver(__platform_driver, platform_driver_register, \
     ^~~~~~~~~~~~~
   drivers/net//ethernet/cortina/gemini.c:2465:1: note: in expansion of macro 'module_platform_driver'
    module_platform_driver(gemini_ethernet_driver);
    ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:137:7: note: previous definition of 'cleanup_module' was here
     void cleanup_module(void) __attribute__((alias(#exitfn)));
          ^
   include/linux/device.h:1518:1: note: in expansion of macro 'module_exit'
    module_exit(__driver##_exit);
    ^~~~~~~~~~~

vim +/dma_to_pfn +715 drivers/net//ethernet/cortina/gemini.c

   681	
   682	static void gmac_cleanup_rxq(struct net_device *netdev)
   683	{
   684		struct gemini_ethernet_port *port = netdev_priv(netdev);
   685		struct gemini_ethernet *geth = port->geth;
   686		struct gmac_rxdesc *rxd = port->rxq_ring;
   687		struct nontoe_qhdr __iomem *qhdr;
   688		void __iomem *dma_reg;
   689		void __iomem *ptr_reg;
   690		dma_addr_t mapping;
   691		union dma_rwptr rw;
   692		unsigned int r, w;
   693		struct page *page;
   694	
   695		qhdr = geth->base +
   696			TOE_DEFAULT_Q_HDR_BASE(netdev->dev_id);
   697		dma_reg = &qhdr->word0;
   698		ptr_reg = &qhdr->word1;
   699	
   700		rw.bits32 = readl(ptr_reg);
   701		r = rw.bits.rptr;
   702		w = rw.bits.wptr;
   703		writew(r, ptr_reg + 2);
   704	
   705		writel(0, dma_reg);
   706	
   707		while (r != w) {
   708			mapping = rxd[r].word2.buf_adr;
   709			r++;
   710			r &= ((1 << port->rxq_order) - 1);
   711	
   712			if (!mapping)
   713				continue;
   714	
 > 715			page = pfn_to_page(dma_to_pfn(geth->dev, mapping));
   716			put_page(page);
   717		}
   718	
   719		dma_free_coherent(geth->dev, sizeof(*port->rxq_ring) << port->rxq_order,
   720				  port->rxq_ring, port->rxq_dma_base);
   721	}
   722	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 44338 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171217/13e70a6e/attachment-0001.gz>
