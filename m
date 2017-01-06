From: ahaslam@baylibre.com (Axel Haslam)
Date: Fri,  6 Jan 2017 10:40:53 +0100
Subject: [PATCH v2 1/2] ARM: dts: da850: Add usb device node
In-Reply-To: <20170106094054.27767-1-ahaslam@baylibre.com>
References: <20170106094054.27767-1-ahaslam@baylibre.com>
Message-ID: <20170106094054.27767-2-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the usb1 device node for the da850 soc.
This will allow boards to use the usb1 port
when booting through DT.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/boot/dts/da850.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 6205917..9f8ac8f 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -419,6 +419,14 @@
 					>;
 			status = "disabled";
 		};
+		usb1: usb at 225000 {
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
2.9.3
