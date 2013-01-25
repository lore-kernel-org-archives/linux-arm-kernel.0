From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 25 Jan 2013 08:48:33 +0530
Subject: [PATCH 4/6] ARM: dts: omap5: add dwc3 omap dt data
In-Reply-To: <1359083915-8690-1-git-send-email-kishon@ti.com>
References: <1359083915-8690-1-git-send-email-kishon@ti.com>
Message-ID: <1359083915-8690-5-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dwc3 omap glue data to the omap5 dt data file. The information about
the dt node added here is available @
Documentation/devicetree/bindings/usb/omap-usb.txt

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 5f59bf2..1703a72 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -513,6 +513,17 @@
 			ti,type = <2>;
 		};
 
+		omap_dwc3 at 4a020000 {
+			compatible = "ti,dwc3";
+			ti,hwmods = "usb_otg_ss";
+			reg = <0x4a020000 0x1ff>;
+			interrupts = <0 93 4>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			utmi-mode = <2>;
+			ranges;
+		};
+
 		ocp2scp {
 			compatible = "ti,omap-ocp2scp";
 			#address-cells = <1>;
-- 
1.7.9.5
