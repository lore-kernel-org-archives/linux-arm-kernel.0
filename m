From: lkp@intel.com (kbuild test robot)
Date: Wed, 27 Jan 2016 03:26:31 +0800
Subject: [PATCH v8 4/5] iommu/mediatek: Add mt8173 IOMMU driver
In-Reply-To: <1453781562-23556-5-git-send-email-yong.wu@mediatek.com>
Message-ID: <201601270334.RzVkANAg%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong,

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.5-rc1 next-20160125]
[cannot apply to iommu/next]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Yong-Wu/MT8173-IOMMU-SUPPORT/20160126-201633
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: arm-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   drivers/iommu/mtk_iommu.c: In function 'mtk_iommu_domain_finalise':
   drivers/iommu/mtk_iommu.c:246:4: error: 'IO_PGTABLE_QUIRK_NO_PERMS' undeclared (first use in this function)
       IO_PGTABLE_QUIRK_NO_PERMS |
       ^
   drivers/iommu/mtk_iommu.c:246:4: note: each undeclared identifier is reported only once for each function it appears in
   drivers/iommu/mtk_iommu.c:247:4: error: 'IO_PGTABLE_QUIRK_TLBI_ON_MAP' undeclared (first use in this function)
       IO_PGTABLE_QUIRK_TLBI_ON_MAP,
       ^
   drivers/iommu/mtk_iommu.c:255:34: error: 'ARM_V7S' undeclared (first use in this function)
     dom->iop = alloc_io_pgtable_ops(ARM_V7S, &dom->cfg, data);
                                     ^
   In file included from include/linux/swab.h:4:0,
                    from include/uapi/linux/byteorder/big_endian.h:12,
                    from include/linux/byteorder/big_endian.h:4,
                    from arch/arm/include/uapi/asm/byteorder.h:19,
                    from include/asm-generic/bitops/le.h:5,
                    from arch/arm/include/asm/bitops.h:340,
                    from include/linux/bitops.h:36,
                    from include/linux/kernel.h:10,
                    from include/linux/clk.h:16,
                    from drivers/iommu/mtk_iommu.c:14:
   drivers/iommu/mtk_iommu.c:264:27: error: 'struct io_pgtable_cfg' has no member named 'arm_v7s_cfg'
     writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
                              ^
   include/uapi/linux/swab.h:115:32: note: in definition of macro '__swab32'
     (__builtin_constant_p((__u32)(x)) ? \
                                   ^
   include/linux/byteorder/generic.h:87:21: note: in expansion of macro '__cpu_to_le32'
    #define cpu_to_le32 __cpu_to_le32
                        ^
>> arch/arm/include/asm/io.h:305:36: note: in expansion of macro 'writel_relaxed'
    #define writel(v,c)  ({ __iowmb(); writel_relaxed(v,c); })
                                       ^
   drivers/iommu/mtk_iommu.c:264:2: note: in expansion of macro 'writel'
     writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
     ^
   drivers/iommu/mtk_iommu.c:264:27: error: 'struct io_pgtable_cfg' has no member named 'arm_v7s_cfg'
     writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
                              ^
   include/uapi/linux/swab.h:17:12: note: in definition of macro '___constant_swab32'
     (((__u32)(x) & (__u32)0x000000ffUL) << 24) |  \
               ^
   include/uapi/linux/byteorder/big_endian.h:32:43: note: in expansion of macro '__swab32'
    #define __cpu_to_le32(x) ((__force __le32)__swab32((x)))
                                              ^
   include/linux/byteorder/generic.h:87:21: note: in expansion of macro '__cpu_to_le32'
    #define cpu_to_le32 __cpu_to_le32
                        ^
>> arch/arm/include/asm/io.h:305:36: note: in expansion of macro 'writel_relaxed'
    #define writel(v,c)  ({ __iowmb(); writel_relaxed(v,c); })
                                       ^
   drivers/iommu/mtk_iommu.c:264:2: note: in expansion of macro 'writel'
     writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
     ^
   drivers/iommu/mtk_iommu.c:264:27: error: 'struct io_pgtable_cfg' has no member named 'arm_v7s_cfg'
     writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
                              ^
   include/uapi/linux/swab.h:18:12: note: in definition of macro '___constant_swab32'
     (((__u32)(x) & (__u32)0x0000ff00UL) <<  8) |  \
               ^
   include/uapi/linux/byteorder/big_endian.h:32:43: note: in expansion of macro '__swab32'
    #define __cpu_to_le32(x) ((__force __le32)__swab32((x)))
                                              ^
   include/linux/byteorder/generic.h:87:21: note: in expansion of macro '__cpu_to_le32'
    #define cpu_to_le32 __cpu_to_le32
                        ^
>> arch/arm/include/asm/io.h:305:36: note: in expansion of macro 'writel_relaxed'
    #define writel(v,c)  ({ __iowmb(); writel_relaxed(v,c); })
                                       ^
   drivers/iommu/mtk_iommu.c:264:2: note: in expansion of macro 'writel'
     writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
     ^
   drivers/iommu/mtk_iommu.c:264:27: error: 'struct io_pgtable_cfg' has no member named 'arm_v7s_cfg'
     writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
                              ^
   include/uapi/linux/swab.h:19:12: note: in definition of macro '___constant_swab32'
     (((__u32)(x) & (__u32)0x00ff0000UL) >>  8) |  \
               ^
   include/uapi/linux/byteorder/big_endian.h:32:43: note: in expansion of macro '__swab32'
    #define __cpu_to_le32(x) ((__force __le32)__swab32((x)))
                                              ^
   include/linux/byteorder/generic.h:87:21: note: in expansion of macro '__cpu_to_le32'
    #define cpu_to_le32 __cpu_to_le32
                        ^
>> arch/arm/include/asm/io.h:305:36: note: in expansion of macro 'writel_relaxed'
    #define writel(v,c)  ({ __iowmb(); writel_relaxed(v,c); })
                                       ^
   drivers/iommu/mtk_iommu.c:264:2: note: in expansion of macro 'writel'
     writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
     ^
   drivers/iommu/mtk_iommu.c:264:27: error: 'struct io_pgtable_cfg' has no member named 'arm_v7s_cfg'
     writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
                              ^
   include/uapi/linux/swab.h:20:12: note: in definition of macro '___constant_swab32'
     (((__u32)(x) & (__u32)0xff000000UL) >> 24)))
               ^
   include/uapi/linux/byteorder/big_endian.h:32:43: note: in expansion of macro '__swab32'
    #define __cpu_to_le32(x) ((__force __le32)__swab32((x)))
                                              ^
   include/linux/byteorder/generic.h:87:21: note: in expansion of macro '__cpu_to_le32'
    #define cpu_to_le32 __cpu_to_le32
                        ^
>> arch/arm/include/asm/io.h:305:36: note: in expansion of macro 'writel_relaxed'
    #define writel(v,c)  ({ __iowmb(); writel_relaxed(v,c); })
                                       ^
   drivers/iommu/mtk_iommu.c:264:2: note: in expansion of macro 'writel'
     writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
     ^
   drivers/iommu/mtk_iommu.c:264:27: error: 'struct io_pgtable_cfg' has no member named 'arm_v7s_cfg'
     writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
                              ^
   include/uapi/linux/swab.h:117:12: note: in definition of macro '__swab32'
     __fswab32(x))
               ^
   include/linux/byteorder/generic.h:87:21: note: in expansion of macro '__cpu_to_le32'
    #define cpu_to_le32 __cpu_to_le32
                        ^
>> arch/arm/include/asm/io.h:305:36: note: in expansion of macro 'writel_relaxed'
    #define writel(v,c)  ({ __iowmb(); writel_relaxed(v,c); })
                                       ^
   drivers/iommu/mtk_iommu.c:264:2: note: in expansion of macro 'writel'
     writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
     ^
   drivers/iommu/mtk_iommu.c: In function 'mtk_iommu_resume':
   drivers/iommu/mtk_iommu.c:681:35: error: 'struct io_pgtable_cfg' has no member named 'arm_v7s_cfg'
     writel_relaxed(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
                                      ^
   include/uapi/linux/swab.h:115:32: note: in definition of macro '__swab32'
     (__builtin_constant_p((__u32)(x)) ? \
                                   ^
   include/linux/byteorder/generic.h:87:21: note: in expansion of macro '__cpu_to_le32'
    #define cpu_to_le32 __cpu_to_le32
                        ^
   drivers/iommu/mtk_iommu.c:681:2: note: in expansion of macro 'writel_relaxed'
     writel_relaxed(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
     ^
   drivers/iommu/mtk_iommu.c:681:35: error: 'struct io_pgtable_cfg' has no member named 'arm_v7s_cfg'
     writel_relaxed(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
                                      ^
   include/uapi/linux/swab.h:17:12: note: in definition of macro '___constant_swab32'
     (((__u32)(x) & (__u32)0x000000ffUL) << 24) |  \
               ^
   include/uapi/linux/byteorder/big_endian.h:32:43: note: in expansion of macro '__swab32'
    #define __cpu_to_le32(x) ((__force __le32)__swab32((x)))
                                              ^
   include/linux/byteorder/generic.h:87:21: note: in expansion of macro '__cpu_to_le32'
    #define cpu_to_le32 __cpu_to_le32
                        ^
   drivers/iommu/mtk_iommu.c:681:2: note: in expansion of macro 'writel_relaxed'
     writel_relaxed(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
     ^
   drivers/iommu/mtk_iommu.c:681:35: error: 'struct io_pgtable_cfg' has no member named 'arm_v7s_cfg'
     writel_relaxed(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
                                      ^
   include/uapi/linux/swab.h:18:12: note: in definition of macro '___constant_swab32'
     (((__u32)(x) & (__u32)0x0000ff00UL) <<  8) |  \
               ^
   include/uapi/linux/byteorder/big_endian.h:32:43: note: in expansion of macro '__swab32'
    #define __cpu_to_le32(x) ((__force __le32)__swab32((x)))
                                              ^
   include/linux/byteorder/generic.h:87:21: note: in expansion of macro '__cpu_to_le32'
    #define cpu_to_le32 __cpu_to_le32
                        ^
   drivers/iommu/mtk_iommu.c:681:2: note: in expansion of macro 'writel_relaxed'
     writel_relaxed(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
     ^
   drivers/iommu/mtk_iommu.c:681:35: error: 'struct io_pgtable_cfg' has no member named 'arm_v7s_cfg'
     writel_relaxed(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
                                      ^
   include/uapi/linux/swab.h:19:12: note: in definition of macro '___constant_swab32'
     (((__u32)(x) & (__u32)0x00ff0000UL) >>  8) |  \
               ^
   include/uapi/linux/byteorder/big_endian.h:32:43: note: in expansion of macro '__swab32'
    #define __cpu_to_le32(x) ((__force __le32)__swab32((x)))
                                              ^
   include/linux/byteorder/generic.h:87:21: note: in expansion of macro '__cpu_to_le32'
    #define cpu_to_le32 __cpu_to_le32
                        ^
   drivers/iommu/mtk_iommu.c:681:2: note: in expansion of macro 'writel_relaxed'
     writel_relaxed(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
     ^
   drivers/iommu/mtk_iommu.c:681:35: error: 'struct io_pgtable_cfg' has no member named 'arm_v7s_cfg'
     writel_relaxed(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
                                      ^
   include/uapi/linux/swab.h:20:12: note: in definition of macro '___constant_swab32'
     (((__u32)(x) & (__u32)0xff000000UL) >> 24)))
               ^
   include/uapi/linux/byteorder/big_endian.h:32:43: note: in expansion of macro '__swab32'
    #define __cpu_to_le32(x) ((__force __le32)__swab32((x)))
                                              ^
   include/linux/byteorder/generic.h:87:21: note: in expansion of macro '__cpu_to_le32'
    #define cpu_to_le32 __cpu_to_le32
                        ^
   drivers/iommu/mtk_iommu.c:681:2: note: in expansion of macro 'writel_relaxed'
     writel_relaxed(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
     ^
   drivers/iommu/mtk_iommu.c:681:35: error: 'struct io_pgtable_cfg' has no member named 'arm_v7s_cfg'
     writel_relaxed(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
                                      ^
   include/uapi/linux/swab.h:117:12: note: in definition of macro '__swab32'
     __fswab32(x))
               ^
   include/linux/byteorder/generic.h:87:21: note: in expansion of macro '__cpu_to_le32'
    #define cpu_to_le32 __cpu_to_le32
                        ^
   drivers/iommu/mtk_iommu.c:681:2: note: in expansion of macro 'writel_relaxed'
     writel_relaxed(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
     ^

vim +/writel_relaxed +305 arch/arm/include/asm/io.h

5621caac arch/arm/include/asm/io.h Rob Herring     2012-02-10  289  #define readb_relaxed(c) ({ u8  __r = __raw_readb(c); __r; })
b0c1264f arch/arm/include/asm/io.h Olof Johansson  2011-10-04  290  #define readw_relaxed(c) ({ u16 __r = le16_to_cpu((__force __le16) \
5621caac arch/arm/include/asm/io.h Rob Herring     2012-02-10  291  					__raw_readw(c)); __r; })
b0c1264f arch/arm/include/asm/io.h Olof Johansson  2011-10-04  292  #define readl_relaxed(c) ({ u32 __r = le32_to_cpu((__force __le32) \
5621caac arch/arm/include/asm/io.h Rob Herring     2012-02-10  293  					__raw_readl(c)); __r; })
e936771a arch/arm/include/asm/io.h Catalin Marinas 2010-07-28  294  
af06bb9f arch/arm/include/asm/io.h Russell King    2012-05-25  295  #define writeb_relaxed(v,c)	__raw_writeb(v,c)
af06bb9f arch/arm/include/asm/io.h Russell King    2012-05-25  296  #define writew_relaxed(v,c)	__raw_writew((__force u16) cpu_to_le16(v),c)
af06bb9f arch/arm/include/asm/io.h Russell King    2012-05-25  297  #define writel_relaxed(v,c)	__raw_writel((__force u32) cpu_to_le32(v),c)
e936771a arch/arm/include/asm/io.h Catalin Marinas 2010-07-28  298  
b92b3612 arch/arm/include/asm/io.h Russell King    2010-07-29  299  #define readb(c)		({ u8  __v = readb_relaxed(c); __iormb(); __v; })
b92b3612 arch/arm/include/asm/io.h Russell King    2010-07-29  300  #define readw(c)		({ u16 __v = readw_relaxed(c); __iormb(); __v; })
b92b3612 arch/arm/include/asm/io.h Russell King    2010-07-29  301  #define readl(c)		({ u32 __v = readl_relaxed(c); __iormb(); __v; })
b92b3612 arch/arm/include/asm/io.h Russell King    2010-07-29  302  
b92b3612 arch/arm/include/asm/io.h Russell King    2010-07-29  303  #define writeb(v,c)		({ __iowmb(); writeb_relaxed(v,c); })
b92b3612 arch/arm/include/asm/io.h Russell King    2010-07-29  304  #define writew(v,c)		({ __iowmb(); writew_relaxed(v,c); })
b92b3612 arch/arm/include/asm/io.h Russell King    2010-07-29 @305  #define writel(v,c)		({ __iowmb(); writel_relaxed(v,c); })
b92b3612 arch/arm/include/asm/io.h Russell King    2010-07-29  306  
5621caac arch/arm/include/asm/io.h Rob Herring     2012-02-10  307  #define readsb(p,d,l)		__raw_readsb(p,d,l)
5621caac arch/arm/include/asm/io.h Rob Herring     2012-02-10  308  #define readsw(p,d,l)		__raw_readsw(p,d,l)
5621caac arch/arm/include/asm/io.h Rob Herring     2012-02-10  309  #define readsl(p,d,l)		__raw_readsl(p,d,l)
^1da177e include/asm-arm/io.h      Linus Torvalds  2005-04-16  310  
5621caac arch/arm/include/asm/io.h Rob Herring     2012-02-10  311  #define writesb(p,d,l)		__raw_writesb(p,d,l)
5621caac arch/arm/include/asm/io.h Rob Herring     2012-02-10  312  #define writesw(p,d,l)		__raw_writesw(p,d,l)
5621caac arch/arm/include/asm/io.h Rob Herring     2012-02-10  313  #define writesl(p,d,l)		__raw_writesl(p,d,l)

:::::: The code at line 305 was first introduced by commit
:::::: b92b3612134faff171981fad4f0adb33f485e02e ARM: Add barriers to io{read,write}{8,16,32} accessors as well

:::::: TO: Russell King <rmk+kernel@arm.linux.org.uk>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 56138 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/c36f54d9/attachment-0001.obj>
