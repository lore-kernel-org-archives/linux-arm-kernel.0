From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 17 Oct 2013 15:19:43 +0800
Subject: [PATCH v2 0/4] mmc: sdhci-esdhc-imx: eliminate enum imx_esdhc_type
Message-ID: <1381994387-9656-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
* Create flags only for features and errata such things, and keep using
  is_imx*_esdhc() for small register differences between esdhc variants.

Shawn Guo (4):
  mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_ENGCM07207
  mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_USDHC
  mmc: sdhci-esdhc-imx: pdev->id_entry should be immutable
  mmc: sdhci-esdhc-imx: create struct esdhc_soc_data

 drivers/mmc/host/sdhci-esdhc-imx.c |  126 +++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 58 deletions(-)

-- 
1.7.9.5
