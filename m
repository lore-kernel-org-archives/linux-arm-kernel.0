From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 30 May 2013 15:49:23 +0200
Subject: [PATCHv4 4/6] ARM: sunxi: Add EMAC controller node to sun4i DTSI
In-Reply-To: <1369921765-3367-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1369921765-3367-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1369921765-3367-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Tested-by: Richard Genoud <richard.genoud@gmail.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index ff1f41f..983da33 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -163,6 +163,22 @@
 		reg = <0x01c20000 0x300000>;
 		ranges;
 
+		emac: ethernet at 01c0b000 {
+			compatible = "allwinner,sun4i-emac";
+			reg = <0x01c0b000 0x1000>;
+			interrupts = <55>;
+			clocks = <&ahb_gates 17>;
+			status = "disabled";
+		};
+
+		mdio at 01c0b080 {
+			compatible = "allwinner,sun4i-mdio";
+			reg = <0x01c0b080 0x14>;
+			status = "disabled";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		intc: interrupt-controller at 01c20400 {
 			compatible = "allwinner,sun4i-ic";
 			reg = <0x01c20400 0x400>;
-- 
1.8.2.3
