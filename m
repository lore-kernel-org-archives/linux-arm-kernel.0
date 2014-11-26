From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Wed, 26 Nov 2014 16:47:47 +0530
Subject: [PATCH 0/4] Add CPU clock support for Exynos7
Message-ID: <1417000671-11996-1-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add the atlas clocks on Exynos7. It also modifies the
existing cpu clock infrastructure to handle exynos7 differences. These
patches are a pre-requisite for enabling CPUFreq on Exynos7.

Following are the dependencies:
1) arch: arm64: Enable support for Samsung Exynos7 SoC
http://www.spinics.net/lists/linux-samsung-soc/msg38734.html
2) cpufreq: use generic cpufreq drivers for exynos platforms
http://www.spinics.net/lists/linux-samsung-soc/msg39332.html

For testing I have applied the following:
1) mfd: sec: add S2MPS15 PMIC support
https://lkml.org/lkml/2014/10/14/50
2) regulator: s2mps11: add support for S2MPS15 regulators
https://lkml.org/lkml/2014/10/14/52
3) Regulators dt nodes were added in the espresso dts file and I2C channel 4
which has the PMIC on it was tested.

Abhilash Kesavan (4):
  clk: samsung: exynos7: add clocks for CPU block
  clk: samsung: retrieve the clock provider information from
    samsung_cmu_register_one
  clk: samsung: add cpu clock support for Exynos7
  clk: samsung: add cpu clock configuration data and instantiate cpu
    clock

 .../devicetree/bindings/clock/exynos7-clock.txt    |    6 +
 drivers/clk/samsung/clk-cpu.c                      |  130 ++++++++++++++++-
 drivers/clk/samsung/clk-cpu.h                      |   38 ++++-
 drivers/clk/samsung/clk-exynos4.c                  |    2 +-
 drivers/clk/samsung/clk-exynos5250.c               |    2 +-
 drivers/clk/samsung/clk-exynos5420.c               |    4 +-
 drivers/clk/samsung/clk-exynos7.c                  |  147 ++++++++++++++++++++
 drivers/clk/samsung/clk.c                          |    6 +-
 drivers/clk/samsung/clk.h                          |    4 +-
 include/dt-bindings/clock/exynos7-clk.h            |   21 ++-
 10 files changed, 347 insertions(+), 13 deletions(-)

-- 
1.7.9.5
