From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 18 May 2012 09:39:13 +0100
Subject: [PATCH 14/16] ARM: ux500: Add a ab8500-usb Device Tree node for
 db8500 based devices
In-Reply-To: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
References: <1337330355-17747-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1337330355-17747-15-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we specify each of the ab8500 USB driver's seven IRQs, which the
driver references by name. We also apply regulator support for the
three used by the device.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index 37dcc13..dcc5099 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -322,6 +322,27 @@
 					vddadc-supply = <&ab8500_ldo_tvout_reg>;
 				};
 
+				ab8500-usb {
+					compatible = "stericsson,ab8500-usb";
+					interrupts = < 0 90 0x4
+						       0 96 0x4
+						       0 14 0x4
+						       0 15 0x4
+						       0 79 0x4
+						       0 74 0x4
+						       0 75 0x4>;
+					interrupt-names = "ID_WAKEUP_R",
+							  "ID_WAKEUP_F",
+							  "VBUS_DET_F",
+							  "VBUS_DET_R",
+							  "USB_LINK_STATUS",
+							  "USB_ADP_PROBE_PLUG",
+							  "USB_ADP_PROBE_UNPLUG";
+					vddulpivio18-supply = <&ab8500_ldo_initcore_reg>;
+					v-ape-supply = <&db8500_vape_reg>;
+					musb_1v8-supply = <&db8500_vsmps2_reg>;
+				};
+
 				ab8500-ponkey {
 					compatible = "stericsson,ab8500-ponkey";
 					interrupts = <0 6 0x4
-- 
1.7.9.5
