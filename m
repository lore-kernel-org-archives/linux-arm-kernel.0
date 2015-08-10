From: haibo.chen@freescale.com (Haibo Chen)
Date: Mon, 10 Aug 2015 16:18:02 +0800
Subject: [PATCH v5 0/6] mmc: imx: a few fixes and new feature
Message-ID: <1439194688-18335-1-git-send-email-haibo.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes for v5:
-move the clear exist timing setting to a common place rather than only in HS200 mode.
-put the patch 6 ahead of patch 5.

Haibo Chen (6):
  mmc: sdhci-esdhc-imx: add imx7d support and support HS400
  mmc: sdhci-esdhc-imx: add tuning-step seting support
  mmc: sdhci-esdhc-imx: add compatible string in bingding doc
  ARM: dts: imx7d-sdb: add eMMC5.0 support
  mmc: sdhci-esdhc-imx: set back the burst_length_enable bit to 1
  mmc: sdhci-esdhc-imx: change default watermark level and burst length

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   6 ++
 arch/arm/boot/dts/imx7d-sdb.dts                    |  13 +++
 drivers/mmc/host/sdhci-esdhc-imx.c                 | 116 ++++++++++++++++++++-
 include/linux/platform_data/mmc-esdhc-imx.h        |   1 +
 4 files changed, 132 insertions(+), 4 deletions(-)

-- 
1.9.1
