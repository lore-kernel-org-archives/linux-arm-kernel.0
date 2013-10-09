From: b29396@freescale.com (Dong Aisheng)
Date: Wed, 9 Oct 2013 19:20:06 +0800
Subject: [PATCH 00/10] mmc: sdhci-esdhc-imx: add std tuning for mx6sl and DDR
 mode support
Message-ID: <1381317616-1229-1-git-send-email-b29396@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX6SL supports standard tuning as defined in standard host control spec v3.0.
So this patch series add std tuning support for i.MX6SL.
(NOTE i.MX6SL can also work on the old manual tuning mode as i.MX6Q/DL)
In the meanwhile, it also adds DDR mode support.
Then SD3.0 cards which can only support DDR50 can work properly now
with this patch series.

Patch 1~5 add stardard tuning support for i.MX6SL.
Patch 6~7 add DDR mode and delay line support
Patch 8~10 some other related minor fixes.

Tested on i.MX6SL EVK board.

The patch series is generated based on the latest mmc-next branch in Chris' tree.

Dong Aisheng (10):
  ARM: dts: imx6sl: add pinctrl uhs states for usdhc
  mmc: sdhci-esdhc-imx: add std tuning support for mx6sl
  ARM: dts: imx6sl: change usdhc compatible with imx6sl only
  mmc: sdhci-esdhc-imx: fix reading cap_1 register value for mx6sl
  mmc: sdhci: report error once the maximum tuning loops exhausted or
    timeout
  mmc: sdhci-esdhc-imx: add DDR mode support for mx6
  mmc: sdhci-esdhc-imx: add delay line setting support
  mmc: sdhci-esdhc-imx: enable SDR50 tuning for imx6q/dl
  mmc: sdhci-esdhc-imx: add preset value quirk for mx6
  mmc: sdhci: remove unneeded call when have preset value quirk

 .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |    1 +
 arch/arm/boot/dts/imx6sl-evk.dts                   |   12 ++-
 arch/arm/boot/dts/imx6sl.dtsi                      |   85 +++++++++++-
 drivers/mmc/host/sdhci-esdhc-imx.c                 |  145 ++++++++++++++++----
 drivers/mmc/host/sdhci.c                           |    4 +-
 include/linux/platform_data/mmc-esdhc-imx.h        |    1 +
 6 files changed, 213 insertions(+), 35 deletions(-)

-- 
1.7.2.rc3
