From: lkp@intel.com (kbuild test robot)
Date: Wed, 2 Nov 2016 17:19:54 +0800
Subject: [PATCH 1/2] phy: rockchip-inno-usb2: support otg-port for rk3399
In-Reply-To: <1478072538-32081-2-git-send-email-wulf@rock-chips.com>
Message-ID: <201611021755.Bfdw4dfz%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi William,

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on v4.9-rc3 next-20161028]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/William-Wu/support-USB2-PHY-OTG-port-for-rk3399/20161102-160006
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: i386-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.2.0-3) 6.2.0 20160901
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

>> drivers/phy/phy-rockchip-inno-usb2.c:39:28: fatal error: linux/wakelock.h: No such file or directory
    #include <linux/wakelock.h>
                               ^
   compilation terminated.

vim +39 drivers/phy/phy-rockchip-inno-usb2.c

    33	#include <linux/platform_device.h>
    34	#include <linux/power_supply.h>
    35	#include <linux/regmap.h>
    36	#include <linux/mfd/syscon.h>
    37	#include <linux/usb/of.h>
    38	#include <linux/usb/otg.h>
  > 39	#include <linux/wakelock.h>
    40	
    41	#define BIT_WRITEABLE_SHIFT	16
    42	#define SCHEDULE_DELAY		(60 * HZ)

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 56829 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161102/746fb699/attachment-0001.gz>
