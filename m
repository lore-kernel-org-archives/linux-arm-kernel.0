From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 17 Jan 2015 13:19:34 +0800
Subject: [PATCH v4 9/9] ARM: dts: sun9i: Enable mmc2 on A80 Optimus Board
In-Reply-To: <1421471974-32719-1-git-send-email-wens@csie.org>
References: <1421471974-32719-1-git-send-email-wens@csie.org>
Message-ID: <1421471974-32719-10-git-send-email-wens@csie.org>
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
index 5c9505a724d4..c4de9cb9a5f6 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -120,6 +120,15 @@
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
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_pins_a>;
-- 
2.1.4
