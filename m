From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Fri,  6 Feb 2015 19:27:43 +0530
Subject: [PATCH v2 0/3] Add CPU clock support for Exynos7
Message-ID: <1423231066-7341-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds the atlas clock hierarchy on Exynos7. It also
modifies the existing cpu clock infrastructure to handle exynos7
differences. These patches are a pre-requisite for enabling CPUFreq
on Exynos7.

This  patch set has been tested on next-20150202 with samsung
clk tree (for-v3.20/clk/next branch) merged.

Following are the dependencies:
1) cpufreq: use generic cpufreq drivers for exynos platforms (v12)
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/304975.html

For testing I have applied the following:
1) mfd: sec: add S2MPS15 PMIC support
https://lkml.org/lkml/2014/10/14/50
2) regulator: s2mps11: add support for S2MPS15 regulators
https://lkml.org/lkml/2014/10/14/52
3) Regulators dt nodes were added in the espresso dts file and I2C channel 4
which has the PMIC on it was tested.

Abhilash Kesavan (3):
  clk: samsung: exynos7: add clocks for CPU block
  clk: samsung: add cpu clock support for Exynos7
  clk: samsung: add cpu clock configuration data and instantiate cpu
    clock

 .../devicetree/bindings/clock/exynos7-clock.txt    |    6 +
 drivers/clk/samsung/clk-cpu.c                      |  147 ++++++++++++++++++-
 drivers/clk/samsung/clk-cpu.h                      |   38 ++++-
 drivers/clk/samsung/clk-exynos4.c                  |    2 +-
 drivers/clk/samsung/clk-exynos5250.c               |    2 +-
 drivers/clk/samsung/clk-exynos5420.c               |    4 +-
 drivers/clk/samsung/clk-exynos7.c                  |  152 ++++++++++++++++++++
 include/dt-bindings/clock/exynos7-clk.h            |   21 ++-
 8 files changed, 363 insertions(+), 9 deletions(-)

-- 
1.7.9.5
