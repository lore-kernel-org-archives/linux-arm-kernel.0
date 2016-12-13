From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 13 Dec 2016 23:22:51 +0800
Subject: [PATCH 5/6] ARM: dts: sun8i: set cpu-supply in reference tablet DTSI
In-Reply-To: <20161213152252.53749-1-icenowy@aosc.xyz>
References: <20161213152252.53749-1-icenowy@aosc.xyz>
Message-ID: <20161213152252.53749-6-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All reference design A33 tablets uses DCDC2 of AXP223 as the power
supply of the Cortex-A7 cores.

Set the cpu-supply in the DTSI of sun8i reference tablets.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
index 08cd00143635..7ac8bb4bc95a 100644
--- a/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
+++ b/arch/arm/boot/dts/sun8i-reference-design-tablet.dtsi
@@ -213,6 +213,10 @@
 	regulator-name = "vcc-rtc";
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &r_uart {
 	pinctrl-names = "default";
 	pinctrl-0 = <&r_uart_pins_a>;
-- 
2.11.0
