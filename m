From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 01 Jul 2015 15:10:34 +0200
Subject: [PATCH v3 0/4] cpufreq: use generic cpufreq drivers for Exynos5250
 platform
Message-ID: <1435756238-845-1-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series removes the use of Exynos5250 specific support
from cpufreq-exynos driver and enables the use of cpufreq-dt driver
for this platform.

This patch series has been tested on Exynos5250 based Arndale board.

Changes since v1 (http://lkml.org/lkml/2015/4/13/611):
- rebased on top of next-20150629 branch of linux-next kernel tree
- dropped dependency on "[PATCH 0/6] cpufreq: use generic cpufreq
  drivers for Exynos4x12 platform" patch series as it needs more
  work (Viresh has requested porting of cpufreq-dt's boost mode
  support over opp-v2 patches)

Changes since v2 (http://lkml.org/lkml/2015/6/29/361):
- put the new cpu nodes in alphabetical order
- updated Javier's and Mike's e-mail adresses
- removed Cc: tag with stale Sachin's e-mail adress
- added Reviewed-by: tag from Krzysztof to patches #3 and #4

Depends on:
- next-20150629 branch of linux-next kernel tree

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

 arch/arm/boot/dts/exynos5250-arndale.dts  |   4 +
 arch/arm/boot/dts/exynos5250-smdk5250.dts |   4 +
 arch/arm/boot/dts/exynos5250-snow.dts     |   4 +
 arch/arm/boot/dts/exynos5250-spring.dts   |   4 +
 arch/arm/boot/dts/exynos5250.dtsi         |  22 ++++
 arch/arm/mach-exynos/exynos.c             |   1 +
 drivers/clk/samsung/clk-exynos5250.c      |  31 +++++
 drivers/cpufreq/Kconfig.arm               |  11 --
 drivers/cpufreq/Makefile                  |   1 -
 drivers/cpufreq/exynos-cpufreq.c          |   3 -
 drivers/cpufreq/exynos-cpufreq.h          |  17 ---
 drivers/cpufreq/exynos5250-cpufreq.c      | 210 ------------------------------
 include/dt-bindings/clock/exynos5250.h    |   1 +
 13 files changed, 71 insertions(+), 242 deletions(-)
 delete mode 100644 drivers/cpufreq/exynos5250-cpufreq.c

-- 
1.9.1
