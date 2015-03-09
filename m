From: hdegoede@redhat.com (Hans de Goede)
Date: Mon,  9 Mar 2015 21:40:24 +0100
Subject: [PATCH 11/15] ARM: dts: sun7i: Add USB Dual Role Controller
In-Reply-To: <1425933628-9672-1-git-send-email-hdegoede@redhat.com>
References: <1425933628-9672-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1425933628-9672-12-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roman Byshko <rbyshko@gmail.com>

Add a node for the otg/drc usb controller to sun7i-a20.dtsi

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index fb56a1d..1d0b9ac 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -653,6 +653,18 @@
 			status = "disabled";
 		};
 
+		usb_otg: usb at 01c13000 {
+			compatible = "allwinner,sun4i-a10-musb";
+			reg = <0x01c13000 0x0400>;
+			clocks = <&ahb_gates 0>;
+			interrupts = <0 38 4>;
+			interrupt-names = "mc";
+			phys = <&usbphy 0>;
+			phy-names = "usb";
+			syscons = <&syscon>;
+			status = "disabled";
+		};
+
 		usbphy: phy at 01c13400 {
 			#phy-cells = <1>;
 			compatible = "allwinner,sun7i-a20-usb-phy";
-- 
2.3.1
