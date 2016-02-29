From: lkp@intel.com (kbuild test robot)
Date: Mon, 29 Feb 2016 20:48:23 +0800
Subject: [PATCH 5/5] clk: rockchip: add clock controller for the RK3399
In-Reply-To: <1456745466-13090-1-git-send-email-zhengxing@rock-chips.com>
Message-ID: <201602292017.8iHnbU5b%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xing,

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on next-20160229]
[cannot apply to v4.5-rc6]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Xing-Zheng/Add-more-clock-compatible-features-and-support-the-RK3399-clock/20160229-193423
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: arm-defconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> drivers/clk/rockchip/clk-rk3399.c:21:42: fatal error: dt-bindings/clock/rk3399-cru.h: No such file or directory
    #include <dt-bindings/clock/rk3399-cru.h>
                                             ^
   compilation terminated.

vim +21 drivers/clk/rockchip/clk-rk3399.c

    15	
    16	#include <linux/clk-provider.h>
    17	#include <linux/of.h>
    18	#include <linux/of_address.h>
    19	#include <linux/platform_device.h>
    20	#include <linux/regmap.h>
  > 21	#include <dt-bindings/clock/rk3399-cru.h>
    22	#include "clk.h"
    23	
    24	#define RK3399_PMUGRF_SOC_CON0			0x180

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 36561 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160229/7c9af9b9/attachment-0001.obj>
