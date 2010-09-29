From: w.sang@pengutronix.de (Wolfram Sang)
Date: Wed, 29 Sep 2010 22:07:58 +0200
Subject: [PATCH V3 0/6] SD/MMC-driver for MX35/51 (and improvements to SDHCI)
Message-ID: <1285790884-3516-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Okay, here is the next version of my patch series. The first four are
updates/improvements for sdhci and sdhci-pltfm and are of generic interest,
too. I am still hoping for some Acked-by/Tested-by tags ;) Changes from the
previous version are mentioned in the seperate files. I should have addressed
all concerns raised. If not, please speak up.

Thanks,

   Wolfram

Wolfram Sang (6):
  mmc: sdhci-pltfm: Add structure for host-specific data
  mmc: sdhci-pltfm: move .h-file into apropriate subdir
  mmc: sdhci: introduce private get_ro
  mmc: sdhci_pltfm: pass more data on custom init-call
  mmc: sdhci-of-esdhc: factor out common stuff
  mmc: sdhci-pltfm: add pltfm-driver for imx35/51

 drivers/mmc/host/Kconfig           |   10 +++
 drivers/mmc/host/Makefile          |    1 +
 drivers/mmc/host/sdhci-cns3xxx.c   |    2 +-
 drivers/mmc/host/sdhci-esdhc-imx.c |  143 ++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-esdhc.h     |   81 ++++++++++++++++++++
 drivers/mmc/host/sdhci-of-esdhc.c  |   70 ++----------------
 drivers/mmc/host/sdhci-pltfm.c     |   22 ++++--
 drivers/mmc/host/sdhci-pltfm.h     |   10 ++-
 drivers/mmc/host/sdhci.c           |   11 ++-
 drivers/mmc/host/sdhci.h           |    1 +
 include/linux/mmc/sdhci-pltfm.h    |   35 +++++++++
 include/linux/sdhci-pltfm.h        |   35 ---------
 12 files changed, 310 insertions(+), 111 deletions(-)
 create mode 100644 drivers/mmc/host/sdhci-esdhc-imx.c
 create mode 100644 drivers/mmc/host/sdhci-esdhc.h
 create mode 100644 include/linux/mmc/sdhci-pltfm.h
 delete mode 100644 include/linux/sdhci-pltfm.h
