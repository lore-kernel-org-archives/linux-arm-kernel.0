From: wxt@rock-chips.com (Caesar Wang)
Date: Thu, 17 Dec 2015 22:21:46 +0800
Subject: [PATCH v1 0/6] Support the rk3036 Kylin board
Message-ID: <1450362112-8075-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kylin-board is based on RK3036 SOCs, add the initiation
version for working.

This series patches have the following decriptions:

PATCH[1/6]:
ARM: dts: fix the correct pinctrl control for rk3036

The pinctrl gpio pull up/down is incorrect since the rk3036 SoCs
can't set the status in the internal.
---

PATCH[2/6]:
ARM: dts: add the lcdc and hdmi node for rk3036

Add the devices is related to display.
Based on the series patches of Mark Yao's
---

PATCH[3/6]:
ARM: dts: add the sdio/sdmmc node for rk3036

Add the wifi/sd card work for kylin board.
---

PATCH[4/6]:
ARM: dts: rockchip: add the kylin board for rk3036

Add the dts for kylin board.
---

PATCH[5/6]:
ARM: dts: add the sound codec for kylin board

Make the codec rt5616 working on kylin board.
The realteak have been upstream for Mark Brown,
I guess need some days to review.

---

PATCH[6/6]:
ARM: dts: add the sdio node for kylin board

Enable the sdio for kylin board.
---



Caesar Wang (6):
  ARM: dts: fix the correct pinctrl control for rk3036
  ARM: dts: add the lcdc and hdmi node for rk3036
  ARM: dts: add the sdio/sdmmc node for rk3036
  ARM: dts: rockchip: add the kylin board for rk3036
  ARM: dts: add the sound codec for kylin board
  ARM: dts: add the sdio node for kylin board

 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/rk3036-kylin.dts                 | 345 +++++++++++++++++++++
 arch/arm/boot/dts/rk3036.dtsi                      | 167 ++++++++--
 4 files changed, 498 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3036-kylin.dts

-- 
1.9.1
