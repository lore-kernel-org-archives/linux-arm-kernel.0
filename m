From: lkp@intel.com (kbuild test robot)
Date: Mon, 8 Feb 2016 20:14:08 +0800
Subject: [PATCH V4 2/2] regulator: mt6323: Add support for MT6323 regulator
In-Reply-To: <1453896059-44589-2-git-send-email-blogic@openwrt.org>
Message-ID: <201602082052.nbLmVvYd%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen,

[auto build test ERROR on regulator/for-next]
[also build test ERROR on v4.5-rc3 next-20160208]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/John-Crispin/regulator-Add-document-for-MT6323-regulator/20160127-200434
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
config: frv-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=frv 

All errors (new ones prefixed by >>):

>> drivers/regulator/mt6323-regulator.c:15:40: fatal error: linux/mfd/mt6323/registers.h: No such file or directory
    #include <linux/mfd/mt6323/registers.h>
                                           ^
   compilation terminated.

vim +15 drivers/regulator/mt6323-regulator.c

     9	
    10	#include <linux/module.h>
    11	#include <linux/of.h>
    12	#include <linux/platform_device.h>
    13	#include <linux/regmap.h>
    14	#include <linux/mfd/mt6397/core.h>
  > 15	#include <linux/mfd/mt6323/registers.h>
    16	#include <linux/regulator/driver.h>
    17	#include <linux/regulator/machine.h>
    18	#include <linux/regulator/mt6323-regulator.h>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 42503 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160208/c1aaa3e3/attachment-0001.obj>
