From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Wed, 16 Apr 2014 09:28:55 +0530
Subject: [PATCH v8 0/3] exynos: arch: add support for exynos5260 SoC
Message-ID: <1397620738-14431-1-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

v8:
  1) Removed exynos5260 compatible from mach/exynos5.c
  2) Added generic "exynos5" compatible in board and soc dts file.

v7:
  1) Renamed board file

V6:
  1) Renamed mmc nodes.
  2) Removed PHY clocks from DT and put them inside clock driver.
  3) Added clock-cells property for all fixed clocks.
  4) Removed spdif_ext_clk fixed rate clock.

V5:
  1) Removed SYSRAM related code.
  2) Fixed mct clocks.
  3) Add SoC and Board specifc fixed-rate clocks in respective files.

V4:
  1) Removed duplicate MMC Soc property from Board file.

V3:
  1) Addressed review comments from Tomasz figa.

V2:
  1) Split up DT patch into SoC and Board patch.

This series is based on Kukjin's for-next branch at
http://git.kernel.org/?p=linux/kernel/git/kgene/linux-samsung.git

Pankaj Dubey (1):
  ARM: EXYNOS: initial board support for exynos5260 SoC

Rahul Sharma (2):
  ARM: dts: add dts files for exynos5260 SoC
  ARM: dts: add dts files for xyref5260 board

 arch/arm/boot/dts/Makefile                 |    1 +
 arch/arm/boot/dts/exynos5260-pinctrl.dtsi  |  574 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5260-xyref5260.dts |  103 +++++
 arch/arm/boot/dts/exynos5260.dtsi          |  304 +++++++++++++++
 arch/arm/mach-exynos/Kconfig               |    5 +
 5 files changed, 987 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos5260-pinctrl.dtsi
 create mode 100644 arch/arm/boot/dts/exynos5260-xyref5260.dts
 create mode 100644 arch/arm/boot/dts/exynos5260.dtsi

-- 
1.7.9.5
