From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 20 Apr 2015 15:13:44 +0200
Subject: [PATCH 1/5] ARM: ux500: define CPU topology
Message-ID: <1429535624-9225-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CPU topology is unspecified for Ux500 but will be needed
for things like CoreSight. Let's just add it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index bfd3f1c734b8..bd6bd0926931 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -22,6 +22,32 @@
 		interrupt-parent = <&intc>;
 		ranges;
 
+		cpus {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			cpu-map {
+				cluster0 {
+					core0 {
+						cpu = <&CPU0>;
+					};
+					core1 {
+						cpu = <&CPU1>;
+					};
+				};
+			};
+			CPU0: cpu at 0 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a9";
+				reg = <0>;
+			};
+			CPU1: cpu at 1 {
+				device_type = "cpu";
+				compatible = "arm,cortex-a9";
+				reg = <1>;
+			};
+		};
+
 		intc: interrupt-controller at a0411000 {
 			compatible = "arm,cortex-a9-gic";
 			#interrupt-cells = <3>;
-- 
1.9.3
