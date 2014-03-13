From: denis@eukrea.com (Denis Carikli)
Date: Thu, 13 Mar 2014 10:18:44 +0100
Subject: [PATCH v4][ 6/8] ARM: dts: i.MX35: Add USB support.
In-Reply-To: <1394702326-25558-1-git-send-email-denis@eukrea.com>
References: <1394702326-25558-1-git-send-email-denis@eukrea.com>
Message-ID: <1394702326-25558-6-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
Changelog v3->v4:
- Moved the compatible of usbphy on top to match the other nodes.
- the usb phy's names were renamed from usbphy to usb-phy.
- The patch renaming the fsl,usbphy property in usb-phy was removed.
  So this patch was adapted to that.

Changelog v2->v3:
- rebased on top of the "usb: chipidea: Use standard usb-phy property." patch.
- Fixed the usbphy nodes index and added and added a reg property.

Changelog v1->v2:
- The usbphy nodes were made to look like the ones in imx53.dtsi
- The patch was rebased on top of the clock fixes commits.
---
 arch/arm/boot/dts/imx35.dtsi |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index 474a73d..4759abb 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -298,6 +298,7 @@
 				interrupts = <37>;
 				clocks = <&clks 73>;
 				fsl,usbmisc = <&usbmisc 0>;
+				fsl,usbphy = <&usbphy0>;
 				status = "disabled";
 			};
 
@@ -307,6 +308,7 @@
 				interrupts = <35>;
 				clocks = <&clks 73>;
 				fsl,usbmisc = <&usbmisc 1>;
+				fsl,usbphy = <&usbphy1>;
 				status = "disabled";
 			};
 
@@ -355,4 +357,20 @@
 			};
 		};
 	};
+
+	usbphy {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usbphy0: usb-phy at 0 {
+			reg = <0>;
+			compatible = "usb-nop-xceiv";
+		};
+
+		usbphy1: usb-phy at 1 {
+			reg = <1>;
+			compatible = "usb-nop-xceiv";
+		};
+	};
 };
-- 
1.7.9.5
