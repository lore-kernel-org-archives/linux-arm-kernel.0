From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Tue, 18 Feb 2014 17:26:05 +0530
Subject: [PATCH v3 0/5] clk: exynos: add support for exynos5260 SoC
Message-ID: <1392724570-27977-1-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

Add basic support for exynos5260 SoC.

This series is based on Kukjin's for-next and
Mike's clk-next branches.

This patch is dependent on the following series from
Tomasz Figa <t.figa@samsung.com>:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/205144.html

V3:
  1) Removed "samsung,exynos5260-clock" property from clock files.
  2) Replaced "__SPIN_LOCK_UNLOCKED(lock)" with spin_lock_init.
  3) Removed '(' and ')' around numeric constants in macros.

V2:
  1) Move suspend resume handling to Exynos5410 Clock file.
  2) Removed Unused Macros and Condition checks for Exynos5260.
  3) Add spin lock to clock provider context.
  4) Add clock provider context for Exynos5410.
  5) Uniform implementation for callbacks for PLL2550xx.
  6) Split Exynos5260 clock file patch to bring it under 100 Kb limit.
  7) Replace aclk/pclk/hclk gates with combined gates.
  8) Remove CLK_IGNORE_UNUSED flag for gate clocks.

Pankaj Dubey (1):
  clk/samsung: add support for pll2550xx

Rahul Sharma (4):
  clk/samsung: add support for multiple clock providers
  clk/samsung: add support for pll2650xx
  clk/exynos5260: add macros and documentation for exynos5260
  clk/exynos5260: add clock file for exynos5260

 .../devicetree/bindings/clock/exynos5260-clock.txt |  299 +++
 drivers/clk/samsung/Makefile                       |    1 +
 drivers/clk/samsung/clk-exynos4.c                  |   47 +-
 drivers/clk/samsung/clk-exynos5250.c               |   25 +-
 drivers/clk/samsung/clk-exynos5260.c               | 2235 ++++++++++++++++++++
 drivers/clk/samsung/clk-exynos5260.h               |  480 +++++
 drivers/clk/samsung/clk-exynos5420.c               |   24 +-
 drivers/clk/samsung/clk-exynos5440.c               |   18 +-
 drivers/clk/samsung/clk-pll.c                      |  223 +-
 drivers/clk/samsung/clk-pll.h                      |    2 +
 drivers/clk/samsung/clk-s3c64xx.c                  |   44 +-
 drivers/clk/samsung/clk.c                          |  115 +-
 drivers/clk/samsung/clk.h                          |   72 +-
 include/dt-bindings/clk/exynos5260-clk.h           |  234 ++
 14 files changed, 3670 insertions(+), 149 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/exynos5260-clock.txt
 create mode 100644 drivers/clk/samsung/clk-exynos5260.c
 create mode 100644 drivers/clk/samsung/clk-exynos5260.h
 create mode 100644 include/dt-bindings/clk/exynos5260-clk.h

-- 
1.7.9.5
