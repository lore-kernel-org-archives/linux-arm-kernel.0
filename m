From: lkp@intel.com (kbuild test robot)
Date: Thu, 8 Sep 2016 01:51:54 +0800
Subject: [PATCH V2 2/4] ARM64 LPC: LPC driver implementation on Hip06
In-Reply-To: <1473255233-154297-3-git-send-email-yuanzhichang@hisilicon.com>
Message-ID: <201609080140.jX9o5nfX%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi zhichang.yuan,

[auto build test WARNING on linus/master]
[also build test WARNING on v4.8-rc5 next-20160907]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Zhichang-Yuan/ARM64-LPC-legacy-ISA-I-O-support/20160907-212837
config: arm64-allmodconfig (attached as .config)
compiler: aarch64-linux-gnu-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm64 

All warnings (new ones prefixed by >>):

   drivers/staging/xgifb/vb_init.c: In function 'XGIInitNew':
>> drivers/staging/xgifb/vb_init.c:1363:1: warning: the frame size of 8496 bytes is larger than 8192 bytes [-Wframe-larger-than=]
    } /* end of init */
    ^
--
   drivers/video/fbdev/s3fb.c: In function 's3fb_set_par':
>> drivers/video/fbdev/s3fb.c:911:1: warning: the frame size of 12320 bytes is larger than 8192 bytes [-Wframe-larger-than=]
    }
    ^
--
   drivers/video/fbdev/cirrusfb.c: In function 'cirrusfb_set_par_foo':
>> drivers/video/fbdev/cirrusfb.c:1266:1: warning: the frame size of 8880 bytes is larger than 8192 bytes [-Wframe-larger-than=]
    }
    ^

vim +1363 drivers/staging/xgifb/vb_init.c

d7636e0b apatard at mandriva.com 2010-05-19  1347  
bf32fcb9 Kenji Toyama         2011-04-23  1348  	XGINew_SetDRAMDefaultRegister340(HwDeviceExtension,
bf32fcb9 Kenji Toyama         2011-04-23  1349  					 pVBInfo->P3d4,
bf32fcb9 Kenji Toyama         2011-04-23  1350  					 pVBInfo);
d7636e0b apatard at mandriva.com 2010-05-19  1351  
fab04b97 Aaro Koskinen        2011-12-06  1352  	XGINew_SetDRAMSize_340(xgifb_info, HwDeviceExtension, pVBInfo);
d7636e0b apatard at mandriva.com 2010-05-19  1353  
38c09652 Aaro Koskinen        2012-11-04  1354  	xgifb_reg_set(pVBInfo->P3c4, 0x22, 0xfa);
38c09652 Aaro Koskinen        2012-11-04  1355  	xgifb_reg_set(pVBInfo->P3c4, 0x21, 0xa3);
d7636e0b apatard at mandriva.com 2010-05-19  1356  
b053af16 Aaro Koskinen        2013-07-16  1357  	XGINew_ChkSenseStatus(pVBInfo);
b053af16 Aaro Koskinen        2013-07-16  1358  	XGINew_SetModeScratch(pVBInfo);
a24d60f4 Prashant P. Shah     2010-09-02  1359  
8104e329 Aaro Koskinen        2011-03-13  1360  	xgifb_reg_set(pVBInfo->P3d4, 0x8c, 0x87);
d7636e0b apatard at mandriva.com 2010-05-19  1361  
b9ebf5e5 Aaro Koskinen        2011-03-13  1362  	return 1;
b9ebf5e5 Aaro Koskinen        2011-03-13 @1363  } /* end of init */

:::::: The code at line 1363 was first introduced by commit
:::::: b9ebf5e5913307e67d226e61d953c3c4fd48de99 staging: xgifb: vb_init: move functions to avoid forward declarations

:::::: TO: Aaro Koskinen <aaro.koskinen@iki.fi>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 51358 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/98f4ec17/attachment-0001.obj>
