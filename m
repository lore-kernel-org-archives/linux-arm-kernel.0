From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu, 28 Aug 2014 09:22:53 -0700
Subject: [PATCH] ARM: zynq: DT: Add LEDs to zc702 DT
Message-ID: <1409242973-2735-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ezra Savard <ezra.savard@xilinx.com>

Adds LEDs to the zc702 devicetree for use with the leds-gpio driver.

Signed-off-by: Ezra Savard <ezra.savard@xilinx.com>
Reviewed-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/boot/dts/zynq-zc702.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index 835c3089c61c..4e9fe26b3e85 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -27,6 +27,16 @@
 		bootargs = "console=ttyPS0,115200 earlyprintk";
 	};
 
+	gpio-leds {
+		compatible = "gpio-leds";
+
+		led-ds23 {
+			label = "ds23";
+			gpios = <&gpio0 10 0>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
 };
 
 &can0 {
-- 
2.1.0.1.g27b9230
