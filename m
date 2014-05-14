From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 14 May 2014 20:03:09 +0200
Subject: [GIT PULL 2/4] Samsung clock non-critical fixes for v3.16
In-Reply-To: <1400090591-5064-1-git-send-email-t.figa@samsung.com>
References: <1400090591-5064-1-git-send-email-t.figa@samsung.com>
Message-ID: <1400090591-5064-2-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d39e55e06371c1ba9d11f4a17a56a0f925d12415:

  clk/exynos5260: add clock file for exynos5260 (2014-05-14 19:16:55 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tfiga/samsung-clk.git for_3.16/clk_fixes_non_critical

for you to fetch changes up to 773424326b51cc851b6e28ff22447ba5fcc5f429:

  clk: samsung: exynos5420: add more registers to restore list (2014-05-14 19:40:24 +0200)

----------------------------------------------------------------

Samsung clock non-critical fixes for v3.16.

This pull requests contains a number of non-critical fixes for Samsung clock
framework and drivers, including:

1) a series of fixes for Exynos5420 to correct clock definitions and make the
driver closer to the documentation,

2) several missing clocks and clock IDs added to Exynos4, Exynos5250 and
Exynos5420 drivers,

3) fix for incorrect initialization of clock table with NULL,

4) compiler warning fix.

----------------------------------------------------------------
Arun Kumar K (2):
      clk: samsung: exynos5250: Add clocks for G3D
      clk: samsung: exynos5420: Add clock IDs needed by GPU

Naveen Krishna Chatradhi (1):
      clk: samsung: exynos5250/5420: Add gate clock for SSS module

Pankaj Dubey (1):
      clk: samsung: fixed compiler warning [-Wpointer-to-int-cast]

Sachin Kamat (1):
      clk: samsung: exynos5420: Fix VPLL lock offset

Shaik Ameer Basha (15):
      clk: samsung: exynos5420: Rename mux parent arrays
      clk: samsung: exynos5420: add clocks for ISP block
      clk: samsung: exynos5420: update clocks for GSCL and MSCL blocks
      clk: samsung: exynos5420: fix parent clocks for mscl sysmmu
      clk: samsung: exynos5420: update clocks for G2D and G3D blocks
      clk: samsung: exynos5420: update clocks for DISP1 block
      clk: samsung: exynos5420: update clocks for PERIC block
      clk: samsung: exynos5420: update clocks for PERIS and GEN blocks
      clk: samsung: exynos5420: update clocks for WCORE block
      clk: samsung: exynos5420: update clocks for FSYS and FSYS2 blocks
      clk: samsung: exynos5420: correct sysmmu-mfc parent clocks
      clk: samsung: exynos5420: fix register offset for sclk_bpll
      clk: samsung: exynos5420: update clocks for MAU Block
      clk: samsung: exynos5420: add misc clocks
      clk: samsung: exynos5420: add more registers to restore list

Sylwester Nawrocki (1):
      clk: samsung: exynos4: Use single clock ID for CLK_MDMA gate clocks

Tomasz Figa (1):
      clk: samsung: Initialize clock table with error pointers

Tomasz Stanislawski (1):
      clk: samsung: exynos4: export sclk_hdmiphy clock

 arch/arm/boot/dts/exynos5420.dtsi      |  14 +-
 drivers/clk/samsung/clk-exynos4.c      |   4 +-
 drivers/clk/samsung/clk-exynos5250.c   |  16 +-
 drivers/clk/samsung/clk-exynos5420.c   | 854 +++++++++++++++++++++------------
 drivers/clk/samsung/clk.c              |   9 +-
 include/dt-bindings/clock/exynos4.h    |   2 +-
 include/dt-bindings/clock/exynos5250.h |   5 +-
 include/dt-bindings/clock/exynos5420.h |  39 +-
 8 files changed, 608 insertions(+), 335 deletions(-)
