From: tpiepho@impinj.com (Trent Piepho)
Date: Mon,  6 Nov 2017 11:46:15 -0800
Subject: [PATCH v4 0/3] Fix for imx-spi CS GPIOs
Message-ID: <20171106194618.9421-1-tpiepho@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes from V1:
 * Collected reviewed bys.
 * Minor change to coding style in one patch.

Changes from V2:
 * Reverted minor coding change from V2, it was right to begin with
 * Have imx-spi also honor "num-cs" property
 * Leak of spi_bitbang on failure needed to be fixed differently
 * Port to linux-next, which has other changes to spi-imx

Changes from V3:
 * Remove leak fix patch which was applied separately.
 * Add documentation about native CS to driver tree bindings document.

CC: Shawn Guo <shawnguo@kernel.org>,
CC: Sascha Hauer <kernel@pengutronix.de>,
CC: Fabio Estevam <fabio.estevam@nxp.com>,
CC: Mark Brown <broonie@kernel.org>

Trent Piepho (3):
  spi: imx: GPIO chip select DT property should not be required
  spi: imx: Don't require platform data chipselect array
  ARM: imx: Update spi_imx platform data to reflect current state

 .../devicetree/bindings/spi/fsl-imx-cspi.txt       | 18 ++++++++----
 arch/arm/mach-imx/mach-mx31_3ds.c                  | 18 ++----------
 arch/arm/mach-imx/mach-mx31lilly.c                 | 12 ++------
 arch/arm/mach-imx/mach-mx31lite.c                  | 16 ++---------
 arch/arm/mach-imx/mach-mx31moboard.c               | 17 ++----------
 arch/arm/mach-imx/mach-pcm037_eet.c                |  5 +---
 drivers/spi/spi-imx.c                              | 32 ++++++++++++----------
 include/linux/platform_data/spi-imx.h              | 29 ++++++++++++--------
 8 files changed, 57 insertions(+), 90 deletions(-)

-- 
2.14.3
