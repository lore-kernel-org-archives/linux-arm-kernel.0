From: lkp@intel.com (kbuild test robot)
Date: Sat, 26 May 2018 00:12:31 +0800
Subject: [PATCH v3 7/8] drm/mediatek: Add support for mediatek SOC MT2712
In-Reply-To: <1527215665-11937-8-git-send-email-stu.hsieh@mediatek.com>
References: <1527215665-11937-8-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <201805252318.rm2j42Sd%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm/drm-next]
[also build test ERROR on v4.17-rc6 next-20180517]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/stu-hsieh-mediatek-com/Add-support-for-mediatek-SOC-MT2712/20180525-211114
base:   git://people.freedesktop.org/~airlied/linux.git drm-next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All error/warnings (new ones prefixed by >>):

>> drivers/gpu//drm/mediatek/mtk_drm_drv.c:165:2: error: 'DDP_COMPONENT_DPI1' undeclared here (not in a function); did you mean 'DDP_COMPONENT_DSI1'?
     DDP_COMPONENT_DPI1,
     ^~~~~~~~~~~~~~~~~~
     DDP_COMPONENT_DSI1
>> drivers/gpu//drm/mediatek/mtk_drm_drv.c:171:2: error: 'DDP_COMPONENT_DSI2' undeclared here (not in a function); did you mean 'DDP_COMPONENT_DSI1'?
     DDP_COMPONENT_DSI2,
     ^~~~~~~~~~~~~~~~~~
     DDP_COMPONENT_DSI1
>> drivers/gpu//drm/mediatek/mtk_drm_drv.c:171:2: error: incompatible types when initializing type 'enum mtk_ddp_comp_id' using type 'const enum mtk_ddp_comp_id *'
>> drivers/gpu//drm/mediatek/mtk_drm_drv.c:207:16: warning: initialization discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     .third_path = mt2712_mtk_ddp_third,
                   ^~~~~~~~~~~~~~~~~~~~

vim +165 drivers/gpu//drm/mediatek/mtk_drm_drv.c

   158	
   159	static const enum mtk_ddp_comp_id mt2712_mtk_ddp_ext[] = {
   160		DDP_COMPONENT_OVL1,
   161		DDP_COMPONENT_COLOR1,
   162		DDP_COMPONENT_AAL1,
   163		DDP_COMPONENT_OD1,
   164		DDP_COMPONENT_RDMA1,
 > 165		DDP_COMPONENT_DPI1,
   166		DDP_COMPONENT_PWM1,
   167	};
   168	
   169	static const enum mtk_ddp_comp_id mt2712_mtk_ddp_third[] = {
   170		DDP_COMPONENT_RDMA2,
 > 171		DDP_COMPONENT_DSI2,
   172		DDP_COMPONENT_PWM2,
   173	};
   174	
   175	static const enum mtk_ddp_comp_id mt8173_mtk_ddp_main[] = {
   176		DDP_COMPONENT_OVL0,
   177		DDP_COMPONENT_COLOR0,
   178		DDP_COMPONENT_AAL0,
   179		DDP_COMPONENT_OD0,
   180		DDP_COMPONENT_RDMA0,
   181		DDP_COMPONENT_UFOE,
   182		DDP_COMPONENT_DSI0,
   183		DDP_COMPONENT_PWM0,
   184	};
   185	
   186	static const enum mtk_ddp_comp_id mt8173_mtk_ddp_ext[] = {
   187		DDP_COMPONENT_OVL1,
   188		DDP_COMPONENT_COLOR1,
   189		DDP_COMPONENT_GAMMA,
   190		DDP_COMPONENT_RDMA1,
   191		DDP_COMPONENT_DPI0,
   192	};
   193	
   194	static const struct mtk_mmsys_driver_data mt2701_mmsys_driver_data = {
   195		.main_path = mt2701_mtk_ddp_main,
   196		.main_len = ARRAY_SIZE(mt2701_mtk_ddp_main),
   197		.ext_path = mt2701_mtk_ddp_ext,
   198		.ext_len = ARRAY_SIZE(mt2701_mtk_ddp_ext),
   199		.shadow_register = true,
   200	};
   201	
   202	static const struct mtk_mmsys_driver_data mt2712_mmsys_driver_data = {
   203		.main_path = mt2712_mtk_ddp_main,
   204		.main_len = ARRAY_SIZE(mt2712_mtk_ddp_main),
   205		.ext_path = mt2712_mtk_ddp_ext,
   206		.ext_len = ARRAY_SIZE(mt2712_mtk_ddp_ext),
 > 207		.third_path = mt2712_mtk_ddp_third,
   208		.third_len = ARRAY_SIZE(mt2712_mtk_ddp_third),
   209	};
   210	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65211 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180526/893bcab4/attachment-0001.gz>
