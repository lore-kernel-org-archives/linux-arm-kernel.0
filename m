From: shc_work@mail.ru (Alexander Shiyan)
Date: Sat,  6 Jul 2013 11:02:22 +0400
Subject: [PATCH] ARM: dts: i.MX51: Add WEIM node
Message-ID: <1373094142-24173-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the missing (Wireless External Interface Module) WEIM
devicetree node for i.MX51 CPUs.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx51.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 0ca62be..e71976e4 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -745,6 +745,23 @@
 				status = "disabled";
 			};
 
+			weim: weim at 83fda000 {
+				#address-cells = <2>;
+				#size-cells = <1>;
+				compatible = "fsl,imx51-weim";
+				reg = <0x83fda000 0x1000>;
+				clocks = <&clks 0>;
+				ranges = <
+					0 0 0xb0000000 0x08000000
+					1 0 0xb8000000 0x08000000
+					2 0 0xc0000000 0x08000000
+					3 0 0xc8000000 0x04000000
+					4 0 0xcc000000 0x02000000
+					5 0 0xce000000 0x02000000
+				>;
+				status = "disabled";
+			};
+
 			nfc: nand at 83fdb000 {
 				compatible = "fsl,imx51-nand";
 				reg = <0x83fdb000 0x1000 0xcfff0000 0x10000>;
-- 
1.8.1.5
