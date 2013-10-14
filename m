From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 14 Oct 2013 16:23:39 +0800
Subject: [PATCH 0/5] mmc: sdhci-esdhc-imx: eliminate enum imx_esdhc_type
Message-ID: <1381739024-24924-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When I was reviewing Dong's imx6sl standard tuning patches, I found that
it's a little clumsy to use enum imx_esdhc_type for handling features
and quirks on different esdhc variants.  Instead, the approach used in
fec driver (drivers/net/ethernet/freescale/fec_main.c) should be more
scalable in the long run.  It defines flags for all those features and
quirks and creates a mapping between esdhc variant and the flags.

Actually, sdhci-esdhc-imx driver already has one such flag, i.e.
ESDHC_FLAG_MULTIBLK_NO_INT, but there is currently an unnecessary
translation between the flag and imx_esdhc_type.  The series creates
another 3 flags and identify features/quirks using these flags and then
eliminate enum imx_esdhc_type completely.

Shawn Guo (5):
  mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_NO_DMAS_BITS
  mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_ENGCM07207
  mmc: sdhci-esdhc-imx: add flag ESDHC_FLAG_USDHC
  mmc: sdhci-esdhc-imx: pdev->id_entry should be immutable
  mmc: sdhci-esdhc-imx: eliminate enum imx_esdhc_type

 drivers/mmc/host/sdhci-esdhc-imx.c |  108 +++++++++++++++---------------------
 1 file changed, 45 insertions(+), 63 deletions(-)

-- 
1.7.9.5
