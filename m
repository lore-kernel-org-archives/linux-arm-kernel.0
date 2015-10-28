From: p.fedin@samsung.com (Pavel Fedin)
Date: Wed, 28 Oct 2015 10:57:34 +0300
Subject: [PATCH v3 0/4] Exynos SROMc configuration and Ethernet support for
 SMDK5410
Message-ID: <cover.1446018918.git.p.fedin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends Exynos SROM controller driver with ability to configure
controller outputs and enables SMSC9115 Ethernet chip on SMDK5410 board,
which is connected via SROMc bank #3.

With this patchset, support for the whole existing SMDK range can be added.
Actually, only bank number is different.

This patchset also depends on Exynos 5410 pinctrl support, introduced by
patches 0003 and 0004 from this set:
[PATCH v4 0/5] ARM: EXYNOS: ODROID-XU DT and LEDs
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-March/330862.html

Pinctrl support is necessary in order to correctly configure
multifunctional pins of the Exynos chip.

v2 => v3:
- Fixed up SROMc region size in the device tree
- Reordered patches, documentation goes first now

v1 => v2:
- Fixed some typos and bad labels in device tree
- Improved documentation

Pavel Fedin (4):
  Documentation: dt-bindings: Describe SROMc configuration
  ARM: dts: Add SROMc to Exynos 5410
  drivers: exynos-srom: Add support for bank configuration
  ARM: dts: Add Ethernet chip to SMDK5410

 .../bindings/arm/samsung/exynos-srom.txt           | 24 ++++++++++++-
 arch/arm/boot/dts/exynos5410-smdk5410.dts          | 42 ++++++++++++++++++++++
 arch/arm/boot/dts/exynos5410.dtsi                  |  5 +++
 arch/arm/mach-exynos/Kconfig                       |  2 +-
 drivers/soc/samsung/Kconfig                        |  2 +-
 drivers/soc/samsung/exynos-srom.c                  | 42 +++++++++++++++++++++-
 6 files changed, 113 insertions(+), 4 deletions(-)

-- 
2.4.4
