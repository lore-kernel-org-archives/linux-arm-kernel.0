From: lkp@intel.com (kbuild test robot)
Date: Wed, 18 Jul 2018 02:19:29 +0800
Subject: [PATCH v5 06/11] soc: mediatek: add new flow for mtcmos power.
In-Reply-To: <1531817552-17221-7-git-send-email-mars.cheng@mediatek.com>
References: <1531817552-17221-7-git-send-email-mars.cheng@mediatek.com>
Message-ID: <201807180244.Xwu9lTTR%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Owen,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.18-rc5 next-20180717]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mars-Cheng/Add-basic-SoC-support-for-mt6765/20180717-205540
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/soc/mediatek/mtk-scpsys-ext.c:83:5: sparse: symbol 'bus_ctrl_set_release' was not declared. Should it be static?
>> drivers/soc/mediatek/mtk-scpsys-ext.c:114:5: sparse: symbol 'bus_ctrl_set' was not declared. Should it be static?
>> drivers/soc/mediatek/mtk-scpsys-ext.c:119:5: sparse: symbol 'bus_ctrl_release' was not declared. Should it be static?
>> drivers/soc/mediatek/mtk-scpsys-ext.c:124:5: sparse: symbol 'bus_clk_enable_disable' was not declared. Should it be static?
>> drivers/soc/mediatek/mtk-scpsys-ext.c:161:5: sparse: symbol 'bus_clk_enable' was not declared. Should it be static?
>> drivers/soc/mediatek/mtk-scpsys-ext.c:192:27: sparse: symbol 'bus_mask_set_clr_ctrl' was not declared. Should it be static?
>> drivers/soc/mediatek/mtk-scpsys-ext.c:197:26: sparse: symbol 'ext_bus_ctrl' was not declared. Should it be static?
>> drivers/soc/mediatek/mtk-scpsys-ext.c:202:26: sparse: symbol 'ext_cg_ctrl' was not declared. Should it be static?
>> drivers/soc/mediatek/mtk-scpsys-ext.c:210:15: sparse: symbol 'syscon_regmap_lookup_by_phandle_idx' was not declared. Should it be static?
>> drivers/soc/mediatek/mtk-scpsys-ext.c:231:5: sparse: symbol 'scpsys_ext_regmap_init' was not declared. Should it be static?
   include/linux/slab.h:631:13: sparse: undefined identifier '__builtin_mul_overflow'
>> drivers/soc/mediatek/mtk-scpsys-ext.c:324:5: sparse: symbol 'scpsys_ext_clk_init' was not declared. Should it be static?
>> drivers/soc/mediatek/mtk-scpsys-ext.c:336:5: sparse: symbol 'scpsys_ext_attr_init' was not declared. Should it be static?
   include/linux/slab.h:631:13: sparse: call with no type!

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
