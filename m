From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Tue, 5 Aug 2014 15:18:53 +0300
Subject: [PATCH v2 0/4] Tegra124 soctherm driver
Message-ID: <1407241137-32232-1-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series adds support for the thermal monitoring features of the
soctherm unit on the Tegra124 SoC. v2 drops support for interrupt-
based trip points. Thermtrip (emergency thermal shutdown) still
works when this driver is loaded and the PMC thermal reset patch
series is applied.

The branch is also available in my github repo,
  git://github.com/cyndis/linux.git soctherm-v2

Thanks,
Mikko

Mikko Perttunen (4):
  of: Add bindings for nvidia,tegra124-soctherm
  ARM: tegra: Add soctherm and thermal zones to Tegra124 device tree
  ARM: tegra: Add thermal trip points for Jetson TK1
  thermal: Add Tegra SOCTHERM thermal management driver

 .../devicetree/bindings/thermal/tegra-soctherm.txt |  35 ++
 arch/arm/boot/dts/tegra124-jetson-tk1.dts          |  32 ++
 arch/arm/boot/dts/tegra124.dtsi                    |  47 +++
 drivers/thermal/Kconfig                            |   7 +
 drivers/thermal/Makefile                           |   1 +
 drivers/thermal/tegra_soctherm.c                   | 452 +++++++++++++++++++++
 include/dt-bindings/thermal/tegra124-soctherm.h    |  13 +
 7 files changed, 587 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/tegra-soctherm.txt
 create mode 100644 drivers/thermal/tegra_soctherm.c
 create mode 100644 include/dt-bindings/thermal/tegra124-soctherm.h

-- 
1.8.1.5
