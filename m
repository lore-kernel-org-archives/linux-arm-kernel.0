From: tpiepho@impinj.com (Trent Piepho)
Date: Tue, 31 Oct 2017 12:49:03 -0700
Subject: [PATCH v3 0/4] Fix for imx-spi CS GPIOs
Message-ID: <20171031194907.29108-1-tpiepho@impinj.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a bug where GPIO based chip selects must be specified in the OF
node for spi-imx when they should be optional.

Fixes a regression in the platform data of imx31moboard.

Clean up of some old platform data based spi-imx users.

Changes from V1:
 * Collected reviewed bys.
 * Minor change to coding style in one patch.

Changes from V2:
 * Reverted minor coding change from V2, it was right to begin with
 * Have imx-spi also honor "num-cs" property
 * Leak of spi_bitbang on failure needed to be fixed differently
 * Port to linux-next, which has other changes to spi-imx

Trent Piepho (4):
  spi: imx: GPIO based chip selects should not be required
  spi: imx: Fix failure path leak on GPIO request error
  spi: imx: Don't require platform data chipselect array
  ARM: imx: Update spi_imx platform data to reflect current state

 arch/arm/mach-imx/mach-mx31_3ds.c     | 18 ++----------------
 arch/arm/mach-imx/mach-mx31lilly.c    | 12 ++----------
 arch/arm/mach-imx/mach-mx31lite.c     | 16 ++--------------
 arch/arm/mach-imx/mach-mx31moboard.c  | 17 +++--------------
 arch/arm/mach-imx/mach-pcm037_eet.c   |  5 +----
 drivers/spi/spi-imx.c                 | 36 ++++++++++++++++++++---------------
 include/linux/platform_data/spi-imx.h | 29 ++++++++++++++++------------
 7 files changed, 48 insertions(+), 85 deletions(-)

-- 
2.14.3
