From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Wed, 31 Dec 2014 12:13:01 +0530
Subject: [PATCH v3 0/4] mmc: dw_mmc: exynos: Add HS400 support
Message-ID: <1420008185-24758-1-git-send-email-alim.akhtar@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serise is second part of [1] which was posted by Seungwon Jeon few months back.
This adds HS400 mode support for exynos dw_mmc host controller.

Currently tested on Exynos5800-peach-pi platform and exynos7 platform for HS400 mode.

Appreciate testing on other exynos5 platform which supports emmc5.0

[1] http://www.spinics.net/lists/linux-mmc/msg25599.html

Changes in V3:
	rebased on ulf's next (commit: 607b448 mmc: core: Make tuning block patterns static)

Seungwon Jeon (4):
  mmc: dw_mmc: exynos: incorporate ciu_div into timing property
  mmc: dw_mmc: exynos: support eMMC's HS400 mode
  ARM: dts: drop dw-mshc-ciu-div property from Exynos
  ARM: dts: add HS400 support for Exynos5420 and exynos5800

 .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   21 +-
 arch/arm/boot/dts/exynos3250-monk.dts              |    5 +-
 arch/arm/boot/dts/exynos3250-rinato.dts            |    5 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |    5 +-
 arch/arm/boot/dts/exynos4412-origen.dts            |    5 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            |    5 +-
 arch/arm/boot/dts/exynos5250-arndale.dts           |   10 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   10 +-
 arch/arm/boot/dts/exynos5250-snow.dts              |   15 +-
 arch/arm/boot/dts/exynos5250-spring.dts            |   10 +-
 arch/arm/boot/dts/exynos5260-xyref5260.dts         |   10 +-
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |   10 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |   10 +-
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |   15 +-
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |    7 +
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |   15 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |   15 +-
 drivers/mmc/host/dw_mmc-exynos.c                   |  242 +++++++++++++++-----
 drivers/mmc/host/dw_mmc-exynos.h                   |   18 +-
 drivers/mmc/host/dw_mmc.c                          |   16 +-
 drivers/mmc/host/dw_mmc.h                          |    2 +
 21 files changed, 308 insertions(+), 143 deletions(-)

-- 
1.7.9.5
