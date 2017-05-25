From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 25 May 2017 15:31:33 +0800
Subject: [PATCH 1/6] ARM: sun7i: a20: cubieboard2: Move usb_otg node for
 alphabetical ordering
In-Reply-To: <20170525073138.20907-1-wens@csie.org>
References: <20170525073138.20907-1-wens@csie.org>
Message-ID: <20170525073138.20907-2-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to keep node references in alphabetical order, except for
instances where node must be #included first.

Move the usb_otg node reference so that all references to non-AXP209
device nodes are in alphabetical order.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index 7ac5bcc9f972..c21edd75d0b3 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -174,11 +174,6 @@
 	status = "okay";
 };
 
-&usb_otg {
-	dr_mode = "otg";
-	status = "okay";
-};
-
 #include "axp209.dtsi"
 
 &reg_dcdc2 {
@@ -220,6 +215,11 @@
 	status = "okay";
 };
 
+&usb_otg {
+	dr_mode = "otg";
+	status = "okay";
+};
+
 &usbphy {
 	pinctrl-names = "default";
 	pinctrl-0 = <&usb0_id_detect_pin>;
-- 
2.11.0
