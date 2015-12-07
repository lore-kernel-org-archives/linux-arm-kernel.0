From: lkp@intel.com (kbuild test robot)
Date: Tue, 8 Dec 2015 07:00:14 +0800
Subject: [PATCH 22/23] mtd: nand: kill layout field
In-Reply-To: <1449527178-5930-23-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <201512080621.tOyr59r1%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

[auto build test ERROR on next-20151207]
[cannot apply to staging/staging-testing v4.4-rc4 v4.4-rc3 v4.4-rc2 v4.4-rc4]

url:    https://github.com/0day-ci/linux/commits/Boris-Brezillon/mtd-rework-ECC-layout-definition/20151208-063127
config: powerpc-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=powerpc 

All error/warnings (new ones prefixed by >>):

   In file included from include/linux/printk.h:277:0,
                    from include/linux/kernel.h:13,
                    from include/linux/list.h:8,
                    from include/linux/module.h:9,
                    from drivers/mtd/nand/fsl_elbc_nand.c:25:
   drivers/mtd/nand/fsl_elbc_nand.c: In function 'fsl_elbc_chip_init_tail':
>> drivers/mtd/nand/fsl_elbc_nand.c:683:19: error: 'struct nand_ecc_ctrl' has no member named 'layout'
             chip->ecc.layout);
                      ^
   include/linux/dynamic_debug.h:87:9: note: in definition of macro 'dynamic_dev_dbg'
          ##__VA_ARGS__);  \
            ^
>> drivers/mtd/nand/fsl_elbc_nand.c:682:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(priv->dev, "fsl_elbc_init: nand->ecc.layout = %p\n",
     ^
   drivers/mtd/nand/fsl_elbc_nand.c: In function 'fsl_elbc_chip_init':
   drivers/mtd/nand/fsl_elbc_nand.c:797:34: error: 'fsl_elbc_ooblayout_op' undeclared (first use in this function)
      mtd_set_ooblayout(&priv->mtd, &fsl_elbc_ooblayout_op);
                                     ^
   drivers/mtd/nand/fsl_elbc_nand.c:797:34: note: each undeclared identifier is reported only once for each function it appears in

vim +683 drivers/mtd/nand/fsl_elbc_nand.c

3ab8f2a2 Roy Zang   2010-10-18  676  	dev_dbg(priv->dev, "fsl_elbc_init: nand->ecc.steps = %d\n",
76b10467 Scott Wood 2008-02-06  677  	        chip->ecc.steps);
3ab8f2a2 Roy Zang   2010-10-18  678  	dev_dbg(priv->dev, "fsl_elbc_init: nand->ecc.bytes = %d\n",
76b10467 Scott Wood 2008-02-06  679  	        chip->ecc.bytes);
3ab8f2a2 Roy Zang   2010-10-18  680  	dev_dbg(priv->dev, "fsl_elbc_init: nand->ecc.total = %d\n",
76b10467 Scott Wood 2008-02-06  681  	        chip->ecc.total);
3ab8f2a2 Roy Zang   2010-10-18 @682  	dev_dbg(priv->dev, "fsl_elbc_init: nand->ecc.layout = %p\n",
76b10467 Scott Wood 2008-02-06 @683  	        chip->ecc.layout);
3ab8f2a2 Roy Zang   2010-10-18  684  	dev_dbg(priv->dev, "fsl_elbc_init: mtd->flags = %08x\n", mtd->flags);
3ab8f2a2 Roy Zang   2010-10-18  685  	dev_dbg(priv->dev, "fsl_elbc_init: mtd->size = %lld\n", mtd->size);
3ab8f2a2 Roy Zang   2010-10-18  686  	dev_dbg(priv->dev, "fsl_elbc_init: mtd->erasesize = %d\n",

:::::: The code at line 683 was first introduced by commit
:::::: 76b104671632c225ad594a50f9e26ada67bc0a74 [MTD] [NAND] Freescale enhanced Local Bus Controller FCM NAND support.

:::::: TO: Scott Wood <scottwood@freescale.com>
:::::: CC: David Woodhouse <dwmw2@infradead.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 47656 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151208/ddbca2ab/attachment-0001.obj>
