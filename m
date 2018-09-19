From: lkp@intel.com (kbuild test robot)
Date: Thu, 20 Sep 2018 02:36:19 +0800
Subject: [PATCH 1/2] libata: add ledtrig support
In-Reply-To: <1537328730-9156-2-git-send-email-aditya@kobol.io>
References: <1537328730-9156-2-git-send-email-aditya@kobol.io>
Message-ID: <201809200252.JlgK7IS7%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on block/for-next]
[also build test ERROR on v4.19-rc4 next-20180919]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Aditya-Prayoga/Add-support-per-ATA-port-ledtrigger-on-armada-38x/20180920-002037
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: i386-randconfig-s1-201837 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   In file included from drivers/scsi/mvsas/mv_94xx.c:27:0:
>> drivers/scsi/mvsas/mv_94xx.h:294:2: error: redeclaration of enumerator 'LED_OFF'
     LED_OFF = 0,
     ^~~~~~~
   In file included from include/linux/libata.h:41:0,
                    from include/scsi/libsas.h:33,
                    from drivers/scsi/mvsas/mv_sas.h:43,
                    from drivers/scsi/mvsas/mv_94xx.c:26:
   include/linux/leds.h:30:2: note: previous definition of 'LED_OFF' was here
     LED_OFF  = 0,
     ^~~~~~~
   In file included from drivers/scsi/mvsas/mv_94xx.c:27:0:
>> drivers/scsi/mvsas/mv_94xx.h:295:2: error: redeclaration of enumerator 'LED_ON'
     LED_ON = 1,
     ^~~~~~
   In file included from include/linux/libata.h:41:0,
                    from include/scsi/libsas.h:33,
                    from drivers/scsi/mvsas/mv_sas.h:43,
                    from drivers/scsi/mvsas/mv_94xx.c:26:
   include/linux/leds.h:31:2: note: previous definition of 'LED_ON' was here
     LED_ON  = 1,
     ^~~~~~

vim +/LED_OFF +294 drivers/scsi/mvsas/mv_94xx.h

c56f5f1d Wilfried Weissmann 2015-12-27  292  
c56f5f1d Wilfried Weissmann 2015-12-27  293  enum sgpio_led_status {
c56f5f1d Wilfried Weissmann 2015-12-27 @294  	LED_OFF	= 0,
c56f5f1d Wilfried Weissmann 2015-12-27 @295  	LED_ON	= 1,
c56f5f1d Wilfried Weissmann 2015-12-27  296  	LED_BLINKA	= 2,
c56f5f1d Wilfried Weissmann 2015-12-27  297  	LED_BLINKA_INV	= 3,
c56f5f1d Wilfried Weissmann 2015-12-27  298  	LED_BLINKA_SOF	= 4,
c56f5f1d Wilfried Weissmann 2015-12-27  299  	LED_BLINKA_EOF	= 5,
c56f5f1d Wilfried Weissmann 2015-12-27  300  	LED_BLINKB	= 6,
c56f5f1d Wilfried Weissmann 2015-12-27  301  	LED_BLINKB_INV	= 7,
c56f5f1d Wilfried Weissmann 2015-12-27  302  };
c56f5f1d Wilfried Weissmann 2015-12-27  303  

:::::: The code at line 294 was first introduced by commit
:::::: c56f5f1de3a6ab8ec985edbc358e1fd8d4e36a65 mvsas: Add SGPIO support to Marvell 94xx

:::::: TO: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
:::::: CC: Martin K. Petersen <martin.petersen@oracle.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 29628 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180920/0b71692d/attachment-0001.gz>
