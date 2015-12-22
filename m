From: lkp@intel.com (kbuild test robot)
Date: Tue, 22 Dec 2015 08:59:59 +0800
Subject: [PATCH 4/6] soc: rockchip: add reboot mode driver
In-Reply-To: <1450697948-30205-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <201512220857.Zy8ybs1H%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andy,

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.4-rc6 next-20151221]
[cannot apply to rockchip/for-next]

url:    https://github.com/0day-ci/linux/commits/Andy-Yan/misc-add-reboot-mode-driver/20151221-195031
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: arm-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   drivers/soc/rockchip/reboot.c: In function 'rockchip_reboot_mode_write':
>> drivers/soc/rockchip/reboot.c:28:1: warning: no return statement in function returning non-void [-Wreturn-type]
    }
    ^
   drivers/soc/rockchip/reboot.c: In function 'rockchip_reboot_probe':
   drivers/soc/rockchip/reboot.c:32:26: warning: unused variable 'reboot' [-Wunused-variable]
     struct rockchip_reboot *reboot;
                             ^

vim +28 drivers/soc/rockchip/reboot.c

    12	#include <linux/of.h>
    13	#include <linux/of_address.h>
    14	#include <linux/platform_device.h>
    15	#include <linux/reboot.h>
    16	#include <linux/regmap.h>
    17	#include <linux/mfd/syscon.h>
    18	#include "loader.h"
    19	
    20	struct regmap *map;
    21	u32 offset;
    22	
    23	static int rockchip_reboot_mode_write(int magic)
    24	{
    25		pr_info("%s---------magic:%x\n", __func__, magic);
    26		regmap_write(map, offset, magic);
    27	
  > 28	}
    29	
    30	static int __init rockchip_reboot_probe(struct platform_device *pdev)
    31	{
    32		struct rockchip_reboot *reboot;
    33		int ret;
    34	
    35		map = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
    36							      "rockchip,regmap");

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 54607 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151222/456696f4/attachment-0001.obj>
