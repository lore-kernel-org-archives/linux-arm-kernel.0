From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 14 May 2014 16:53:55 -0300
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: Configure the ECSPI1 chip select
 pin
Message-ID: <1400097235-23025-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

GPIO4_9 is used as ECSPI1 chip select and it needs to be configured as GPIO.

Configure the pin functionality explicitly in the dts file instead of relying
on the fact that it comes configured as GPIO from POR or from the bootloader.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 40ea365..56482b4 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -340,6 +340,7 @@
 				MX6QDL_PAD_KEY_COL1__ECSPI1_MISO	0x100b1
 				MX6QDL_PAD_KEY_ROW0__ECSPI1_MOSI	0x100b1
 				MX6QDL_PAD_KEY_COL0__ECSPI1_SCLK	0x100b1
+				MX6QDL_PAD_KEY_ROW1__GPIO4_IO09		0x1b0b0
 			>;
 		};
 
-- 
1.8.3.2
