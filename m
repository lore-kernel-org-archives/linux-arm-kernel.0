From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 13 Jan 2015 09:37:35 +0800
Subject: [PATCH v3 13/13] ARM: dts: sun9i: Enable mmc2 on A80 Optimus Board
In-Reply-To: <1421113055-17867-1-git-send-email-wens@csie.org>
References: <1421113055-17867-1-git-send-email-wens@csie.org>
Message-ID: <1421113055-17867-14-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A80 Optimus Board has a 16GB eMMC connected to mmc2, with 8 bit
wide data bus.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index c8e038aafa9f..6a122a13f84e 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -93,6 +93,15 @@
 	status = "okay";
 };
 
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_8bit_pins>;
+	vmmc-supply = <&reg_vcc3v0>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
 &pio {
 	led_pins_optimus: led-pins at 0 {
 		allwinner,pins = "PH0", "PH1";
-- 
2.1.4
