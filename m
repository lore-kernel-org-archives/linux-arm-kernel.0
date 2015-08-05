From: haibo.chen@freescale.com (Haibo Chen)
Date: Wed, 5 Aug 2015 18:38:36 +0800
Subject: [PATCH v4 0/6] mmc: imx: a few fixes and new feature
Message-ID: <1438771122-8601-1-git-send-email-haibo.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes for v4:
-Call esdhc_set_strobe_dll() only when device clock is over 100MHz in HS400 mode.
-Add detail description of tuning-step.
-Change to default watermark level and burst length for all imx SoC, not only imx7d.

Haibo Chen (6):
  mmc: sdhci-esdhc-imx: add imx7d support and support HS400
  mmc: sdhci-esdhc-imx: add tuning-step seting support
  mmc: sdhci-esdhc-imx: add compatible string in bingding doc
  ARM: dts: imx7d-sdb: add eMMC5.0 support
  mmc: sdhci-esdhc-imx: change default watermark level and burst length
  mmc: sdhci-esdhc-imx: set back the burst_length_enable bit to 1

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   6 ++
 arch/arm/boot/dts/imx7d-sdb.dts                    |  13 +++
 drivers/mmc/host/sdhci-esdhc-imx.c                 | 109 ++++++++++++++++++++-
 include/linux/platform_data/mmc-esdhc-imx.h        |   1 +
 4 files changed, 128 insertions(+), 1 deletion(-)

-- 
1.9.1
