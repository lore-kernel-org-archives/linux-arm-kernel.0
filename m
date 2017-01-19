From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 19 Jan 2017 10:09:23 +0100
Subject: [PATCH 3/4] ARM: dts: imx7d-cl-som: Fix OTG power pinctrl
In-Reply-To: <20170119090924.19636-1-s.hauer@pengutronix.de>
References: <20170119090924.19636-1-s.hauer@pengutronix.de>
Message-ID: <20170119090924.19636-4-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO01_IO05 is controlled by the LPSR iomux controller, so attach
the corresponding pin to this controller.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 58b09bf1ba2d..1135bc99b3e7 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -261,12 +261,6 @@
 		>;
 	};
 
-	pinctrl_usbotg1: usbotg1grp {
-		fsl,pins = <
-			MX7D_PAD_GPIO1_IO05__GPIO1_IO5		0x14 /* OTG PWREN */
-		>;
-	};
-
 	pinctrl_usdhc3: usdhc3grp {
 		fsl,pins = <
 			MX7D_PAD_SD3_CMD__SD3_CMD		0x59
@@ -283,3 +277,11 @@
 		>;
 	};
 };
+
+&iomuxc_lpsr {
+	pinctrl_usbotg1: usbotg1grp {
+		fsl,pins = <
+			MX7D_PAD_GPIO1_IO05__GPIO1_IO5		0x14 /* OTG PWREN */
+		>;
+	};
+};
\ No newline at end of file
-- 
2.11.0
