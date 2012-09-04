From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 04 Sep 2012 10:50:04 +0200
Subject: [PATCH v2 0/5] ARM: EXYNOS: Add support for Trats board using device
 tree
Message-ID: <1346748609-11115-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds basic device tree support for Samsung Trats board
along with any necessary prerequisites.

In addition it refactors Exynos4 dts include files to split parts common to
the whole Exynos4 part from parts specific to Exynos4210 to allow further
extension of Exynos4210 dts include file and addition of include files for
other SoCs from Exynos4 line.

Changes since v1:
 - Split into two series, general Exynos4 DT reorganization and this one.
 - Addressed comments from v1.

Dependencies:
-> [PATCH v5] mmc: sdhci-s3c: Add device tree support
http://www.spinics.net/lists/linux-samsung-soc/msg12056.html
-> [PATCH v5 2/2] regulator: add device tree support for max8997
http://www.spinics.net/lists/kernel/msg1328117.html
-> [PATCH 0/3] ARM: dts: Exynos4 dts reorganization
http://www.spinics.net/lists/arm-kernel/msg192237.html

Tomasz Figa (5):
  mmc: host: sdhci-s3c: Add broken-voltage DT property for broken
    voltage quirk
  ARM: Exynos4: dts: Specify address and size cells for i2c controllers
  ARM: Exynos4: Add OF compatibility lookups for Exynos4 i2c adapters
  ARM: EXYNOS: Increase maximum possible memory bank size to 512MiB
  ARM: Exynos: Add basic dts file for Samsung Trats board

 Documentation/devicetree/bindings/mmc/mmc.txt |   1 +
 arch/arm/boot/dts/exynos4.dtsi                |  16 ++
 arch/arm/boot/dts/exynos4210-trats.dts        | 237 ++++++++++++++++++++++++++
 arch/arm/mach-exynos/Makefile.boot            |   2 +-
 arch/arm/mach-exynos/include/mach/memory.h    |   4 +-
 arch/arm/mach-exynos/mach-exynos4-dt.c        |  14 ++
 drivers/mmc/host/sdhci-s3c.c                  |   3 +
 7 files changed, 274 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/boot/dts/exynos4210-trats.dts

-- 
1.7.12
