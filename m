From: lkp@intel.com (kbuild test robot)
Date: Tue, 23 Oct 2018 01:14:23 +0800
Subject: [v9 2/7] dmaengine: fsldma: Adding macro FSL_DMA_IN/OUT
 implement for ARM platform
In-Reply-To: <20181017055957.542-2-peng.ma@nxp.com>
References: <20181017055957.542-2-peng.ma@nxp.com>
Message-ID: <201810230103.1SquAJF2%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux-sof-driver/master]
[also build test WARNING on v4.19 next-20181019]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Peng-Ma/dmaengine-fsldma-Replace-DMA_IN-OUT-by-FSL_DMA_IN-OUT/20181017-232444
base:   https://github.com/thesofproject/linux master
config: powerpc-xes_mpc85xx_defconfig (attached as .config)
compiler: powerpc-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=powerpc 

All warnings (new ones prefixed by >>):

   In file included from drivers/dma/fsldma.c:41:0:
   drivers/dma/fsldma.h: In function 'fsl_ioread64':
>> drivers/dma/fsldma.h:210:17: warning: passing argument 1 of 'in_le32' makes pointer from integer without a cast [-Wint-conversion]
     return in_le32(fsl_addr) | in_le32(fsl_addr + 1) << 32;
                    ^~~~~~~~
   In file included from include/linux/io.h:25:0,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from include/linux/pci.h:32,
                    from drivers/dma/fsldma.c:29:
   arch/powerpc/include/asm/io.h:172:15: note: expected 'const volatile u32 * {aka const volatile unsigned int *}' but argument is of type 'u32 {aka unsigned int}'
    DEF_MMIO_IN_X(in_le32, 32, lwbrx);
                  ^
   arch/powerpc/include/asm/io.h:131:23: note: in definition of macro 'DEF_MMIO_IN_X'
    static inline u##size name(const volatile u##size __iomem *addr) \
                          ^~~~
   In file included from drivers/dma/fsldma.c:41:0:
   drivers/dma/fsldma.h:210:37: warning: passing argument 1 of 'in_le32' makes pointer from integer without a cast [-Wint-conversion]
     return in_le32(fsl_addr) | in_le32(fsl_addr + 1) << 32;
                                        ^~~~~~~~
   In file included from include/linux/io.h:25:0,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from include/linux/pci.h:32,
                    from drivers/dma/fsldma.c:29:
   arch/powerpc/include/asm/io.h:172:15: note: expected 'const volatile u32 * {aka const volatile unsigned int *}' but argument is of type 'u32 {aka unsigned int}'
    DEF_MMIO_IN_X(in_le32, 32, lwbrx);
                  ^
   arch/powerpc/include/asm/io.h:131:23: note: in definition of macro 'DEF_MMIO_IN_X'
    static inline u##size name(const volatile u##size __iomem *addr) \
                          ^~~~
   In file included from drivers/dma/fsldma.c:41:0:
>> drivers/dma/fsldma.h:210:51: warning: left shift count >= width of type [-Wshift-count-overflow]
     return in_le32(fsl_addr) | in_le32(fsl_addr + 1) << 32;
                                                      ^~
   drivers/dma/fsldma.h: In function 'fsl_ioread64be':
>> drivers/dma/fsldma.h:223:17: warning: passing argument 1 of 'in_be32' makes pointer from integer without a cast [-Wint-conversion]
     return in_be32(fsl_addr + 1) | in_be32(fsl_addr) << 32;
                    ^~~~~~~~
   In file included from include/linux/io.h:25:0,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from include/linux/pci.h:32,
                    from drivers/dma/fsldma.c:29:
   arch/powerpc/include/asm/io.h:170:15: note: expected 'const volatile u32 * {aka const volatile unsigned int *}' but argument is of type 'u32 {aka unsigned int}'
    DEF_MMIO_IN_D(in_be32, 32, lwz);
                  ^
   arch/powerpc/include/asm/io.h:149:23: note: in definition of macro 'DEF_MMIO_IN_D'
    static inline u##size name(const volatile u##size __iomem *addr) \
                          ^~~~
   In file included from drivers/dma/fsldma.c:41:0:
   drivers/dma/fsldma.h:223:41: warning: passing argument 1 of 'in_be32' makes pointer from integer without a cast [-Wint-conversion]
     return in_be32(fsl_addr + 1) | in_be32(fsl_addr) << 32;
                                            ^~~~~~~~
   In file included from include/linux/io.h:25:0,
                    from include/linux/irq.h:20,
                    from arch/powerpc/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from include/linux/pci.h:32,
                    from drivers/dma/fsldma.c:29:
   arch/powerpc/include/asm/io.h:170:15: note: expected 'const volatile u32 * {aka const volatile unsigned int *}' but argument is of type 'u32 {aka unsigned int}'
    DEF_MMIO_IN_D(in_be32, 32, lwz);
                  ^
   arch/powerpc/include/asm/io.h:149:23: note: in definition of macro 'DEF_MMIO_IN_D'
    static inline u##size name(const volatile u##size __iomem *addr) \
                          ^~~~
   In file included from drivers/dma/fsldma.c:41:0:
   drivers/dma/fsldma.h:223:51: warning: left shift count >= width of type [-Wshift-count-overflow]
     return in_be32(fsl_addr + 1) | in_be32(fsl_addr) << 32;
                                                      ^~

vim +/in_le32 +210 drivers/dma/fsldma.h

   204	
   205	#ifndef __powerpc64__
   206	static u64 fsl_ioread64(const u64 __iomem *addr)
   207	{
   208		u32 fsl_addr = lower_32_bits(addr);
   209	
 > 210		return in_le32(fsl_addr) | in_le32(fsl_addr + 1) << 32;
   211	}
   212	
   213	static void fsl_iowrite64(u64 val, u64 __iomem *addr)
   214	{
   215		out_le32((u32 __iomem *)addr + 1, val >> 32);
   216		out_le32((u32 __iomem *)addr, (u32)val);
   217	}
   218	
   219	static u64 fsl_ioread64be(const u64 __iomem *addr)
   220	{
   221		u32 fsl_addr = lower_32_bits(addr);
   222	
 > 223		return in_be32(fsl_addr + 1) | in_be32(fsl_addr) << 32;
   224	}
   225	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 17785 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181023/e67f88ef/attachment-0001.gz>
