From: b20788@freescale.com (Anson Huang)
Date: Mon, 6 Jan 2014 15:57:37 -0500
Subject: [PATCH] ARM: dts: imx6sl: add ocram driver support
Message-ID: <1389041857-18512-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ocram driver support on i.MX6SL.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/boot/dts/imx6sl.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index b526118..575e222 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -532,6 +532,12 @@
 				interrupts = <0 57 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
+			ocram: sram at 00900000 {
+				compatible = "mmio-sram";
+				reg = <0x00900000 0x20000>;
+				clocks = <&clks IMX6SL_CLK_OCRAM>;
+			};
+
 			src: src at 020d8000 {
 				compatible = "fsl,imx6sl-src", "fsl,imx51-src";
 				reg = <0x020d8000 0x4000>;
-- 
1.7.9.5
