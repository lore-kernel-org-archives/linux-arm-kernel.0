From: j-keerthy@ti.com (Keerthy)
Date: Wed, 1 Mar 2017 15:59:43 +0530
Subject: [PATCH 0/7] thermal: ti-soc-thermal: Migrate slope/offset data to
 device tree
Message-ID: <1488364190-23488-1-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the slope and offset values for calculating the
hot spot temperature of a particular thermal zone is part
of driver data. Pass them here instead and obtain the values
while of node parsing.

Tested for the slope and constant values on DRA7-EVM.

Keerthy (7):
  ARM: DRA7: Thermal: Add slope and offset values
  ARM: OMAP5: Thermal: Add slope and offset values
  ARM: OMAP443x: Thermal: Add slope and offset values
  ARM: OMAP4460: Thermal: Add slope and offset values
  thermal: ti-soc-thermal: Fetch slope and offset from DT
  thermal: ti-soc-thermal: Remove redundant constants
  thermal: ti-soc-thermal: Remove redundant code

 arch/arm/boot/dts/dra7.dtsi                        |  17 +++
 arch/arm/boot/dts/omap443x.dtsi                    |   4 +
 arch/arm/boot/dts/omap4460.dtsi                    |   4 +
 arch/arm/boot/dts/omap5.dtsi                       |   9 ++
 .../thermal/ti-soc-thermal/dra752-thermal-data.c   |  10 --
 .../thermal/ti-soc-thermal/omap4-thermal-data.c    |   4 -
 .../thermal/ti-soc-thermal/omap5-thermal-data.c    |   4 -
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c | 164 ++-------------------
 8 files changed, 45 insertions(+), 171 deletions(-)

-- 
1.9.1
