From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 10 Mar 2017 11:17:30 +0800
Subject: [PATCH 0/3] mmc: sdhci: remove unnecessary platform_set_drvdata() call
Message-ID: <20170310031733.812-1-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sdhci_pltfm_init() has already set the platform drvdata for us, so its
users doesn't need to set the drvdata again. These patches clean up all
unnecessary platform_set_drvdata() call.

Jisheng Zhang (3):
  mmc: sdhci-pxav3: remove unnecessary platform_set_drvdata() call
  mmc: sdhci-pxav2: remove unnecessary platform_set_drvdata() call
  mmc: sdhci-st: remove unnecessary platform_set_drvdata() call

 drivers/mmc/host/sdhci-pxav2.c | 2 --
 drivers/mmc/host/sdhci-pxav3.c | 2 --
 drivers/mmc/host/sdhci-st.c    | 2 --
 3 files changed, 6 deletions(-)

-- 
2.11.0
