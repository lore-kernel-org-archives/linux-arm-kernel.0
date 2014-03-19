From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Wed, 19 Mar 2014 17:55:53 +0530
Subject: [PATCH 0/4] Consolidate Exynos machine code
Message-ID: <1395231957-22032-1-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series consolidates the Exynos machine code and common
code into a single file to avoid code duplication and introduces
generic compatible strings for Exynos4 and 5 SoC series.

Complete discussion and motivation for this series is found here:
http://comments.gmane.org/gmane.linux.kernel.samsung-soc/27268

This series is based on the latest linux-next and depends on
1. Tomasz Figa's PM consolidation series 1 and 2
2. Patch: ARM: SAMSUNG: Reorganize calls to reserve memory for MFC
http://www.spinics.net/lists/linux-samsung-soc/msg25501.html
3. Patch: ARM: EXYNOS: Add support to reserve memory for MFC-v7
http://www.spinics.net/lists/arm-kernel/msg315940.html
4. Kconfig and CPU init Consolidation series
http://article.gmane.org/gmane.linux.kernel.samsung-soc/28216

Sachin Kamat (4):
  ARM: SAMSUNG: Introduce generic Exynos4 and 5 helpers
  ARM: EXYNOS: Consolidate Exynos4 and 5 machine files
  ARM: EXYNOS: Add generic compatible strings
  ARM: dts: Update Exynos DT files with generic compatible strings

 arch/arm/boot/dts/exynos4210-origen.dts         |    2 +-
 arch/arm/boot/dts/exynos4210-smdkv310.dts       |    2 +-
 arch/arm/boot/dts/exynos4210-trats.dts          |    2 +-
 arch/arm/boot/dts/exynos4210-universal_c210.dts |    2 +-
 arch/arm/boot/dts/exynos4210.dtsi               |    2 +-
 arch/arm/boot/dts/exynos4212.dtsi               |    2 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts        |    2 +-
 arch/arm/boot/dts/exynos4412-origen.dts         |    2 +-
 arch/arm/boot/dts/exynos4412-smdk4412.dts       |    2 +-
 arch/arm/boot/dts/exynos4412-tiny4412.dts       |    2 +-
 arch/arm/boot/dts/exynos4412-trats2.dts         |    2 +-
 arch/arm/boot/dts/exynos4412.dtsi               |    2 +-
 arch/arm/boot/dts/exynos5250-arndale.dts        |    2 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts       |    2 +-
 arch/arm/boot/dts/exynos5250-snow.dts           |    2 +-
 arch/arm/boot/dts/exynos5250.dtsi               |    2 +-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts   |    2 +-
 arch/arm/boot/dts/exynos5420-smdk5420.dts       |    2 +-
 arch/arm/boot/dts/exynos5420.dtsi               |    2 +-
 arch/arm/boot/dts/exynos5440-sd5v1.dts          |    2 +-
 arch/arm/boot/dts/exynos5440-ssdk5440.dts       |    2 +-
 arch/arm/boot/dts/exynos5440.dtsi               |    2 +-
 arch/arm/mach-exynos/Makefile                   |    7 +-
 arch/arm/mach-exynos/common.h                   |    3 +-
 arch/arm/mach-exynos/{common.c => exynos.c}     |  135 ++++++++++++++++-------
 arch/arm/mach-exynos/mach-exynos4-dt.c          |   53 ---------
 arch/arm/mach-exynos/mach-exynos5-dt.c          |   83 --------------
 arch/arm/mach-exynos/regs-pmu.h                 |    1 -
 arch/arm/plat-samsung/include/plat/cpu.h        |    4 +
 29 files changed, 121 insertions(+), 209 deletions(-)
 rename arch/arm/mach-exynos/{common.c => exynos.c} (75%)
 delete mode 100644 arch/arm/mach-exynos/mach-exynos4-dt.c
 delete mode 100644 arch/arm/mach-exynos/mach-exynos5-dt.c

-- 
1.7.9.5
