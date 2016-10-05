From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  5 Oct 2016 15:53:50 +0200
Subject: [PATCH] ARM64: dts: meson-gx: Add missing L2 cache node
Message-ID: <1475675630-31514-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to remove the boot warning :
[    2.290933] Unable to detect cache hierarchy from DT for CPU 0
And add missing L2 cache hierarchy information, add a simple l2 cache node
and reference it from the A53 cpu nodes.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 0737056..a6cd953 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -64,6 +64,7 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			next-level-cache = <&l2>;
 		};
 
 		cpu1: cpu at 1 {
@@ -71,6 +72,7 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			next-level-cache = <&l2>;
 		};
 
 		cpu2: cpu at 2 {
@@ -78,6 +80,7 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
+			next-level-cache = <&l2>;
 		};
 
 		cpu3: cpu at 3 {
@@ -85,6 +88,11 @@
 			compatible = "arm,cortex-a53", "arm,armv8";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		l2: l2-cache0 {
+			compatible = "cache";
 		};
 	};
 
-- 
1.9.1
