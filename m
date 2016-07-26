From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Tue, 26 Jul 2016 18:53:31 +0000
Subject: [PATCH V2 RFC 4/6] ARM: dts: bcm283x: Add generic USB PHY
In-Reply-To: <1469559213-16160-1-git-send-email-stefan.wahren@i2se.com>
References: <1469559213-16160-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1469559213-16160-5-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to use DWC2 in otg or gadget mode the USB PHY must be
specified. Since there is no bcm283x USB PHY driver use the generic
one.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 arch/arm/boot/dts/bcm283x.dtsi |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 5472800..cb492ce 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -291,6 +291,8 @@
 			#size-cells = <0>;
 			clocks = <&clk_usb>;
 			clock-names = "otg";
+			phys = <&usbphy>;
+			phy-names = "usb2-phy";
 		};
 
 		v3d: v3d at 7ec00000 {
@@ -302,6 +304,10 @@
 		vc4: gpu {
 			compatible = "brcm,bcm2835-vc4";
 		};
+
+		usbphy: phy {
+			compatible = "usb-nop-xceiv";
+		};
 	};
 
 	clocks {
-- 
1.7.9.5
