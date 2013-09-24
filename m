From: m.krawczuk@partner.samsung.com (Mateusz Krawczuk)
Date: Tue, 24 Sep 2013 14:50:06 +0200
Subject: [PATCH v5 0/3] ARM: S5PV210: move to common clk framework
Message-ID: <1380027009-2239-1-git-send-email-m.krawczuk@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series is the new s5pv210 clock implementation
(using common clk framework).

This implementation is compatible with device tree definition and board
files.

This patch series is based on linux-next and has been tested on goni and
aquila
boards using board file.

Since v4:
Corrected mux flags for finpll.

Since v3:

Replace s5pv210_clk_register_finpll, by creating mux finpll
with xusbxti and xxti as parrents.


Mateusz Krawczuk (3):
  clk: samsung: Add clock driver for s5pc110/s5pv210
  Cpufreq: s5pv210 cpufreq fixes for CCF
  ARM: s5pv210: Migrate clock handling to Common Clock Framework

 .../bindings/clock/samsung,s5pv210-clock.txt       |  75 +++
 arch/arm/mach-s5pv210/Kconfig                      |   9 +
 arch/arm/mach-s5pv210/Makefile                     |   4 +-
 arch/arm/mach-s5pv210/common.c                     |  17 +
 arch/arm/mach-s5pv210/common.h                     |  10 +
 arch/arm/mach-s5pv210/mach-goni.c                  |   2 +-
 arch/arm/mach-s5pv210/mach-smdkv210.c              |   2 +-
 arch/arm/plat-samsung/Kconfig                      |   2 +-
 drivers/clk/samsung/Makefile                       |   3 +
 drivers/clk/samsung/clk-s5pv210.c                  | 673 +++++++++++++++++++++
 drivers/cpufreq/s5pv210-cpufreq.c                  |   6 +-
 include/dt-bindings/clock/samsung,s5pv210-clock.h  | 224 +++++++
 12 files changed, 1019 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/samsung,s5pv210-clock.txt
 create mode 100644 drivers/clk/samsung/clk-s5pv210.c
 create mode 100644 include/dt-bindings/clock/samsung,s5pv210-clock.h

-- 
1.8.1.2
