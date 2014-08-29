From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri, 29 Aug 2014 07:38:37 -0700
Subject: [PATCH v2] ARM: zynq: DT: Add LEDs to zc702 DT
Message-ID: <1409323117-21711-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ezra Savard <ezra.savard@xilinx.com>

Adds LEDs to the zc702 devicetree for use with the leds-gpio driver.

Signed-off-by: Ezra Savard <ezra.savard@xilinx.com>
Reviewed-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
v2:
 - fix node names
---
 arch/arm/boot/dts/zynq-zc702.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index 835c3089c61c..b29e0f97e764 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -27,6 +27,15 @@
 		bootargs = "console=ttyPS0,115200 earlyprintk";
 	};
 
+	leds {
+		compatible = "gpio-leds";
+
+		ds23 {
+			label = "ds23";
+			gpios = <&gpio0 10 0>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
 };
 
 &can0 {
-- 
2.1.0.1.g27b9230
