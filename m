From: vz@mleia.com (Vladimir Zapolskiy)
Date: Tue,  3 Jul 2018 22:29:31 +0300
Subject: [PATCH 0/3] ARM: dts: imx31: add device tree description of basic
 controllers
Message-ID: <20180703192934.6080-1-vz@mleia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The changeset combines a number of essential updates to support device tree
on Freescale i.MX31 powered boards:
* removal of bogus RNGA registration for i.MX31 (device tree only),
* the core controllers on the i.MX31 SoC are now properly described,
* for reference and testing I add basic support of LogicPD MX31Lite board.

There are some missing compatibles in the change 2/3, however at the moment
I assume that either adding the values can be omitted or deferred, here is
the exact list:
* "fsl,imx31-pata"
* "fsl,imx31-rtc"
* "fsl,imx31-nand"
* "fsl,imx31-weim"

To test the changes I used a LogicPD reference board, however note that
still I have to add a workaround to the old known issue within imx-wdt
driver, also I perform testing with my own and not yet shared imx31 pinctrl
driver, but obviously the device tree pinctrl changes are irrelevant to
the code from this series.

Vladimir Zapolskiy (3):
  ARM: i.MX31: remove rnga registration as a platform device
  ARM: dts: imx31: add device tree description of basic controllers
  ARM: dts: imx31: add LogicPD MX31Lite board description

 arch/arm/boot/dts/Makefile       |   3 +-
 arch/arm/boot/dts/imx31-lite.dts | 177 +++++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx31.dtsi     | 222 +++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-imx/imx31-dt.c     |  18 ----
 4 files changed, 401 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx31-lite.dts

-- 
2.10.2
