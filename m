From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat,  8 Jun 2013 12:05:46 +0200
Subject: [PATCH 4/4] ARM: sunxi: dt: Register the pio node as interrupt
 controller
In-Reply-To: <1370685946-3718-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1370685946-3718-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1370685946-3718-5-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 2 ++
 arch/arm/boot/dts/sun5i-a13.dtsi | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index e7ef619..9b3c99c 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -173,8 +173,10 @@
 		pio: pinctrl at 01c20800 {
 			compatible = "allwinner,sun4i-a10-pinctrl";
 			reg = <0x01c20800 0x400>;
+			interrupts = <28>;
 			clocks = <&apb0_gates 5>;
 			gpio-controller;
+			interrupt-controller;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#gpio-cells = <3>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 8ba65c1..f34db19 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -163,8 +163,10 @@
 		pio: pinctrl at 01c20800 {
 			compatible = "allwinner,sun5i-a13-pinctrl";
 			reg = <0x01c20800 0x400>;
+			interrupts = <28>;
 			clocks = <&apb0_gates 5>;
 			gpio-controller;
+			interrupt-controller;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#gpio-cells = <3>;
-- 
1.8.3
