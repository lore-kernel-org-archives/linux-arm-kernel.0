From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 10 Jun 2011 18:42:48 +0800
Subject: [PATCH 0/4] Extend sdhci-esdhc-imx card_detect and write_protect
	support for mx5
Message-ID: <1307702572-22066-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The card-present polling within sdhci based driver is very expensive
in terms of the impact to system performance.  We observe a few
system performance issues from Freescale and Linaro on mx5 platforms,
which have been proved card polling related.

The patch set extends the current sdhci-esdhc-imx card_detect and
write_protect support to cover mx5 platforms, and solves above
performance issues.

Shawn Guo (4):
      mmc: sdhci: fix interrupt storm from card detection
      mmc: sdhci-esdhc-imx: SDHCI_CARD_PRESENT does not get cleared
      mmc: sdhci-esdhc-imx: remove "WP" from flag ESDHC_FLAG_GPIO_FOR_CD_WP
      mmc: sdhci-esdhc-imx: extend card_detect and write_protect support

 arch/arm/mach-imx/eukrea_mbimxsd25-baseboard.c |    3 +-
 arch/arm/mach-imx/eukrea_mbimxsd35-baseboard.c |    3 +-
 arch/arm/mach-imx/mach-mx25_3ds.c              |    2 +
 arch/arm/mach-imx/mach-mx35_3ds.c              |    7 +-
 arch/arm/mach-imx/mach-pcm043.c                |    2 +
 arch/arm/mach-imx/mach-vpr200.c                |    7 +-
 arch/arm/mach-mx5/board-mx51_3ds.c             |    7 +-
 arch/arm/mach-mx5/board-mx51_babbage.c         |   27 +++++-
 arch/arm/mach-mx5/board-mx51_efikamx.c         |    7 +-
 arch/arm/mach-mx5/board-mx51_efikasb.c         |    7 +-
 arch/arm/mach-mx5/board-mx53_evk.c             |   14 +++-
 arch/arm/mach-mx5/board-mx53_loco.c            |   14 +++-
 arch/arm/mach-mx5/board-mx53_smd.c             |   21 ++++-
 arch/arm/mach-mx5/eukrea_mbimx51-baseboard.c   |   14 +++-
 arch/arm/mach-mx5/eukrea_mbimxsd-baseboard.c   |    7 +-
 arch/arm/mach-mx5/mx51_efika.c                 |    7 +-
 arch/arm/plat-mxc/include/mach/esdhc.h         |   25 ++++-
 drivers/mmc/host/sdhci-esdhc-imx.c             |  117 +++++++++++++----------
 drivers/mmc/host/sdhci.c                       |   13 ++-
 19 files changed, 225 insertions(+), 79 deletions(-)
