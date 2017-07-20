From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 20 Jul 2017 15:32:08 +0200
Subject: [PATCH] arm: zynq: Add adv7511 on i2c bus for zc70x
Message-ID: <c6907f2c425af0dafa849f64873c30f13fef639d.1500557521.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Christian Kohn <christian.kohn@xilinx.com>

Describe adv7511 on i2c bus.

Signed-off-by: Christian Kohn <christian.kohn@xilinx.com>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/boot/dts/zynq-zc702.dts | 15 +++++++++++++++
 arch/arm/boot/dts/zynq-zc706.dts | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index 0735909165fd..a096275d903d 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -132,6 +132,21 @@
 			};
 		};
 
+		i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			adv7511: hdmi-tx at 39 {
+				compatible = "adi,adv7511";
+				reg = <0x39>;
+				adi,input-depth = <8>;
+				adi,input-colorspace = "yuv422";
+				adi,input-clock = "1x";
+				adi,input-style = <3>;
+				adi,input-justification = "right";
+			};
+		};
+
 		i2c at 2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index 3f6e4cb958f6..689ec9d6f7b9 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -88,6 +88,21 @@
 			};
 		};
 
+		i2c at 1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+			adv7511: hdmi-tx at 39 {
+				compatible = "adi,adv7511";
+				reg = <0x39>;
+				adi,input-depth = <8>;
+				adi,input-colorspace = "yuv422";
+				adi,input-clock = "1x";
+				adi,input-style = <3>;
+				adi,input-justification = "evenly";
+			};
+		};
+
 		i2c at 2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
1.9.1
