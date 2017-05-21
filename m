From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 21 May 2017 18:44:37 +0200
Subject: [PATCH 2/4] ARM: dts: bcm283x: Add generic USB PHY
In-Reply-To: <1495385079-3697-1-git-send-email-stefan.wahren@i2se.com>
References: <1495385079-3697-1-git-send-email-stefan.wahren@i2se.com>
Message-ID: <1495385079-3697-3-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to use dwc2 in OTG or gadget mode the USB PHY should be
specified. Since there is no bcm283x USB PHY driver use the generic
one.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/bcm283x.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
index 86a5db5..9a05cde 100644
--- a/arch/arm/boot/dts/bcm283x.dtsi
+++ b/arch/arm/boot/dts/bcm283x.dtsi
@@ -589,6 +589,8 @@
 			#size-cells = <0>;
 			clocks = <&clk_usb>;
 			clock-names = "otg";
+			phys = <&usbphy>;
+			phy-names = "usb2-phy";
 		};
 
 		v3d: v3d at 7ec00000 {
@@ -624,4 +626,8 @@
 			clock-frequency = <480000000>;
 		};
 	};
+
+	usbphy: phy {
+		compatible = "usb-nop-xceiv";
+	};
 };
-- 
2.7.4
