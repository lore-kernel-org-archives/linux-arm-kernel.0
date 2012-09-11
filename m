From: mporter@ti.com (Matt Porter)
Date: Tue, 11 Sep 2012 13:46:37 -0400
Subject: [PATCH 0/2] Add pinctrl support to omap2-mcspi
Message-ID: <1347385599-27558-1-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables pinctrl support for McSPI. Platforms that boot only
from DT and rely on pinctrl to set pinmuxes appropriately require this
for omap2-mcspi operation.

It has been tested on AM335x BeagleBone with an Adafruit SPI LCD attached
and regression tested on Beagleboard xM booting in the !DT case, using
board-omap3evm.c. There is a dependency on the patch to enable PINCTRL
support (https://patchwork.kernel.org/patch/1376331/) for
ARCH_OMAP2PLUS_TYPICAL.

Matt Porter (2):
  spi: omap2-mcspi: add pinctrl support
  ARM: OMAP2+: Enable pinctrl dummy states

 arch/arm/mach-omap2/devices.c |    4 ++++
 drivers/spi/spi-omap2-mcspi.c |    9 +++++++++
 2 files changed, 13 insertions(+)

-- 
1.7.9.5
