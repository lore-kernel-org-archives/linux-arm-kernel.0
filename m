From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 28 Apr 2014 16:12:36 +0200
Subject: [PATCH 3/3] ARM: dts: imx6dl, fix i2c4 device node
In-Reply-To: <1398694356-22511-1-git-send-email-mpa@pengutronix.de>
References: <1398694356-22511-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1398694356-22511-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i2c4 is exactly the same hardware module as i2c 1 to 3. The compatible
property is wrong and the appropriate clock was missing.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx6dl.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index 9c4942f..a48a542 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -84,9 +84,10 @@
 			i2c4: i2c at 021f8000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-				compatible = "fsl,imx1-i2c";
+				compatible = "fsl,imx6q-i2c", "fsl,imx21-i2c";
 				reg = <0x021f8000 0x4000>;
 				interrupts = <0 35 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks 209>;
 				status = "disabled";
 			};
 		};
-- 
1.9.1
