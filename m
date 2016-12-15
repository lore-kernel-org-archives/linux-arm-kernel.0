From: fengguang.wu@intel.com (kbuild test robot)
Date: Fri, 16 Dec 2016 00:31:11 +0800
Subject: [stericsson:ab8500-gpadc 1/1] drivers/hwmon/ab8500.c:20:43: fatal
 error: linux/mfd/abx500/ab8500-gpadc.h: No such file or directory
Message-ID: <201612160008.sRNBj2aE%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git ab8500-gpadc
head:   4e7f2be1ec1f1ebfd4912f7f4575e0bfb233e784
commit: 4e7f2be1ec1f1ebfd4912f7f4575e0bfb233e784 [1/1] AB8500 GPADC IIO
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 4e7f2be1ec1f1ebfd4912f7f4575e0bfb233e784
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> drivers/hwmon/ab8500.c:20:43: fatal error: linux/mfd/abx500/ab8500-gpadc.h: No such file or directory
    #include <linux/mfd/abx500/ab8500-gpadc.h>
                                              ^
   compilation terminated.
--
>> drivers/power/supply/ab8500_charger.c:32:43: fatal error: linux/mfd/abx500/ab8500-gpadc.h: No such file or directory
    #include <linux/mfd/abx500/ab8500-gpadc.h>
                                              ^
   compilation terminated.
--
>> drivers/power/supply/ab8500_fg.c:35:43: fatal error: linux/mfd/abx500/ab8500-gpadc.h: No such file or directory
    #include <linux/mfd/abx500/ab8500-gpadc.h>
                                              ^
   compilation terminated.
--
>> drivers/power/supply/ab8500_btemp.c:29:43: fatal error: linux/mfd/abx500/ab8500-gpadc.h: No such file or directory
    #include <linux/mfd/abx500/ab8500-gpadc.h>
                                              ^
   compilation terminated.

vim +20 drivers/hwmon/ab8500.c

0bbb06ed Hongbo Zhang  2013-04-03   4   *         Hongbo Zhang <hongbo.zhang@linaro.org>
0bbb06ed Hongbo Zhang  2013-04-03   5   * License Terms: GNU General Public License v2
0bbb06ed Hongbo Zhang  2013-04-03   6   *
0bbb06ed Hongbo Zhang  2013-04-03   7   * When the AB8500 thermal warning temperature is reached (threshold cannot
0bbb06ed Hongbo Zhang  2013-04-03   8   * be changed by SW), an interrupt is set, and if no further action is taken
3afb57fa Guenter Roeck 2014-09-29   9   * within a certain time frame, kernel_power_off will be called.
0bbb06ed Hongbo Zhang  2013-04-03  10   *
0bbb06ed Hongbo Zhang  2013-04-03  11   * When AB8500 thermal shutdown temperature is reached a hardware shutdown of
0bbb06ed Hongbo Zhang  2013-04-03  12   * the AB8500 will occur.
0bbb06ed Hongbo Zhang  2013-04-03  13   */
0bbb06ed Hongbo Zhang  2013-04-03  14  
0bbb06ed Hongbo Zhang  2013-04-03  15  #include <linux/err.h>
0bbb06ed Hongbo Zhang  2013-04-03  16  #include <linux/hwmon.h>
0bbb06ed Hongbo Zhang  2013-04-03  17  #include <linux/hwmon-sysfs.h>
0bbb06ed Hongbo Zhang  2013-04-03  18  #include <linux/mfd/abx500.h>
0bbb06ed Hongbo Zhang  2013-04-03  19  #include <linux/mfd/abx500/ab8500-bm.h>
0bbb06ed Hongbo Zhang  2013-04-03 @20  #include <linux/mfd/abx500/ab8500-gpadc.h>
0bbb06ed Hongbo Zhang  2013-04-03  21  #include <linux/module.h>
0bbb06ed Hongbo Zhang  2013-04-03  22  #include <linux/platform_device.h>
0bbb06ed Hongbo Zhang  2013-04-03  23  #include <linux/power/ab8500.h>
3afb57fa Guenter Roeck 2014-09-29  24  #include <linux/reboot.h>
0bbb06ed Hongbo Zhang  2013-04-03  25  #include <linux/slab.h>
0bbb06ed Hongbo Zhang  2013-04-03  26  #include <linux/sysfs.h>
0bbb06ed Hongbo Zhang  2013-04-03  27  #include "abx500.h"
0bbb06ed Hongbo Zhang  2013-04-03  28  

:::::: The code at line 20 was first introduced by commit
:::::: 0bbb06ed564d211d10eae12bdb423fce6178468f hwmon: Add ST-Ericsson ABX500 hwmon driver

:::::: TO: Hongbo Zhang <hongbo.zhang@linaro.org>
:::::: CC: Anton Vorontsov <anton@enomsg.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 60059 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161216/315ba469/attachment-0001.gz>
