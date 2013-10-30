From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 30 Oct 2013 22:12:13 +0800
Subject: [PATCH 0/5] mmc: sdhci-esdhc-imx: add runtime pm support
Message-ID: <1383142338-25062-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We disable root clock in runtime pm to save power.

Patch 2~4 are some fixes needed for enable runtime pm or it may
break the UHS cards(SD3.0/eMMC4.5).

Below are some tests result i ran which passed mmc_test tool after enable rpm:
SDHC UHS1 on imx6q sabreauto
eMMC 4.5 on imx6sl evk
SDXC UHS1 on imx6sl evk
eMMC DDR on imx6q sabresd
SDHC on imx6q sabresd

Dong Aisheng (5):
  mmc: sdhci-pltfm: export pltfm suspend/resume api
  mmc: sdhci-esdhc-imx: tuning bits should not be cleared during reset
  mmc: sdhci-esdhc-imx: clear SDHCI_CTRL_EXEC_TUNING should not affect
    other bits
  mmc: sdhci-esdhc-imx: fix runtime pm unblance issue
  mmc: sdhci-esdhc-imx: add runtime pm support

 drivers/mmc/host/sdhci-esdhc-imx.c |   85 ++++++++++++++++++++++++++++++------
 drivers/mmc/host/sdhci-pltfm.c     |    6 ++-
 drivers/mmc/host/sdhci-pltfm.h     |    2 +
 3 files changed, 77 insertions(+), 16 deletions(-)

-- 
1.7.2.rc3
