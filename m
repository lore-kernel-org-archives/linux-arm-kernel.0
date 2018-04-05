From: hns@goldelico.com (H. Nikolaus Schaller)
Date: Thu,  5 Apr 2018 18:01:59 +0200
Subject: [PATCH] ARM: dts: omap3-pandora: Add fixed 26MHz clock as fck for twl
Message-ID: <cfb1ac64f31a2b01a506390ecb665a1e66d7ce5d.1522944118.git.hns@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The board uses 26MHz oscillator for the twl4030 HFCLK.
This way we will not depend on the bootloader to configure the
CFG_BOOT:HFCLK_FREQ

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-pandora-common.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index c8d58752e15e..5d9be7d43f05 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -28,6 +28,13 @@
 		display1 = &tv;
 	};
 
+	/* fixed 26MHz oscillator */
+	hfclk_26m: oscillator {
+		#clock-cells = <0>;
+		compatible = "fixed-clock";
+		clock-frequency = <26000000>;
+	};
+
 	tv: connector {
 		compatible = "connector-analog-tv";
 		label = "tv";
@@ -417,6 +424,9 @@
 		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
 		interrupt-parent = <&intc>;
 
+		clocks = <&hfclk_26m>;
+		clock-names = "fck";
+
 		twl_power: power {
 			compatible = "ti,twl4030-power-reset";
 			ti,use_poweroff;
-- 
2.12.2
