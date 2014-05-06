From: shaik.ameer@samsung.com (Shaik Ameer Basha)
Date: Tue, 06 May 2014 21:56:35 +0530
Subject: [PATCH v4 00/15] exynos5420: clock file cleanup
Message-ID: <1399393610-23394-1-git-send-email-shaik.ameer@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Many changes/fixes have been identified for clock file for exynos5420.
These include correct parents, bit fields, new clocks etc. Existing
files needs some correction in terms of names of the clock and
indentation. These issues are addressed in this patch series.

This patch series is rebased on,
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git:3.15-rc3

This patch is also dependent on the following patch.
clk: exynos5420: Add clock IDs needed by GPU
    -- http://www.spinics.net/lists/arm-kernel/msg326461.html

This patch series is tested on Exynos5420 based peach-pit board.
[PATCH v4 0/2] Add peach-pit board support

Changes since v3:
-----------------
Addressed review comments from Tomasz Figa and Alim Akhtar
Some of the changes includes,
1] Adding clock IDs for all the added gate clocks.
2] Followed bit ordering while defining new clocks.
3] Adding SET_RATE_PARENT flag for all the clocks having
   dividers as parents.

Changes since v2:
-----------------
1] Addressed review comments from Gerhard Sittig and Tomasz Figa.

Changes since v1:
-----------------
1] Addressed review comments from Tomasz Figa.
    http://www.spinics.net/lists/devicetree/msg16759.html
    http://www.spinics.net/lists/devicetree/msg16760.html

Shaik Ameer Basha (15):
  clk: exynos5420: Rename mux parent arrays
  clk: exynos5420: add clocks for ISP block
  clk: exynos5420: update clocks for GSCL and MSCL blocks
  clk: exynos5420: fix parent clocks for mscl sysmmu
  clk: exynos5420: update clocks for G2D and G3D blocks
  clk: exynos5420: update clocks for DISP1 block
  clk: exynos5420: update clocks for PERIC block
  clk: exynos5420: update clocks for PERIS and GEN blocks
  clk: exynos5420: clk: exynos5420: update clocks for WCORE block
  clk: exynos5420: update clocks for FSYS and FSYS2 blocks
  clk: exynos5420: correct sysmmu-mfc parent clocks
  clk: exynos5420: fix register offset for sclk_bpll
  clk: exynos5420: update clocks for MAU Block
  clk: exynos5420: add misc clocks
  clk: exynos5420: add more registers to restore list

 arch/arm/boot/dts/exynos5420.dtsi      |   14 +-
 drivers/clk/samsung/clk-exynos5420.c   |  876 ++++++++++++++++++++------------
 include/dt-bindings/clock/exynos5420.h |   39 +-
 3 files changed, 597 insertions(+), 332 deletions(-)

-- 
1.7.9.5
