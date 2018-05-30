From: lkp@intel.com (kbuild test robot)
Date: Wed, 30 May 2018 17:42:41 +0800
Subject: [PATCH v4 9/9] drm/mediatek: Add support for mediatek SOC MT2712
In-Reply-To: <1527489507-24453-10-git-send-email-stu.hsieh@mediatek.com>
References: <1527489507-24453-10-git-send-email-stu.hsieh@mediatek.com>
Message-ID: <201805301749.tsuCf08k%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stu,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm/drm-next]
[also build test ERROR on v4.17-rc7 next-20180529]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Stu-Hsieh/Add-support-for-mediatek-SOC-MT2712/20180530-032344
base:   git://people.freedesktop.org/~airlied/linux.git drm-next
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> drivers/gpu//drm/mediatek/mtk_drm_drv.c:165:2: error: 'DDP_COMPONENT_DPI1' undeclared here (not in a function); did you mean 'DDP_COMPONENT_DSI1'?
     DDP_COMPONENT_DPI1,
     ^~~~~~~~~~~~~~~~~~
     DDP_COMPONENT_DSI1
>> drivers/gpu//drm/mediatek/mtk_drm_drv.c:171:2: error: 'DDP_COMPONENT_DSI2' undeclared here (not in a function); did you mean 'DDP_COMPONENT_DSI1'?
     DDP_COMPONENT_DSI2,
     ^~~~~~~~~~~~~~~~~~
     DDP_COMPONENT_DSI1
>> drivers/gpu//drm/mediatek/mtk_drm_drv.c:171:2: error: incompatible types when initializing type 'enum mtk_ddp_comp_id' using type 'const enum mtk_ddp_comp_id *'

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

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 65217 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180530/15cd8e25/attachment-0001.gz>
