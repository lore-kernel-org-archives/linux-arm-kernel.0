From: lkp@intel.com (kbuild test robot)
Date: Mon, 5 Oct 2015 00:54:03 +0800
Subject: [PATCH v3 1/8] ARM: dts: rockchip: add core rk3036 dts
In-Reply-To: <1443492833-15630-2-git-send-email-zhengxing@rock-chips.com>
Message-ID: <201510050056.ZXVRbABB%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Xing,

[auto build test results on v4.3-rc3 -- if it's inappropriate base, please ignore]

config: arm-arm67 (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the linux-review/Xing-Zheng/Build-and-support-rk3036-SoC-platform HEAD fa7deba821e05956d8a4937e14541d315682f39a builds fine.
      It only hurts bisectibility.

All error/warnings (new ones prefixed by >>):

   In file included from arch/arm/boot/dts/rk3036-evb.dts:43:0:
>> arch/arm/boot/dts/rk3036.dtsi:45:42: fatal error: dt-bindings/clock/rk3036-cru.h: No such file or directory
    #include <dt-bindings/clock/rk3036-cru.h>
                                             ^
   compilation terminated.

vim +45 arch/arm/boot/dts/rk3036.dtsi

    39	 */
    40	
    41	#include <dt-bindings/gpio/gpio.h>
    42	#include <dt-bindings/interrupt-controller/irq.h>
    43	#include <dt-bindings/interrupt-controller/arm-gic.h>
    44	#include <dt-bindings/pinctrl/rockchip.h>
  > 45	#include <dt-bindings/clock/rk3036-cru.h>
    46	#include "skeleton.dtsi"
    47	
    48	/ {

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 28527 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151005/5246274b/attachment-0001.obj>
