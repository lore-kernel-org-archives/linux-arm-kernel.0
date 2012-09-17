From: mporter@ti.com (Matt Porter)
Date: Mon, 17 Sep 2012 13:22:16 -0400
Subject: [PATCH v2 0/2] Add pinctrl support to omap2-mcspi
Message-ID: <1347902538-21208-1-git-send-email-mporter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
	- warns that pins are not configured by the driver rather than
	  exiting 
	- dummy states are only enabled for OMAP platforms where DT is
	  not populated

This series enables pinctrl support for McSPI. Platforms that boot only
from DT and rely on pinctrl to set pinmuxes appropriately require this
for omap2-mcspi operation.

It has been tested on AM335x BeagleBone with an Adafruit SPI LCD attached
and regression tested on Beagleboard xM booting in the !DT case, using
board-omap3evm.c. 

The series applies on top of Tony's dt-devel branch.

Matt Porter (2):
  spi: omap2-mcspi: add pinctrl support
  ARM: OMAP2+: Enable pinctrl dummy states

 arch/arm/mach-omap2/devices.c |    5 +++++
 drivers/spi/spi-omap2-mcspi.c |    8 ++++++++
 2 files changed, 13 insertions(+)

-- 
1.7.9.5
