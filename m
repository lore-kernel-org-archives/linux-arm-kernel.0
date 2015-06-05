From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  5 Jun 2015 21:02:07 +0200
Subject: [PATCH 04/20] ARM: dts: sun7i: Add USB Dual Role Controller
In-Reply-To: <1433530943-12599-1-git-send-email-hdegoede@redhat.com>
References: <1433530943-12599-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1433530943-12599-5-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roman Byshko <rbyshko@gmail.com>

Add a node for the otg/drc usb controller to sun7i-a20.dtsi

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 6a63f30..7549f1b 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -699,6 +699,18 @@
 			#size-cells = <0>;
 		};
 
+		usb_otg: usb at 01c13000 {
+			compatible = "allwinner,sun4i-a10-musb";
+			reg = <0x01c13000 0x0400>;
+			clocks = <&ahb_gates 0>;
+			interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "mc";
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			allwinner,sram = <&otg_sram 1>;
+			status = "disabled";
+		};
+
 		usbphy: phy at 01c13400 {
 			#phy-cells = <1>;
 			compatible = "allwinner,sun7i-a20-usb-phy";
-- 
2.4.2
