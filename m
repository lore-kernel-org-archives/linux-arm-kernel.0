From: ahaslam@baylibre.com (Axel Haslam)
Date: Mon, 21 Nov 2016 17:59:19 +0100
Subject: [PATCH 1/2] ARM: dts: da850: Add usb device node
In-Reply-To: <20161121165920.29809-1-ahaslam@baylibre.com>
References: <20161121165920.29809-1-ahaslam@baylibre.com>
Message-ID: <20161121165920.29809-2-ahaslam@baylibre.com>
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
index 1bb1f6d..fbd50d6 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -406,6 +406,14 @@
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
