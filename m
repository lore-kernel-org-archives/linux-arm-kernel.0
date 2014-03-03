From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 03 Mar 2014 09:56:12 +0000 (GMT)
Subject: [GIT PULL 5/6] Samsung PM updates for v3.15
Message-ID: <8259832.260591393840570438.JavaMail.weblogic@epml16>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git tags/samsung-pm-1

for you to fetch changes up to e11d919e4aa2009077e3e4f829ff991d37adca61:

  ARM: EXYNOS: Drop legacy Exynos4 clock suspend/resume code (2014-02-14 08:16:01 +0900)

----------------------------------------------------------------
Samsung S2R PM updates for v3.15

>From Tomasz Figa:
This series reworks suspend/resume handling of Samsung clock drivers
to cover more SoC specific aspects that are beyond simple register
save and restore. The goal is to have all the suspend/resume code
that touches the clock controller in single place, which is the clock
driver.

----------------------------------------------------------------
Tomasz Figa (9):
      clk: exynos4: Remove remnants of non-DT support
      clk: samsung: Provide common helpers for register save/restore
      clk: samsung: exynos4: Move suspend/resume handling to SoC driver
      clk: samsung: exynos5250: Move suspend/resume handling to SoC driver
      clk: samsung: exynos5420: Move suspend/resume handling to SoC driver
      clk: samsung: s3c64xx: Move suspend/resume handling to SoC driver
      clk: samsung: Drop old suspend/resume code
      clk: samsung: exynos4: Add remaining suspend/resume handling
      ARM: EXYNOS: Drop legacy Exynos4 clock suspend/resume code

 arch/arm/mach-exynos/pm.c            |  148 +----------------------------
 drivers/clk/samsung/clk-exynos4.c    |  172 ++++++++++++++++++++++++++++++----
 drivers/clk/samsung/clk-exynos5250.c |   49 +++++++++-
 drivers/clk/samsung/clk-exynos5420.c |   49 +++++++++-
 drivers/clk/samsung/clk-exynos5440.c |    2 +-
 drivers/clk/samsung/clk-s3c64xx.c    |   79 +++++++++++++---
 drivers/clk/samsung/clk.c            |   71 +++++---------
 drivers/clk/samsung/clk.h            |   14 ++-
 8 files changed, 348 insertions(+), 236 deletions(-)
