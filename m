From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 20 Jun 2013 16:50:12 +0200
Subject: [PATCH 3/6] ARM: dts: imx27: Add imx framebuffer device
In-Reply-To: <1371739815-6666-1-git-send-email-mpa@pengutronix.de>
References: <1371739815-6666-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1371739815-6666-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/imx27.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 4f76453..044004a 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -354,6 +354,15 @@
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
