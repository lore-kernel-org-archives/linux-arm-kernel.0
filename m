From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 28 Jun 2013 16:50:35 +0200
Subject: [PATCH v3 3/5] ARM: dts: imx27: Add 1-wire
In-Reply-To: <1372431037-13519-1-git-send-email-mpa@pengutronix.de>
References: <1372431037-13519-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1372431037-13519-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

Notes:
    Changes in v3:
     - Removed clock-names, not necessary for this driver.
    
    Changes in v2:
     - Add fsl,imx27-owire as first entry in the compatibility list.

 arch/arm/boot/dts/imx27.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 10dcbd3..a79f173 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -110,6 +110,13 @@
 				clock-names = "ipg", "per";
 			};
 
+			owire: owire at 10009000 {
+				compatible = "fsl,imx27-owire", "fsl,imx21-owire";
+				reg = <0x10009000 0x1000>;
+				clocks = <&clks 35>;
+				status = "disabled";
+			};
+
 			uart1: serial at 1000a000 {
 				compatible = "fsl,imx27-uart", "fsl,imx21-uart";
 				reg = <0x1000a000 0x1000>;
-- 
1.8.2.1
