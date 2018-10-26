From: lkp@intel.com (kbuild test robot)
Date: Fri, 26 Oct 2018 22:21:22 +0800
Subject: [xlnx:master 2116/2130]
 drivers/media/platform/xilinx/xilinx-multi-scaler.c:361:18: warning: passing
 argument 1 of 'ioread32' discards 'const' qualifier from pointer target type
Message-ID: <201810262220.ORU20qSM%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   e0652408f6a3e2464aed159fa83dc3b2a2aadefd
commit: 194a9a06e8d3bac2dc43ff54d5cece3ba6a2e15f [2116/2130] v4l: xilinx-multi-scaler: Remove volatile
config: sh-allyesconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 194a9a06e8d3bac2dc43ff54d5cece3ba6a2e15f
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=sh 

All warnings (new ones prefixed by >>):

   drivers/media/platform/xilinx/xilinx-multi-scaler.c: In function 'xm2msc_readreg':
>> drivers/media/platform/xilinx/xilinx-multi-scaler.c:361:18: warning: passing argument 1 of 'ioread32' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     return ioread32(addr);
                     ^~~~
   In file included from arch/sh/include/asm/io.h:21:0,
                    from include/linux/io.h:25,
                    from include/linux/irq.h:25,
                    from arch/sh/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:13,
                    from drivers/media/platform/xilinx/xilinx-multi-scaler.c:18:
   include/asm-generic/iomap.h:32:21: note: expected 'void *' but argument is of type 'const void *'
    extern unsigned int ioread32(void __iomem *);
                        ^~~~~~~~
   In file included from include/linux/printk.h:330:0,
                    from include/linux/kernel.h:14,
                    from include/linux/delay.h:22,
                    from drivers/media/platform/xilinx/xilinx-multi-scaler.c:15:
   drivers/media/platform/xilinx/xilinx-multi-scaler.c: In function 'xm2msc_parse_of':
   drivers/media/platform/xilinx/xilinx-multi-scaler.c:1782:15: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t {aka unsigned int}' [-Wformat=]
     dev_dbg(dev, "IO Mem 0x%llx mapped at %p\n", res->start, xm2msc->regs);
                  ^                               ~~~~~~
   include/linux/dynamic_debug.h:135:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
   drivers/media/platform/xilinx/xilinx-multi-scaler.c:1782:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(dev, "IO Mem 0x%llx mapped at %p\n", res->start, xm2msc->regs);
     ^~~~~~~
   In file included from arch/sh/include/asm/string.h:3:0,
                    from include/linux/string.h:19,
                    from include/linux/bitmap.h:9,
                    from include/linux/cpumask.h:12,
                    from include/linux/rcupdate.h:44,
                    from include/linux/rculist.h:11,
                    from include/linux/dcache.h:7,
                    from include/linux/fs.h:8,
                    from drivers/media/platform/xilinx/xilinx-multi-scaler.c:16:
   drivers/media/platform/xilinx/xilinx-multi-scaler.c: In function 'xm2msc_querycap':
   arch/sh/include/asm/string_32.h:50:42: warning: array subscript is above array bounds [-Warray-bounds]
      : "0" (__dest), "1" (__src), "r" (__src+__n)
                                        ~~~~~^~~~
   arch/sh/include/asm/string_32.h:50:42: warning: array subscript is above array bounds [-Warray-bounds]
      : "0" (__dest), "1" (__src), "r" (__src+__n)
                                        ~~~~~^~~~

vim +361 drivers/media/platform/xilinx/xilinx-multi-scaler.c

484cdb2d Suresh Gupta 2018-09-17  358  
194a9a06 Suresh Gupta 2018-10-12  359  static inline u32 xm2msc_readreg(const void __iomem *addr)
484cdb2d Suresh Gupta 2018-09-17  360  {
484cdb2d Suresh Gupta 2018-09-17 @361  	return ioread32(addr);
484cdb2d Suresh Gupta 2018-09-17  362  }
484cdb2d Suresh Gupta 2018-09-17  363  

:::::: The code at line 361 was first introduced by commit
:::::: 484cdb2d9f7105aebcd6667344220598ba3e4b93 platform: xilinx: Add mem to mem Multi-Scaler driver (XM2MSC)

:::::: TO: Suresh Gupta <suresh.gupta@xilinx.com>
:::::: CC: Michal Simek <michal.simek@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 47078 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181026/40c545d0/attachment-0001.gz>
