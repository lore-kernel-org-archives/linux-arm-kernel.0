From: lkp@intel.com (kbuild test robot)
Date: Sun, 22 Jan 2017 13:20:31 +0800
Subject: [PATCH v3 3/3] media: rc: add driver for IR remote receiver on
 MT7623 SoC
In-Reply-To: <1484292939-9454-4-git-send-email-sean.wang@mediatek.com>
Message-ID: <201701221317.Xq3vNLoc%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sean,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.10-rc4 next-20170120]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/sean-wang-mediatek-com/Documentation-devicetree-move-shared-property-used-by-rc-into-a-common-place/20170115-052257
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: sparc64-allyesconfig (attached as .config)
compiler: sparc64-linux-gnu-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=sparc64 

All errors (new ones prefixed by >>):

   drivers/media/rc/mtk-cir.c: In function 'mtk_ir_probe':
>> drivers/media/rc/mtk-cir.c:220:11: error: too many arguments to function 'devm_rc_allocate_device'
     ir->rc = devm_rc_allocate_device(dev, RC_DRIVER_IR_RAW);
              ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/media/rc/mtk-cir.c:22:0:
   include/media/rc-core.h:213:16: note: declared here
    struct rc_dev *devm_rc_allocate_device(struct device *dev);
                   ^~~~~~~~~~~~~~~~~~~~~~~

vim +/devm_rc_allocate_device +220 drivers/media/rc/mtk-cir.c

   214		ir->base = devm_ioremap_resource(dev, res);
   215		if (IS_ERR(ir->base)) {
   216			dev_err(dev, "failed to map registers\n");
   217			return PTR_ERR(ir->base);
   218		}
   219	
 > 220		ir->rc = devm_rc_allocate_device(dev, RC_DRIVER_IR_RAW);
   221		if (!ir->rc) {
   222			dev_err(dev, "failed to allocate device\n");
   223			return -ENOMEM;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 48879 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170122/cb8b30e2/attachment-0001.gz>
