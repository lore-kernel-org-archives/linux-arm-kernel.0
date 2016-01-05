From: jszhang@marvell.com (Jisheng Zhang)
Date: Tue, 5 Jan 2016 18:51:28 +0800
Subject: [PATCH 00/11] mmc: use sdhci_pltfm_init for private allocation and
 clean up
Message-ID: <1451991099-4946-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches are to complete the TODO in Commit 0e748234293f ("mmc:
sdhci: Add size for caller in init+register"), I.E:

- todo: migrate clients to using allocation this way
- todo: remove priv variable once migration is complete

Jisheng Zhang (11):
  mmc: sdhci-bcm2835: use sdhci_pltfm_init for private allocation
  mmc: sdhci-esdhc-imx: use sdhci_pltfm_init for private allocation
  mmc: sdhci-msm: use sdhci_pltfm_init for private allocation
  mmc: sdhci-of-arasan: use sdhci_pltfm_init for private allocation
  mmc: sdhci-of-at91: use sdhci_pltfm_init for private allocation
  mmc: sdhci-of-esdhc: use sdhci_pltfm_init for private allocation
  mmc: sdhci-pxav3: use sdhci_pltfm_init for private allocation
  mmc: sdhci-st: use sdhci_pltfm_init for private allocation
  mmc: sdhci-tegra: use sdhci_pltfm_init for private allocation
  mmc: sdhci-pxav2: remove unnecessary assignment of pltfm_host->priv
  mmc: sdhci-pltfm: remove priv variable from sdhci_pltfm_host

 drivers/mmc/host/sdhci-bcm2835.c   | 14 +++-----------
 drivers/mmc/host/sdhci-esdhc-imx.c | 38 +++++++++++++++++---------------------
 drivers/mmc/host/sdhci-msm.c       | 13 +++++--------
 drivers/mmc/host/sdhci-of-arasan.c | 25 ++++++++++---------------
 drivers/mmc/host/sdhci-of-at91.c   | 21 ++++++++-------------
 drivers/mmc/host/sdhci-of-esdhc.c  | 17 ++++++++---------
 drivers/mmc/host/sdhci-pltfm.h     |  1 -
 drivers/mmc/host/sdhci-pxav2.c     |  1 -
 drivers/mmc/host/sdhci-pxav3.c     | 21 +++++++++------------
 drivers/mmc/host/sdhci-st.c        | 36 ++++++++++++++++++------------------
 drivers/mmc/host/sdhci-tegra.c     | 19 ++++++-------------
 11 files changed, 84 insertions(+), 122 deletions(-)

-- 
2.6.4
