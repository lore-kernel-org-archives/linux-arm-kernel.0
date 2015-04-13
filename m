From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 13 Apr 2015 19:46:58 +0200
Subject: [PATCH 0/4] cpufreq: use generic cpufreq drivers for Exynos5250
 platform
Message-ID: <1428947223-17268-1-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series removes the use of Exynos5250 specific support
from exynos-cpufreq driver and enables the use of cpufreq-dt driver
for this platform.  The exynos-cpufreq driver itself is also removed
as it is no longer used/needed after Exynos5250 support removal.

This patch series has been tested on Exynos5250 based Arndale board.

Depends on:
- next-20150330 branch of linux-next kernel tree
- "[PATCH 0/6] cpufreq: use generic cpufreq drivers for Exynos4210
  platform" [1]
- "[PATCH 0/6] cpufreq: use generic cpufreq drivers for Exynos4x12
  platform" [2]
- "[PATCH] cpufreq: exynos: remove dead ->need_apll_change method" [3]

[1] http://www.kernelhub.org/?msg=721136&p=2
[2] http://marc.info/?l=linux-pm&m=142868881101873&w=2
[3] https://lkml.org/lkml/2015/3/27/574

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

Bartlomiej Zolnierkiewicz (1):
  cpufreq: exynos: remove Exynos5250 specific cpufreq driver support

Thomas Abraham (3):
  clk: samsung: exynos5250: add cpu clock configuration data and
    instantiate cpu clock
  ARM: dts: Exynos5250: add CPU OPP and regulator supply property
  ARM: Exynos: switch to using generic cpufreq driver for Exynos5250

 arch/arm/boot/dts/exynos5250-arndale.dts  |    4 +
 arch/arm/boot/dts/exynos5250-smdk5250.dts |    4 +
 arch/arm/boot/dts/exynos5250-snow.dts     |    4 +
 arch/arm/boot/dts/exynos5250-spring.dts   |    4 +
 arch/arm/boot/dts/exynos5250.dtsi         |   22 +++
 arch/arm/mach-exynos/exynos.c             |    1 +
 drivers/clk/samsung/clk-exynos5250.c      |   31 +++++
 drivers/cpufreq/Kconfig.arm               |   22 ---
 drivers/cpufreq/Makefile                  |    3 -
 drivers/cpufreq/exynos-cpufreq.c          |  203 ----------------------------
 drivers/cpufreq/exynos-cpufreq.h          |   67 ---------
 drivers/cpufreq/exynos5250-cpufreq.c      |  210 -----------------------------
 include/dt-bindings/clock/exynos5250.h    |    1 +
 13 files changed, 71 insertions(+), 505 deletions(-)
 delete mode 100644 drivers/cpufreq/exynos-cpufreq.c
 delete mode 100644 drivers/cpufreq/exynos-cpufreq.h
 delete mode 100644 drivers/cpufreq/exynos5250-cpufreq.c

-- 
1.7.9.5
