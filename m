From: fengguang.wu@intel.com (kbuild test robot)
Date: Thu, 1 Sep 2016 07:40:37 +0800
Subject: [arm:sa1100 22/78] arch/arm/mach-pxa/lubbock.c:16:33: fatal error:
 linux/gpip/gpio-reg.h: No such file or directory
Message-ID: <201609010735.0F5LJAkQ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   http://repo.or.cz/linux-2.6/linux-2.6-arm.git sa1100
head:   0f779cd824db07228231ffef10b56292c0bb1e4f
commit: f11176f5d0535e0ddd1ab5895f940664893e31ca [22/78] ARM: pxa/lubbock: add GPIO driver for LUB_MISC_WR register
config: arm-pxa_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout f11176f5d0535e0ddd1ab5895f940664893e31ca
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> arch/arm/mach-pxa/lubbock.c:16:33: fatal error: linux/gpip/gpio-reg.h: No such file or directory
   compilation terminated.

vim +16 arch/arm/mach-pxa/lubbock.c

    10	 *  This program is free software; you can redistribute it and/or modify
    11	 *  it under the terms of the GNU General Public License version 2 as
    12	 *  published by the Free Software Foundation.
    13	 */
    14	#include <linux/clkdev.h>
    15	#include <linux/gpio.h>
  > 16	#include <linux/gpip/gpio-reg.h>
    17	#include <linux/gpio/machine.h>
    18	#include <linux/module.h>
    19	#include <linux/kernel.h>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 30832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160901/b7256942/attachment-0001.obj>
