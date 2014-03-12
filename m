From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Wed, 12 Mar 2014 20:26:43 +0530
Subject: [PATCH v5 0/5] clk: exynos: add support for exynos5260 SoC
Message-ID: <1394636208-3125-1-git-send-email-rahul.sharma@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Sharma <Rahul.Sharma@samsung.com>

Add clock support for exynos5260 SoC.

This series is based on Tomasz Figa's samsung-next branch.

V5:
  1) Include S3c2412 and S3c2443 in clock provider patch.
  2) Added SCLK_TOP_FIMD with CLK_IGNORE_UNUSED due to Suspend
  failure.
  3) Moved exynos5260-clk.h to include/dt-bindings/clock.
  4) Fix exynos5260_clk_sleep_init protoype for PM disabled.
  5) Moved fixed clock registeration to DT.
  6) Removed CLK_IGNORE_UNUSED flags from UART clocks. Earlier
  facing issues because of RFS probing all TTYs.

V4:
  1) Rework clock file as per Tomasz review comments at
        http://www.spinics.net/lists/arm-kernel/msg310116.html.

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

 .../devicetree/bindings/clock/exynos5260-clock.txt |   55 +
 drivers/clk/samsung/Makefile                       |    1 +
 drivers/clk/samsung/clk-exynos4.c                  |   47 +-
 drivers/clk/samsung/clk-exynos5250.c               |   25 +-
 drivers/clk/samsung/clk-exynos5260.c               | 1805 ++++++++++++++++++++
 drivers/clk/samsung/clk-exynos5260.h               |  448 +++++
 drivers/clk/samsung/clk-exynos5420.c               |   24 +-
 drivers/clk/samsung/clk-exynos5440.c               |   18 +-
 drivers/clk/samsung/clk-pll.c                      |  223 ++-
 drivers/clk/samsung/clk-pll.h                      |    2 +
 drivers/clk/samsung/clk-s3c2412.c                  |   29 +-
 drivers/clk/samsung/clk-s3c2443.c                  |   46 +-
 drivers/clk/samsung/clk-s3c64xx.c                  |   44 +-
 drivers/clk/samsung/clk.c                          |  114 +-
 drivers/clk/samsung/clk.h                          |   72 +-
 include/dt-bindings/clock/exynos5260-clk.h         |  233 +++
 16 files changed, 3004 insertions(+), 182 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/exynos5260-clock.txt
 create mode 100644 drivers/clk/samsung/clk-exynos5260.c
 create mode 100644 drivers/clk/samsung/clk-exynos5260.h
 create mode 100644 include/dt-bindings/clock/exynos5260-clk.h

-- 
1.7.9.5
