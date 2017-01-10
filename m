From: lkp@intel.com (kbuild test robot)
Date: Tue, 10 Jan 2017 20:07:37 +0800
Subject: [PATCH v2 2/2] media: rc: add driver for IR remote receiver on
 MT7623 SoC
In-Reply-To: <1484039631-25120-3-git-send-email-sean.wang@mediatek.com>
Message-ID: <201701102015.fSM15CvI%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

[auto build test ERROR on linuxtv-media/master]
[also build test ERROR on v4.10-rc3 next-20170110]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/sean-wang-mediatek-com/Documentation-devicetree-Add-document-bindings-for-mtk-cir/20170110-193357
base:   git://linuxtv.org/media_tree.git master
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   include/linux/compiler.h:253:8: sparse: attribute 'no_sanitize_address': unknown attribute
   drivers/media/rc/mtk-cir.c:215:41: sparse: too many arguments for function devm_rc_allocate_device
   drivers/media/rc/mtk-cir.c: In function 'mtk_ir_probe':
>> drivers/media/rc/mtk-cir.c:215:11: error: too many arguments to function 'devm_rc_allocate_device'
     ir->rc = devm_rc_allocate_device(dev, RC_DRIVER_IR_RAW);
              ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/media/rc/mtk-cir.c:22:0:
   include/media/rc-core.h:213:16: note: declared here
    struct rc_dev *devm_rc_allocate_device(struct device *dev);
                   ^~~~~~~~~~~~~~~~~~~~~~~

sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:253:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> drivers/media/rc/mtk-cir.c:215:41: sparse: too many arguments for function devm_rc_allocate_device
   drivers/media/rc/mtk-cir.c: In function 'mtk_ir_probe':
   drivers/media/rc/mtk-cir.c:215:11: error: too many arguments to function 'devm_rc_allocate_device'
     ir->rc = devm_rc_allocate_device(dev, RC_DRIVER_IR_RAW);
              ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/media/rc/mtk-cir.c:22:0:
   include/media/rc-core.h:213:16: note: declared here
    struct rc_dev *devm_rc_allocate_device(struct device *dev);
                   ^~~~~~~~~~~~~~~~~~~~~~~

vim +/devm_rc_allocate_device +215 drivers/media/rc/mtk-cir.c

   209		ir->base = devm_ioremap_resource(dev, res);
   210		if (IS_ERR(ir->base)) {
   211			dev_err(dev, "failed to map registers\n");
   212			return PTR_ERR(ir->base);
   213		}
   214	
 > 215		ir->rc = devm_rc_allocate_device(dev, RC_DRIVER_IR_RAW);
   216		if (!ir->rc) {
   217			dev_err(dev, "failed to allocate device\n");
   218			return -ENOMEM;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 57747 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170110/f8a4befc/attachment-0001.gz>
