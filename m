From: lkp@intel.com (kbuild test robot)
Date: Mon, 19 Mar 2018 04:38:32 +0800
Subject: [PATCH 1/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
References: <71fab82672524b95632cdb588c16edfc9711866a.1521246069.git.collinsd@codeaurora.org>
Message-ID: <201803190418.tpCHIYzR%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v4.16-rc4]
[also build test ERROR on next-20180316]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/David-Collins/regulator-add-QCOM-RPMh-regulator-driver/20180319-011147
config: i386-allmodconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> drivers/regulator/qcom_rpmh-regulator.c:18:10: fatal error: soc/qcom/cmd-db.h: No such file or directory
    #include <soc/qcom/cmd-db.h>
             ^~~~~~~~~~~~~~~~~~~
   compilation terminated.

coccinelle warnings: (new ones prefixed by >>)

>> drivers/regulator/qcom_rpmh-regulator.c:1104:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

vim +18 drivers/regulator/qcom_rpmh-regulator.c

     5	
     6	#include <linux/bitops.h>
     7	#include <linux/err.h>
     8	#include <linux/kernel.h>
     9	#include <linux/module.h>
    10	#include <linux/of.h>
    11	#include <linux/of_device.h>
    12	#include <linux/platform_device.h>
    13	#include <linux/slab.h>
    14	#include <linux/string.h>
    15	#include <linux/regulator/driver.h>
    16	#include <linux/regulator/machine.h>
    17	#include <linux/regulator/of_regulator.h>
  > 18	#include <soc/qcom/cmd-db.h>
    19	#include <soc/qcom/rpmh.h>
    20	#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
    21	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 63082 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180319/f29e49e3/attachment-0001.gz>
