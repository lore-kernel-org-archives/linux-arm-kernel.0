From: lkp@intel.com (kbuild test robot)
Date: Wed, 10 Oct 2018 03:19:13 +0800
Subject: [xlnx:master 1902/2013]
 drivers/media/platform/xilinx/xilinx-multi-scaler.c:391:18: warning: passing
 argument 1 of 'ioread32' discards 'const volatile' qualifier from pointer
 target type
Message-ID: <201810100308.xR44Z0GI%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   7ea1af329aee531681b87b1fba5496337bff680f
commit: 484cdb2d9f7105aebcd6667344220598ba3e4b93 [1902/2013] platform: xilinx: Add mem to mem Multi-Scaler driver (XM2MSC)
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        git checkout 484cdb2d9f7105aebcd6667344220598ba3e4b93
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers/media/platform/xilinx/xilinx-multi-scaler.c: In function 'xm2msc_readreg':
>> drivers/media/platform/xilinx/xilinx-multi-scaler.c:391:18: warning: passing argument 1 of 'ioread32' discards 'const volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     return ioread32(addr);
                     ^~~~
   In file included from arch/x86/include/asm/io.h:219:0,
                    from arch/x86/include/asm/realmode.h:15,
                    from arch/x86/include/asm/acpi.h:33,
                    from arch/x86/include/asm/fixmap.h:19,
                    from arch/x86/include/asm/apic.h:10,
                    from arch/x86/include/asm/smp.h:13,
                    from include/linux/smp.h:64,
                    from include/linux/percpu.h:7,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from drivers/media/platform/xilinx/xilinx-multi-scaler.c:16:
   include/asm-generic/iomap.h:32:21: note: expected 'void *' but argument is of type 'const volatile void *'
    extern unsigned int ioread32(void __iomem *);
                        ^~~~~~~~
   drivers/media/platform/xilinx/xilinx-multi-scaler.c: In function 'xm2msc_write64reg':
>> drivers/media/platform/xilinx/xilinx-multi-scaler.c:396:34: warning: passing argument 2 of 'iowrite32' discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     iowrite32(lower_32_bits(value), addr);
                                     ^~~~
   In file included from arch/x86/include/asm/io.h:219:0,
                    from arch/x86/include/asm/realmode.h:15,
                    from arch/x86/include/asm/acpi.h:33,
                    from arch/x86/include/asm/fixmap.h:19,
                    from arch/x86/include/asm/apic.h:10,
                    from arch/x86/include/asm/smp.h:13,
                    from include/linux/smp.h:64,
                    from include/linux/percpu.h:7,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from drivers/media/platform/xilinx/xilinx-multi-scaler.c:16:
   include/asm-generic/iomap.h:42:13: note: expected 'void *' but argument is of type 'volatile void *'
    extern void iowrite32(u32, void __iomem *);
                ^~~~~~~~~
   drivers/media/platform/xilinx/xilinx-multi-scaler.c: In function 'xm2msc_writereg':
   drivers/media/platform/xilinx/xilinx-multi-scaler.c:402:19: warning: passing argument 2 of 'iowrite32' discards 'volatile' qualifier from pointer target type [-Wdiscarded-qualifiers]
     iowrite32(value, addr);
                      ^~~~
   In file included from arch/x86/include/asm/io.h:219:0,
                    from arch/x86/include/asm/realmode.h:15,
                    from arch/x86/include/asm/acpi.h:33,
                    from arch/x86/include/asm/fixmap.h:19,
                    from arch/x86/include/asm/apic.h:10,
                    from arch/x86/include/asm/smp.h:13,
                    from include/linux/smp.h:64,
                    from include/linux/percpu.h:7,
                    from include/linux/percpu-rwsem.h:7,
                    from include/linux/fs.h:33,
                    from drivers/media/platform/xilinx/xilinx-multi-scaler.c:16:
   include/asm-generic/iomap.h:42:13: note: expected 'void *' but argument is of type 'volatile void *'
    extern void iowrite32(u32, void __iomem *);
                ^~~~~~~~~
   In file included from include/linux/printk.h:330:0,
                    from include/linux/kernel.h:14,
                    from include/linux/delay.h:22,
                    from drivers/media/platform/xilinx/xilinx-multi-scaler.c:15:
   drivers/media/platform/xilinx/xilinx-multi-scaler.c: In function 'xm2msc_parse_of':
>> drivers/media/platform/xilinx/xilinx-multi-scaler.c:1715:15: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'resource_size_t {aka unsigned int}' [-Wformat=]
     dev_dbg(dev, "IO Mem 0x%llx mapped at %p\n", res->start, xm2msc->regs);
                  ^                               ~~~~~~
   include/linux/dynamic_debug.h:135:39: note: in definition of macro 'dynamic_dev_dbg'
      __dynamic_dev_dbg(&descriptor, dev, fmt, \
                                          ^~~
>> drivers/media/platform/xilinx/xilinx-multi-scaler.c:1715:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(dev, "IO Mem 0x%llx mapped at %p\n", res->start, xm2msc->regs);
     ^~~~~~~

vim +391 drivers/media/platform/xilinx/xilinx-multi-scaler.c

   388	
   389	static inline u32 xm2msc_readreg(const volatile void __iomem *addr)
   390	{
 > 391		return ioread32(addr);
   392	}
   393	
   394	static inline void xm2msc_write64reg(volatile void __iomem *addr, u64 value)
   395	{
 > 396		iowrite32(lower_32_bits(value), addr);
   397		iowrite32(upper_32_bits(value), (void __iomem *)(addr + 4));
   398	}
   399	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 62155 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181010/a4620231/attachment-0001.gz>
