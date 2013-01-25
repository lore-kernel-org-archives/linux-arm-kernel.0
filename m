From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 25 Jan 2013 08:48:34 +0530
Subject: [PATCH 5/6] ARM: dts: omap5: add dwc3 core dt data
In-Reply-To: <1359083915-8690-1-git-send-email-kishon@ti.com>
References: <1359083915-8690-1-git-send-email-kishon@ti.com>
Message-ID: <1359083915-8690-6-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dwc3 core dt data as a subnode to dwc3 omap glue data in omap5 dt
data file. The information for the entered data node is available @
Documentation/devicetree/bindings/usb/dwc3.txt

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 1703a72..58118c4 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -522,6 +522,13 @@
 			#size-cells = <1>;
 			utmi-mode = <2>;
 			ranges;
+			dwc3 at 4a030000 {
+				compatible = "synopsys,dwc3";
+				reg = <0x4a030000 0xcfff>;
+				interrupts = <0 92 4>;
+				usb_phy = <&usb2_phy>, <&usb3_phy>;
+				tx-fifo-resize;
+			};
 		};
 
 		ocp2scp {
-- 
1.7.9.5
