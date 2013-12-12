From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 12 Dec 2013 17:18:00 +0100
Subject: [PATCH 0/3] DW-MSHC support on Exynos4412-TRATS2 board
Message-ID: <1386865083-20082-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series fixes spotted issues with DW-MSHC support on Exynos4x12
SoCs and then enables DW-MSHC controller to handle eMMC memory on
Exynos4412-TRATS2 board. As opposed to using sdhci-s3c for eMMC,
MMC 4.4 extensions can be used and in general performance is improved.

Tested on Exynos4412-TRATS2 board.

Tomasz Figa (3):
  clk: samsung: exynos4: Fix definition of div_mmc_pre4 divider
  ARM: dts: exynos4x12: Fix definition of MSHC device tree nodes
  ARM: dts: exynos4412-trats2: Use MSHC controller for eMMC memory

 arch/arm/boot/dts/exynos4412-odroidx.dts |  5 +----
 arch/arm/boot/dts/exynos4412-origen.dts  |  5 +----
 arch/arm/boot/dts/exynos4412-trats2.dts  | 20 ++++++++++++++++----
 arch/arm/boot/dts/exynos4412.dtsi        |  8 --------
 arch/arm/boot/dts/exynos4x12.dtsi        | 13 +++++++++++++
 drivers/clk/samsung/clk-exynos4.c        |  3 ++-
 6 files changed, 33 insertions(+), 21 deletions(-)

-- 
1.8.4.3
