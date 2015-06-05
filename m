From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  5 Jun 2015 21:02:06 +0200
Subject: [PATCH 03/20] ARM: dts: sun6i: Add USB Dual Role Controller
In-Reply-To: <1433530943-12599-1-git-send-email-hdegoede@redhat.com>
References: <1433530943-12599-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1433530943-12599-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node for the otg/drc usb controller to sun6i-a31.dtsi.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 008047a..5bc6933 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -512,6 +512,18 @@
 			#size-cells = <0>;
 		};
 
+		usb_otg: usb at 01c19000 {
+			compatible = "allwinner,sun6i-a31-musb";
+			reg = <0x01c19000 0x0400>;
+			clocks = <&ahb1_gates 24>;
+			resets = <&ahb1_rst 24>;
+			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "mc";
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			status = "disabled";
+		};
+
 		usbphy: phy at 01c19400 {
 			compatible = "allwinner,sun6i-a31-usb-phy";
 			reg = <0x01c19400 0x10>,
-- 
2.4.2
