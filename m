From: lkp@intel.com (kbuild test robot)
Date: Tue, 26 Jan 2016 23:29:07 +0800
Subject: [PATCH v8 4/5] iommu/mediatek: Add mt8173 IOMMU driver
In-Reply-To: <1453781562-23556-5-git-send-email-yong.wu@mediatek.com>
Message-ID: <201601262333.ndPokdNZ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.5-rc1 next-20160125]
[cannot apply to iommu/next]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Yong-Wu/MT8173-IOMMU-SUPPORT/20160126-201633
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: arm64-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All error/warnings (new ones prefixed by >>):

   drivers/iommu/mtk_iommu.c: In function 'mtk_iommu_domain_finalise':
>> drivers/iommu/mtk_iommu.c:246:4: error: 'IO_PGTABLE_QUIRK_NO_PERMS' undeclared (first use in this function)
       IO_PGTABLE_QUIRK_NO_PERMS |
       ^
   drivers/iommu/mtk_iommu.c:246:4: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/iommu/mtk_iommu.c:247:4: error: 'IO_PGTABLE_QUIRK_TLBI_ON_MAP' undeclared (first use in this function)
       IO_PGTABLE_QUIRK_TLBI_ON_MAP,
       ^
>> drivers/iommu/mtk_iommu.c:255:34: error: 'ARM_V7S' undeclared (first use in this function)
     dom->iop = alloc_io_pgtable_ops(ARM_V7S, &dom->cfg, data);
                                     ^
   In file included from include/linux/swab.h:4:0,
                    from include/uapi/linux/byteorder/big_endian.h:12,
                    from include/linux/byteorder/big_endian.h:4,
                    from arch/arm64/include/uapi/asm/byteorder.h:20,
                    from include/asm-generic/bitops/le.h:5,
                    from arch/arm64/include/asm/bitops.h:50,
                    from include/linux/bitops.h:36,
                    from include/linux/kernel.h:10,
                    from include/linux/clk.h:16,
                    from drivers/iommu/mtk_iommu.c:14:
>> drivers/iommu/mtk_iommu.c:264:27: error: 'struct io_pgtable_cfg' has no member named 'arm_v7s_cfg'
     writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
                              ^
   include/uapi/linux/swab.h:115:32: note: in definition of macro '__swab32'
     (__builtin_constant_p((__u32)(x)) ? \
                                   ^
   include/linux/byteorder/generic.h:87:21: note: in expansion of macro '__cpu_to_le32'
    #define cpu_to_le32 __cpu_to_le32
                        ^
>> arch/arm64/include/asm/io.h:142:36: note: in expansion of macro 'writel_relaxed'
    #define writel(v,c)  ({ __iowmb(); writel_relaxed((v),(c)); })
                                       ^
>> drivers/iommu/mtk_iommu.c:264:2: note: in expansion of macro 'writel'
     writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
     ^
>> drivers/iommu/mtk_iommu.c:264:27: error: 'struct io_pgtable_cfg' has no member named 'arm_v7s_cfg'
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
>> arch/arm64/include/asm/io.h:142:36: note: in expansion of macro 'writel_relaxed'
    #define writel(v,c)  ({ __iowmb(); writel_relaxed((v),(c)); })
                                       ^
>> drivers/iommu/mtk_iommu.c:264:2: note: in expansion of macro 'writel'
     writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
     ^
>> drivers/iommu/mtk_iommu.c:264:27: error: 'struct io_pgtable_cfg' has no member named 'arm_v7s_cfg'
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
>> arch/arm64/include/asm/io.h:142:36: note: in expansion of macro 'writel_relaxed'
    #define writel(v,c)  ({ __iowmb(); writel_relaxed((v),(c)); })
                                       ^
>> drivers/iommu/mtk_iommu.c:264:2: note: in expansion of macro 'writel'
     writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
     ^
>> drivers/iommu/mtk_iommu.c:264:27: error: 'struct io_pgtable_cfg' has no member named 'arm_v7s_cfg'
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
>> arch/arm64/include/asm/io.h:142:36: note: in expansion of macro 'writel_relaxed'
    #define writel(v,c)  ({ __iowmb(); writel_relaxed((v),(c)); })
                                       ^
>> drivers/iommu/mtk_iommu.c:264:2: note: in expansion of macro 'writel'
     writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
     ^
>> drivers/iommu/mtk_iommu.c:264:27: error: 'struct io_pgtable_cfg' has no member named 'arm_v7s_cfg'
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
>> arch/arm64/include/asm/io.h:142:36: note: in expansion of macro 'writel_relaxed'
    #define writel(v,c)  ({ __iowmb(); writel_relaxed((v),(c)); })
                                       ^
>> drivers/iommu/mtk_iommu.c:264:2: note: in expansion of macro 'writel'
     writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
     ^
>> drivers/iommu/mtk_iommu.c:264:27: error: 'struct io_pgtable_cfg' has no member named 'arm_v7s_cfg'
     writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
                              ^
   include/uapi/linux/swab.h:117:12: note: in definition of macro '__swab32'
     __fswab32(x))
               ^
   include/linux/byteorder/generic.h:87:21: note: in expansion of macro '__cpu_to_le32'
    #define cpu_to_le32 __cpu_to_le32
                        ^
>> arch/arm64/include/asm/io.h:142:36: note: in expansion of macro 'writel_relaxed'
    #define writel(v,c)  ({ __iowmb(); writel_relaxed((v),(c)); })
                                       ^

vim +/IO_PGTABLE_QUIRK_NO_PERMS +246 drivers/iommu/mtk_iommu.c

   240		struct mtk_iommu_domain *dom = data->m4u_dom;
   241	
   242		spin_lock_init(&dom->pgtlock);
   243	
   244		dom->cfg = (struct io_pgtable_cfg) {
   245			.quirks = IO_PGTABLE_QUIRK_ARM_NS |
 > 246				IO_PGTABLE_QUIRK_NO_PERMS |
 > 247				IO_PGTABLE_QUIRK_TLBI_ON_MAP,
   248			.pgsize_bitmap = mtk_iommu_ops.pgsize_bitmap,
   249			.ias = 32,
   250			.oas = 32,
   251			.tlb = &mtk_iommu_gather_ops,
   252			.iommu_dev = data->dev,
   253		};
   254	
 > 255		dom->iop = alloc_io_pgtable_ops(ARM_V7S, &dom->cfg, data);
   256		if (!dom->iop) {
   257			dev_err(data->dev, "Failed to alloc io pgtable\n");
   258			return -EINVAL;
   259		}
   260	
   261		/* Update our support page sizes bitmap */
   262		mtk_iommu_ops.pgsize_bitmap = dom->cfg.pgsize_bitmap;
   263	
 > 264		writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
   265		       data->base + REG_MMU_PT_BASE_ADDR);
   266		return 0;
   267	}

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 48155 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160126/f74fb45c/attachment-0001.obj>
