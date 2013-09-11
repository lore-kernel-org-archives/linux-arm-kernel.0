From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 11 Sep 2013 11:10:06 +0200
Subject: [PATCH 1/4] ARM: sun7i: Enable the Ethernet in the A20
In-Reply-To: <1378890609-28563-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1378890609-28563-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1378890609-28563-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A20 SoC also have the EMAC found on the A10 and A10s.
Enable the support for it in the DTSI.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 999ff45..e996f1d 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -167,6 +167,22 @@
 		#size-cells = <1>;
 		ranges;
 
+		emac: ethernet at 01c0b000 {
+			compatible = "allwinner,sun4i-emac";
+			reg = <0x01c0b000 0x1000>;
+			interrupts = <0 55 1>;
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
 		pio: pinctrl at 01c20800 {
 			compatible = "allwinner,sun7i-a20-pinctrl";
 			reg = <0x01c20800 0x400>;
-- 
1.8.4
