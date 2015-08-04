From: scott.shu@mediatek.com (Scott Shu)
Date: Tue, 4 Aug 2015 10:47:37 +0800
Subject: [PATCH] ARM64: dts: mt6795: enable basic SMP bringup for MT6795
Message-ID: <1438656457-60278-1-git-send-email-scott.shu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support SMP on MediaTek MT6795 Cortex-A53 Octa-core SoC.

The patch is based on v4.2-rc1 and following patch series:
(1) Mars Cheng's "Add mt6795 basic chip support" [1]

[1] https://lkml.org/lkml/2015/7/14/63

Signed-off-by: Scott Shu <scott.shu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt6795.dtsi |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt6795.dtsi b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
index da200e7..c85659d 100644
--- a/arch/arm64/boot/dts/mediatek/mt6795.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6795.dtsi
@@ -20,6 +20,11 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -27,48 +32,56 @@
 		cpu0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
+			enable-method = "psci";
 			reg = <0x000>;
 		};
 
 		cpu1: cpu at 1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
+			enable-method = "psci";
 			reg = <0x001>;
 		};
 
 		cpu2: cpu at 2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
+			enable-method = "psci";
 			reg = <0x002>;
 		};
 
 		cpu3: cpu at 3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
+			enable-method = "psci";
 			reg = <0x003>;
 		};
 
 		cpu4: cpu at 100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
+			enable-method = "psci";
 			reg = <0x100>;
 		};
 
 		cpu5: cpu at 101 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
+			enable-method = "psci";
 			reg = <0x101>;
 		};
 
 		cpu6: cpu at 102 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
+			enable-method = "psci";
 			reg = <0x102>;
 		};
 
 		cpu7: cpu at 103 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
+			enable-method = "psci";
 			reg = <0x103>;
 		};
 	};
-- 
1.7.9.5
