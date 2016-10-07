From: ahaslam@baylibre.com (ahaslam at baylibre.com)
Date: Fri,  7 Oct 2016 18:42:56 +0200
Subject: [PATCH/RFT 11/12] ARM: dts: da850: Add the usb ohci device node
In-Reply-To: <1475858577-10366-1-git-send-email-ahaslam@baylibre.com>
References: <1475858577-10366-1-git-send-email-ahaslam@baylibre.com>
Message-ID: <1475858577-10366-12-git-send-email-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Haslam <ahaslam@baylibre.com>

This adds the device tree node for the usb11 (ohci)
controller present in the da850 family of SoC's.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 33fcdce..afae565 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -381,6 +381,14 @@
 			#phy-cells = <1>;
 			status = "disabled";
 		};
+		usb11: usb11 at 0225000 {
+			compatible = "ti,da830-ohci";
+			reg = <0x225000 0x1000>;
+			interrupts = <59>;
+			phys = <&usb_phy 1>;
+			phy-names = "usb-phy";
+			status = "disabled";
+		};
 		gpio: gpio at 226000 {
 			compatible = "ti,dm6441-gpio";
 			gpio-controller;
-- 
2.7.1
