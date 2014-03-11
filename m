From: denis@eukrea.com (Denis Carikli)
Date: Tue, 11 Mar 2014 11:55:02 +0100
Subject: [PATCH v2][ 6/8] ARM: dts: i.MX35: Add USB support.
In-Reply-To: <1394535304-10240-1-git-send-email-denis@eukrea.com>
References: <1394535304-10240-1-git-send-email-denis@eukrea.com>
Message-ID: <1394535304-10240-6-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
Changelog v1->v2:
- The usbphy nodes were made to look like the ones in imx53.dtsi
- The patch was rebased on top of the clock fixes commits.

---
 arch/arm/boot/dts/imx35.dtsi |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index 474a73d..b943123 100644
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
 
@@ -355,4 +357,18 @@
 			};
 		};
 	};
+
+	usbphy {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		compatible = "simple-bus";
+
+		usbphy0: usbphy at 0 {
+			compatible = "usb-nop-xceiv";
+		};
+
+		usbphy1: usbphy at 1 {
+			compatible = "usb-nop-xceiv";
+		};
+	};
 };
-- 
1.7.9.5
