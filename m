From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Tue,  6 Aug 2013 14:04:22 +0530
Subject: [RFC PATCH 0/3] add temporary parent migration support
Message-ID: <1375778065-21808-1-git-send-email-chander.kashyap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some platform has provision to change cpu parent clock during
cpu frequency scaling. This patch series provides a mechanism to
implement the same using CCF.

Patch1 provides mechanism to migrate to new parent temporarily.

Patch2 updates the user of clk_register_mux and DEFINE_CLK_MUX which are
modified to add support for clk migration.

Patch3 adds support to Exynos5250 to use the clock parent migration feature
implemented in CCF.

Chander Kashyap (3):
  clk: add support for temporary parent clock migration
  clk: update users of "clk_register_mux" and "DEFINE_CLK_MUX"
  clk: Exynos5250: Add alternate parent name for mout_cpu

 arch/arm/mach-imx/clk.h                |    6 +-
 arch/arm/mach-omap2/cclock2420_data.c  |    2 +-
 arch/arm/mach-omap2/cclock2430_data.c  |    4 +-
 arch/arm/mach-omap2/cclock33xx_data.c  |    7 +-
 arch/arm/mach-omap2/cclock3xxx_data.c  |    8 +-
 arch/arm/mach-omap2/cclock44xx_data.c  |   61 +++++++------
 drivers/clk/clk-mux.c                  |   13 +--
 drivers/clk/clk.c                      |   45 ++++++++-
 drivers/clk/mmp/clk-mmp2.c             |   39 +++++---
 drivers/clk/mmp/clk-pxa910.c           |   31 ++++---
 drivers/clk/mxs/clk.h                  |    2 +-
 drivers/clk/samsung/clk-exynos-audss.c |    4 +-
 drivers/clk/samsung/clk-exynos4.c      |   10 +-
 drivers/clk/samsung/clk-exynos5250.c   |   10 +-
 drivers/clk/samsung/clk.c              |    3 +-
 drivers/clk/samsung/clk.h              |   17 ++--
 drivers/clk/spear/spear1310_clock.c    |  156 ++++++++++++++++----------------
 drivers/clk/spear/spear1340_clock.c    |   82 +++++++++--------
 drivers/clk/spear/spear3xx_clock.c     |   39 ++++----
 drivers/clk/spear/spear6xx_clock.c     |   18 ++--
 drivers/clk/sunxi/clk-sunxi.c          |    2 +-
 drivers/clk/tegra/clk-tegra114.c       |   24 ++---
 drivers/clk/tegra/clk-tegra20.c        |    4 +-
 drivers/clk/tegra/clk-tegra30.c        |   22 ++---
 drivers/clk/versatile/clk-vexpress.c   |    2 +-
 drivers/clk/zynq/clkc.c                |   36 ++++----
 include/linux/clk-private.h            |   19 ++--
 include/linux/clk-provider.h           |   10 +-
 28 files changed, 379 insertions(+), 297 deletions(-)

-- 
1.7.9.5
