From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon,  9 Jan 2017 17:46:49 +0100
Subject: [PATCH v2 0/6] arm64: allwinner: a64: Enable MMC support
Message-ID: <cover.493dc67855a5f1837e875d37307319a03d14d1d0.1483980339.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is a second attempt at getting the MMC controllers running, the first
having been done by Andre.

This has been tested on a board with one SDIO device (a Marvell WiFi chip)
and a Kingston eMMC with 1.8V IOs.

For SDIO, the HS DDR mode works just fine. There's a little bit of work to
get to SDR104, but that will come eventually.

For the eMMC, HS200 with the voltage switch works. HS400 doesn't at the
moment, but since it's significantly more complex, and at the same time
Allwinner recommends to limit its frequency to 100MHz, this doesn't have
any benefits. If there's any at some point, this can be added later.

Let me know what you think,
Maxime

Andre Przywara (1):
  arm64: allwinner: a64: Add MMC nodes

Maxime Ripard (5):
  mmc: sunxi: Always set signal delay to 0 for A64
  mmc: sunxi: Enable the new timings for the A64 MMC controllers
  mmc: sunxi: Add EMMC (MMC2) controller compatible
  arm64: allwinner: a64: Add MMC pinctrl nodes
  arm64: allwinner: a64: Increase the MMC max frequency

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 67 ++++++++++++++++++++-
 drivers/mmc/host/sunxi-mmc.c                  | 63 +++++++++----------
 2 files changed, 97 insertions(+), 33 deletions(-)

base-commit: f9ca9b952ee139fbb9cd4d354a33f440bc1049cd
-- 
git-series 0.8.11
