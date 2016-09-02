From: lkp@intel.com (kbuild test robot)
Date: Fri, 2 Sep 2016 09:23:21 +0800
Subject: [PATCH 4/5] PM / devfreq: rockchip: add devfreq driver for
 rk3399 dmc
In-Reply-To: <1472769085-20715-5-git-send-email-hl@rock-chips.com>
Message-ID: <201609020953.NltUDqVg%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lin,

[auto build test ERROR on next-20160825]
[also build test ERROR on v4.8-rc4]
[cannot apply to rockchip/for-next devfreq/for-rafael linus/master v4.8-rc4 v4.8-rc3 v4.8-rc2]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
[Suggest to use git(>=2.9.0) format-patch --base=<commit> (or --base=auto for convenience) to record what (public, well-known) commit your patch series was built on]
[Check https://git-scm.com/docs/git-format-patch for more information]

url:    https://github.com/0day-ci/linux/commits/Lin-Huang/rk3399-support-ddr-frequency-scaling/20160902-063701
config: arm-allmodconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 5.4.0-6) 5.4.0 20160609
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All errors (new ones prefixed by >>):

>> drivers/devfreq/rk3399_dmc.c:29:39: fatal error: soc/rockchip/rockchip_sip.h: No such file or directory
   compilation terminated.

vim +29 drivers/devfreq/rk3399_dmc.c

    23	#include <linux/platform_device.h>
    24	#include <linux/pm_opp.h>
    25	#include <linux/regulator/consumer.h>
    26	#include <linux/rwsem.h>
    27	#include <linux/suspend.h>
    28	
  > 29	#include <soc/rockchip/rockchip_sip.h>
    30	
    31	struct dram_timing {
    32		unsigned int ddr3_speed_bin;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 58849 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160902/43c0050c/attachment-0001.obj>
