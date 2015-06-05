From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  5 Jun 2015 21:02:04 +0200
Subject: [PATCH 01/20] ARM: dts: sun4i: Add USB Dual Role Controller
In-Reply-To: <1433530943-12599-1-git-send-email-hdegoede@redhat.com>
References: <1433530943-12599-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1433530943-12599-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node for the otg/drc usb controller to sun4i-a10.dtsi.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index 61c03d1..30f663a 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -611,6 +611,18 @@
 			#size-cells = <0>;
 		};
 
+		usb_otg: usb at 01c13000 {
+			compatible = "allwinner,sun4i-a10-musb";
+			reg = <0x01c13000 0x0400>;
+			clocks = <&ahb_gates 0>;
+			interrupts = <38>;
+			interrupt-names = "mc";
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			allwinner,sram = <&otg_sram 1>;
+			status = "disabled";
+		};
+
 		usbphy: phy at 01c13400 {
 			#phy-cells = <1>;
 			compatible = "allwinner,sun4i-a10-usb-phy";
-- 
2.4.2
