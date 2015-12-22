From: wxt@rock-chips.com (Caesar Wang)
Date: Tue, 22 Dec 2015 17:33:48 +0800
Subject: [PATCH 0/5] Support the codec and wifi/bt for rk3036 Kylin board
Message-ID: <1450776833-27639-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Add the needed device for kylin board.

--------------
This series patches have the following decriptions:

PATCH[1/5]:
ARM: dts: set the pinctrl default setting for i2s

The kylin will hang in system when enable the i2s,
we need set the pinctrl default setting for i2s firstly.
--------------

PATCH[2/5]:
ARM: dts: add the sound codec for kylin board

Let the codec works.

RT5616 driver is landed in Mark branch.
(https://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/commit/
?h=for-next&id=b1d15059957d33d111e0ed38724a6b2c5caac790)

Maybe need wait the below patch be merged firstly.
(add an of_match table: https://patchwork.kernel.org/patch/7901951/
rt5616 document: https://patchwork.kernel.org/patch/7901971/)
---------------

PATCH[3/5]:
ARM: dts: rockchip: enable the high speed on sdio for kylin board

This patch is solving the wifi work frequency.
37.5MHz frequency for rk3036.

The wifi throughput:

iperf -s -i 1
...
[  4] 116.0-117.0 sec  2.88 MBytes  24.1 Mbits/sec
[  4] 117.0-118.0 sec  2.99 MBytes  25.0 Mbits/sec
[  4] 118.0-119.0 sec  3.01 MBytes  25.2 Mbits/sec
[  4] 119.0-120.0 sec  2.89 MBytes  24.2 Mbits/sec
[  4]  0.0-120.4 sec   332 MBytes  23.1 Mbits/sec
----------------

PATCH[4/5]:
ARM: dts: add the wifi/bt regulator for kylin board

Add the wifi/bt regulator for wifi module, let the module work on bootup.

Yep, this patch is based on olof patch[0].
patch[0]:
https://patchwork.kernel.org/patch/3510571/
----------------

PATCH[5/5]:
ARM: dts: enable the uart0 for bluetooth module

Enable the uart0 for BT module working.
----------------

Note: that's seem the wifi driver has not landed in mainline.
This driver has existed in rockchip github develop4.1.
https://github.com/rockchip-linux/kernel/commit/a731ffcd0d6ee3b3e6f015d3e2f7b4bf698a3533



Caesar Wang (5):
  ARM: dts: set the pinctrl default setting for i2s
  ARM: dts: add the sound codec for kylin board
  ARM: dts: rockchip: enable the high speed on sdio for kylin board
  ARM: dts: add the wifi/bt regulator for kylin board
  ARM: dts: enable the uart0 for bluetooth module

 arch/arm/boot/dts/rk3036-kylin.dts | 85 +++++++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/rk3036.dtsi      | 12 +++---
 2 files changed, 90 insertions(+), 7 deletions(-)

-- 
1.9.1
