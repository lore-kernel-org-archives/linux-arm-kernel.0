From: venkataravi.e@techveda.org (venkataravi.e at techveda.org)
Date: Fri,  1 Dec 2017 12:08:29 +0530
Subject: [PATCH 2/4] arm: dts: imx28: Remove system bus unit addresses
In-Reply-To: <1512110311-15788-1-git-send-email-venkataravi.e@techveda.org>
References: <1512110311-15788-1-git-send-email-venkataravi.e@techveda.org>
Message-ID: <1512110311-15788-3-git-send-email-venkataravi.e@techveda.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ravi Eluri <venkataravi.e@techveda.org>

Unit addresses for the system buses of imx28 are defined in
the corresponding dtsi file. Any peripheral node on APBH, APBX
and AHB busses can be accessed via phandle. Removed duplicate
system bus unit address entries, this makes the DT more robust
and readable.

Signed-off-by: Ravi Eluri <venkataravi.e@techveda.org>
Signed-off-by: Suniel Mahesh <sunil.m@techveda.org>
---
Note:
- This is the second patch of the four patch series.
- Patch was compile tested and built(ARCH=arm, imx28) on linux-next
  (latest).
- No build issues reported.
- Please discard this changeset, if this is not making any better.
---
 arch/arm/boot/dts/imx28-evk.dts | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 21ac4fa..28564864 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -20,8 +20,6 @@
 		reg = <0x40000000 0x08000000>;
 	};
 
-	apb at 80000000 {
-		apbh at 80000000 {
 			&gpmi {
 				pinctrl-names = "default";
 				pinctrl-0 = <&gpmi_pins_a &gpmi_status_cfg
@@ -165,9 +163,7 @@
 				xceiver-supply = <&reg_can_3v3>;
 				status = "okay";
 			};
-		};
 
-		apbx at 80040000 {
 			&saif0 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&saif0_pins_a>;
@@ -241,10 +237,7 @@
 			&usbphy1 {
 				status = "okay";
 			};
-		};
-	};
 
-	ahb at 80080000 {
 		&usb0 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&usb0_id_pins_a>;
@@ -273,7 +266,6 @@
 			pinctrl-0 = <&mac1_pins_a>;
 			status = "okay";
 		};
-	};
 
 	regulators {
 		compatible = "simple-bus";
-- 
1.9.1
