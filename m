From: mpfj@newflow.co.uk (Mark Jackson)
Date: Wed, 14 Oct 2015 14:30:48 +0100
Subject: [PATCH] Add USB hooks into NanoBone DTS file
Message-ID: <561E5908.8010004@newflow.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add USB hooks into NanoBone DTS file

Signed-off-by: Mark Jackson <mpfj@newflow.co.uk>
---
 arch/arm/boot/dts/am335x-nano.dts | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-nano.dts b/arch/arm/boot/dts/am335x-nano.dts
index 5ed4ca6..b86937a 100644
--- a/arch/arm/boot/dts/am335x-nano.dts
+++ b/arch/arm/boot/dts/am335x-nano.dts
@@ -375,6 +375,23 @@
 	wp-gpios = <&gpio3 18 0>;
 };
 
+&usb {
+	status = "okay";
+};
+
+&usb_ctrl_mod {
+	status = "okay";
+};
+
+&usb0_phy {
+	status = "okay";
+};
+
+&usb0 {
+	status = "okay";
+	dr_mode = "host";
+};
+
 #include "tps65217.dtsi"
 
 &tps {
-- 
1.9.1
