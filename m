From: mikko.perttunen@kapsi.fi (Mikko Perttunen)
Date: Mon, 10 Nov 2014 15:12:12 +0200
Subject: [PATCH v4 REPOST 0/5] Thermal reset support in PMC
Message-ID: <1415625137-4791-1-git-send-email-mikko.perttunen@kapsi.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series adds support for hardware-triggered thermal reset to the PMC
driver. Namely, it adds device tree properties for specifying the I2C
command to be sent when thermtrip is triggered.

The soctherm driver has now been acked and will be taken into 3.19, so we
can move forward with this. Note that there are no compile time dependencies
between the two series; it's just that this series is no-op without the
soctherm driver being present.

Mikko Perttunen (5):
  of: Add descriptions of thermtrip properties to Tegra PMC bindings
  of: Add nvidia,controller-id property to Tegra I2C bindings
  ARM: tegra124: Add I2C controller ids to device tree
  ARM: tegra: Add PMC thermtrip programming to Jetson TK1 device tree
  ARM: tegra: Add thermal reset (thermtrip) support to PMC

 .../bindings/arm/tegra/nvidia,tegra20-pmc.txt      |  24 ++
 .../devicetree/bindings/i2c/nvidia,tegra20-i2c.txt |   5 +
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |   9 +-
 arch/arm/boot/dts/tegra124.dtsi                    |   6 +
 drivers/soc/tegra/pmc.c                            | 379 ++++++++++++++-------
 5 files changed, 290 insertions(+), 133 deletions(-)

-- 
2.1.3
