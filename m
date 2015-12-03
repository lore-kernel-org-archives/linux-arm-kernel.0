From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu,  3 Dec 2015 15:02:07 -0300
Subject: [PATCH 0/2] ARM: dts: Use MMC pwrseq instead regulators for IGEP WiFi
 init
Message-ID: <1449165729-993-1-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series converts the IGEPv2 (IGEP0020) and IGEP COM Module (IGEP0030)
Device Tree to use the MMC power sequence provider to initialize the SDIO
WiFi chip instead of using fake fixed regulators to just toggle the Reset
and Power pins in the chip.

The patches were tested on an DM3730 IGEPv2 board but the IGEP COM Module
is the same with regard to the SDIO WiFi so it should be safe to land too.

The IGEPv2 Rev.F and the IGEP COM Module Rev.G DTS were not converted due
using a different WiFi chip (wlcore instead of libertas) than the one in
the board I've access to test so I preferred to leave those untouched.

Best regards,
Javier


Javier Martinez Canillas (2):
  ARM: dts: omap3-igep0020: Use MMC pwrseq to init SDIO WiFi
  ARM: dts: omap3-igep0030: Use MMC pwrseq to init SDIO WiFi

 arch/arm/boot/dts/omap3-igep0020.dts | 24 ++++++++----------------
 arch/arm/boot/dts/omap3-igep0030.dts | 24 ++++++++----------------
 2 files changed, 16 insertions(+), 32 deletions(-)

-- 
2.4.3
