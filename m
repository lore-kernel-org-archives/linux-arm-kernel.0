From: emilio@elopez.com.ar (=?UTF-8?q?Emilio=20L=C3=B3pez?=)
Date: Wed, 27 Mar 2013 18:20:41 -0300
Subject: [PATCH v2 5/7] arm: sunxi: Add clock to pinctrl node
In-Reply-To: <1364419243-18446-1-git-send-email-emilio@elopez.com.ar>
References: <1363962042-29536-1-git-send-email-emilio@elopez.com.ar>
 <1364419243-18446-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <1364419243-18446-6-git-send-email-emilio@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The port controller needs the apb0_pio clock enabled to be able to
work. This commit declares that on the device tree.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---

Changes from v1:
  - no changes

 arch/arm/boot/dts/sun4i-a10.dtsi | 1 +
 arch/arm/boot/dts/sun5i-a13.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 6b3a6b2..f640520 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -21,6 +21,7 @@
 		pio: pinctrl at 01c20800 {
 			compatible = "allwinner,sun4i-a10-pinctrl";
 			reg = <0x01c20800 0x400>;
+			clocks = <&apb0_gates 5>;
 			gpio-controller;
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 945bfac..10ee8ee 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -22,6 +22,7 @@
 		pio: pinctrl at 01c20800 {
 			compatible = "allwinner,sun5i-a13-pinctrl";
 			reg = <0x01c20800 0x400>;
+			clocks = <&apb0_gates 5>;
 			gpio-controller;
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
1.8.2
