From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 20 Mar 2015 20:11:17 +0100
Subject: [PATCH v2 08/13] ARM: dts: sun5i: Add USB Dual Role Controller
In-Reply-To: <1426878682-14521-1-git-send-email-hdegoede@redhat.com>
References: <1426878682-14521-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1426878682-14521-9-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node for the otg/drc usb controller to sun5i-a1*.dtsi.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
index c3e11ec..eb5bce5 100644
--- a/arch/arm/boot/dts/sun5i.dtsi
+++ b/arch/arm/boot/dts/sun5i.dtsi
@@ -425,6 +425,17 @@
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
+			status = "disabled";
+		};
+
 		usbphy: phy at 01c13400 {
 			#phy-cells = <1>;
 			compatible = "allwinner,sun5i-a13-usb-phy";
-- 
2.3.3
