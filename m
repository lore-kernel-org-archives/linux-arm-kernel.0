From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 25 Jan 2013 08:48:30 +0530
Subject: [PATCH 1/6] ARM: dts: omap5: Add omap control usb data
In-Reply-To: <1359083915-8690-1-git-send-email-kishon@ti.com>
References: <1359083915-8690-1-git-send-email-kishon@ti.com>
Message-ID: <1359083915-8690-2-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add omap control usb data in omap5 device tree file. This will have the
register address of registers to power on the USB2 PHY and USB3 PHY. The
information for the node added here is available in
Documentation/devicetree/bindings/usb/omap-usb.txt

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 7a78d1b..edc7464 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -504,5 +504,13 @@
 			hw-caps-ll-interface;
 			hw-caps-temp-alert;
 		};
+
+		omap_control_usb: omap-control-usb at 4a002300 {
+			compatible = "ti,omap-control-usb";
+			reg = <0x4a002300 0x4>,
+			      <0x4a002370 0x4>;
+			reg-names = "control_dev_conf", "phy_power_usb";
+			ti,type = <2>;
+		};
 	};
 };
-- 
1.7.9.5
