From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 17 Sep 2012 12:48:08 +0200
Subject: [PATCH 0/7] s5p-fimc/mipi-csis drivers cleanup
Message-ID: <1347878888-30001-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is a cleanup of s5p-fimc/mipi-csis drivers and changes required
for adding device tree support. It depends on Arnd's platform data headers
cleanup patch:
"ARM: samsung: move platform_data definitions"
git.kernel.org/?p=linux/kernel/git/arm/arm-soc.git;a=commit;h=d7243bd51b783ffd2

Sylwester Nawrocki (7):
  ARM: samsung: Remove unused fields from FIMC and CSIS platform data
  ARM: samsung: Change __s5p_mipi_phy_control() function signature
  ARM: EXYNOS: Change MIPI-CSIS device regulator supply names
  s5p-csis: Replace phy_enable platform data callback with direct call
  s5p-fimc: Remove unused platform data structure fields
  s5p-csis: Allow to specify pixel clock's source through platform data
  s5p-csis: Change regulator supply names

 arch/arm/mach-exynos/mach-nuri.c           |  7 ++-----
 arch/arm/mach-exynos/mach-origen.c         |  4 ++--
 arch/arm/mach-exynos/mach-universal_c210.c |  7 ++-----
 arch/arm/plat-samsung/setup-mipiphy.c      | 20 +++++++-------------
 drivers/media/video/s5p-fimc/mipi-csis.c   | 23 +++++++++++++----------
 include/linux/platform_data/mipi-csis.h    | 30 ++++++++++++------------------
 include/media/s5p_fimc.h                   |  2 --
 7 files changed, 38 insertions(+), 55 deletions(-)

--
1.7.11.3
