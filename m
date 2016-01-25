From: lkp@intel.com (kbuild test robot)
Date: Mon, 25 Jan 2016 20:48:33 +0800
Subject: [PATCH V3 2/2] regulator: mt6323: Add support for MT6323 regulator
In-Reply-To: <1453722989-41622-2-git-send-email-blogic@openwrt.org>
Message-ID: <201601252014.ogTG5JRy%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen,

[auto build test ERROR on regulator/for-next]
[also build test ERROR on v4.5-rc1 next-20160125]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/John-Crispin/dt-bindings-regulator-Add-document-for-MT6323-regulator/20160125-184401
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next
config: m68k-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=m68k 

All errors (new ones prefixed by >>):

>> drivers/regulator/mt6323-regulator.c:20:40: fatal error: linux/mfd/mt6323/registers.h: No such file or directory
    #include <linux/mfd/mt6323/registers.h>
                                           ^
   compilation terminated.

vim +20 drivers/regulator/mt6323-regulator.c

    14	
    15	#include <linux/module.h>
    16	#include <linux/of.h>
    17	#include <linux/platform_device.h>
    18	#include <linux/regmap.h>
    19	#include <linux/mfd/mt6397/core.h>
  > 20	#include <linux/mfd/mt6323/registers.h>
    21	#include <linux/regulator/driver.h>
    22	#include <linux/regulator/machine.h>
    23	#include <linux/regulator/mt6323-regulator.h>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 35266 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160125/9a0e9490/attachment-0001.obj>
