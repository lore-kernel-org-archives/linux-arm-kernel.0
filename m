From: mpa@pengutronix.de (Markus Pargmann)
Date: Sun, 23 Jun 2013 10:44:18 +0200
Subject: [PATCH v2 2/5] ARM: dts: imx27: Add imx framebuffer device
In-Reply-To: <1371977061-9891-1-git-send-email-mpa@pengutronix.de>
References: <1371977061-9891-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1371977061-9891-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx27.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 8603886..10dcbd3 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -342,6 +342,15 @@
 			reg = <0x10020000 0x20000>;
 			ranges;
 
+			imxfb: fb at 10021000 {
+				compatible = "fsl,imx27-fb", "fsl,imx21-fb";
+				interrupts = <61>;
+				reg = <0x10021000 0x1000>;
+				clocks = <&clks 36>, <&clks 65>, <&clks 59>;
+				clock-names = "ipg", "ahb", "per";
+				status = "disabled";
+			};
+
 			coda: coda at 10023000 {
 				compatible = "fsl,imx27-vpu";
 				reg = <0x10023000 0x0200>;
-- 
1.8.2.1
