From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Thu, 7 Mar 2013 19:05:17 +0530
Subject: [PATCH v3 4/7] ARM: dts: omap5: Add omap control usb data
In-Reply-To: <1362663320-23799-1-git-send-email-kishon@ti.com>
References: <1362663320-23799-1-git-send-email-kishon@ti.com>
Message-ID: <1362663320-23799-5-git-send-email-kishon@ti.com>
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
index 790bb2a..c937500 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -496,5 +496,13 @@
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
1.7.10.4
