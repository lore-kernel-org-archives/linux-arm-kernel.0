From: andre.przywara@arm.com (Andre Przywara)
Date: Fri,  6 Jul 2018 09:52:01 +0100
Subject: [PATCH 01/10] arm64: dts: allwinner: a64: Add L2 cache nodes
In-Reply-To: <20180706085210.17952-1-andre.przywara@arm.com>
References: <20180706085210.17952-1-andre.przywara@arm.com>
Message-ID: <20180706085210.17952-2-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current kernels complain when booting on an A64 Soc:
....
[    1.904297] cacheinfo: Unable to detect cache hierarchy for CPU 0
....
Not a real biggie on this flat topology, but also easy enough to fix.

Add the L2 cache node and let each CPU point to it.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 840753432ea5..53af7e7ab62c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -88,6 +88,7 @@
 			device_type = "cpu";
 			reg = <0>;
 			enable-method = "psci";
+			next-level-cache = <&L2>;
 		};
 
 		cpu1: cpu at 1 {
@@ -95,6 +96,7 @@
 			device_type = "cpu";
 			reg = <1>;
 			enable-method = "psci";
+			next-level-cache = <&L2>;
 		};
 
 		cpu2: cpu at 2 {
@@ -102,6 +104,7 @@
 			device_type = "cpu";
 			reg = <2>;
 			enable-method = "psci";
+			next-level-cache = <&L2>;
 		};
 
 		cpu3: cpu at 3 {
@@ -109,6 +112,12 @@
 			device_type = "cpu";
 			reg = <3>;
 			enable-method = "psci";
+			next-level-cache = <&L2>;
+		};
+
+                L2: l2-cache {
+			compatible = "cache";
+			cache-level = <2>;
 		};
 	};
 
-- 
2.14.4
