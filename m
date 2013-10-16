From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 16 Oct 2013 13:08:09 +0200
Subject: [PATCH 0/9] Samsung clock PM consolidation part 1
Message-ID: <1381921698-5060-1-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series reworks suspend/resume handling of Samsung clock drivers
to cover more SoC specific aspects that are beyond simple register
save and restore. The goal is to have all the suspend/resume code
that touches the clock controller in single place, which is the
clock driver.

On Exynos4210-based Trats, Exynos4412-based Trats2 and Exynos5250-based
Arndale boards (except suspend/resume, which is broken because of
unrelated reasons):

Tested-by: Tomasz Figa <t.figa@samsung.com>

Tomasz Figa (9):
  clk: exynos4: Remove remnants of non-DT support
  clk: samsung: Provide common helpers for register save/restore
  clk: samsung: exynos4: Move suspend/resume handling to SoC driver
  clk: samsung: exynos5250: Move suspend/resume handling to SoC driver
  clk: samsung: exynos5420: Move suspend/resume handling to SoC driver
  clk: samsung: s3c64xx: Move suspend/resume handling to SoC driver
  clk: samsung: Drop old suspend/resume code
  clk: samsung: exynos4: Add remaining suspend/resume handling
  ARM: EXYNOS: pm: Drop legacy Exynos4 clock suspend/resume code

 arch/arm/mach-exynos/pm.c            | 125 +-------------------------
 drivers/clk/samsung/clk-exynos4.c    | 170 ++++++++++++++++++++++++++++++-----
 drivers/clk/samsung/clk-exynos5250.c |  49 ++++++++--
 drivers/clk/samsung/clk-exynos5420.c |  49 ++++++++--
 drivers/clk/samsung/clk-exynos5440.c |   2 +-
 drivers/clk/samsung/clk-s3c64xx.c    |  79 +++++++++++++---
 drivers/clk/samsung/clk.c            |  71 ++++++---------
 drivers/clk/samsung/clk.h            |  14 ++-
 8 files changed, 346 insertions(+), 213 deletions(-)

-- 
1.8.3.2
