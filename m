From: lkp@intel.com (kbuild test robot)
Date: Wed, 23 May 2018 16:46:25 +0800
Subject: [rjarzmik:test/daniel 23/34] sound/arm/pxa2xx-ac97.c:27:10: fatal
 error: mach/regs-ac97.h: No such file or directory
Message-ID: <201805231623.n3Qx9qdU%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/rjarzmik/linux test/daniel
head:   f495e2dbc482d8f01a1ee20e86284ee9c0c8fa98
commit: 4cd654b13b9bcc0f206d414497b798ed42df573a [23/34] HACK: select SND_PXA_SOC_SSP for SND_SIMPLE_CARD
config: x86_64-randconfig-s3-05231547 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        git checkout 4cd654b13b9bcc0f206d414497b798ed42df573a
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

>> sound/arm/pxa2xx-ac97.c:27:10: fatal error: mach/regs-ac97.h: No such file or directory
    #include <mach/regs-ac97.h>
             ^~~~~~~~~~~~~~~~~~
   compilation terminated.
--
>> sound/soc/pxa/pxa2xx-i2s.c:28:10: fatal error: mach/hardware.h: No such file or directory
    #include <mach/hardware.h>
             ^~~~~~~~~~~~~~~~~
   compilation terminated.

vim +27 sound/arm/pxa2xx-ac97.c

2c484df0 Takashi Iwai 2005-06-30  26  
1f017a99 Eric Miao    2008-11-28 @27  #include <mach/regs-ac97.h>
a09e64fb Russell King 2008-08-05  28  #include <mach/audio.h>
2c484df0 Takashi Iwai 2005-06-30  29  

:::::: The code at line 27 was first introduced by commit
:::::: 1f017a9964c5b3b9581d3a5732110cb1e0444281 [ARM] pxa: move AC97 register definitions into dedicated regs-ac97.h

:::::: TO: Eric Miao <eric.miao@marvell.com>
:::::: CC: Eric Miao <eric.miao@marvell.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 31184 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180523/2435dd78/attachment-0001.gz>
