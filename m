From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 15 Jul 2016 06:52:38 +0800
Subject: [arm-soc:ux500/cleanup 8/11] arch/arm/mach-ux500/cpu-db8500.c:30:16:
 fatal error: id.h: No such file or directory
Message-ID: <201607150635.Kbzn8ZWV%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git ux500/cleanup
head:   a16729ea822806a6f87415bcb523eaeb7f4b4ebd
commit: cd1dc431d02afda521bed53b7c87a678a3ac246f [8/11] ARM: ux500: consolidate soc_device code in id.c
config: arm-u8500_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.3.1-8) 5.3.1 20160205
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout cd1dc431d02afda521bed53b7c87a678a3ac246f
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the arm-soc/ux500/cleanup HEAD a16729ea822806a6f87415bcb523eaeb7f4b4ebd builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

>> arch/arm/mach-ux500/cpu-db8500.c:30:16: fatal error: id.h: No such file or directory
   compilation terminated.

vim +30 arch/arm/mach-ux500/cpu-db8500.c

aa44ef4d4 arch/arm/mach-ux500/cpu-u8500.c  Srinidhi Kasagar 2009-11-28  24  #include <asm/mach/map.h>
b8edf848e arch/arm/mach-ux500/cpu-db8500.c Linus Torvalds   2012-12-13  25  
e657bcf6d arch/arm/mach-ux500/cpu-db8500.c Arnd Bergmann    2013-03-21  26  #include "setup.h"
94bdc0e2d arch/arm/mach-ux500/cpu-u8500.c  Rabin Vincent    2010-03-03  27  
fa86a7647 arch/arm/mach-ux500/cpu-db8500.c Lee Jones        2012-09-27  28  #include "board-mop500.h"
6f6d6433c arch/arm/mach-ux500/cpu-db8500.c Lee Jones        2013-11-06  29  #include "db8500-regs.h"
7a4f26097 arch/arm/mach-ux500/cpu-db8500.c Linus Walleij    2012-09-19 @30  #include "id.h"
fbf1eadf9 arch/arm/mach-ux500/cpu-db8500.c Rabin Vincent    2010-09-29  31  
0d01ab3aa arch/arm/mach-ux500/cpu-db8500.c Sachin Kamat     2014-05-28  32  static void __init u8500_map_io(void)
abf12d719 arch/arm/mach-ux500/cpu-db8500.c Rabin Vincent    2010-12-08  33  {

:::::: The code at line 30 was first introduced by commit
:::::: 7a4f26097d389c16c9956bc03b81532698d97d64 ARM: ux500: de-globalize <mach/id.h>

:::::: TO: Linus Walleij <linus.walleij@linaro.org>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 21054 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160715/256aa4bb/attachment-0001.obj>
