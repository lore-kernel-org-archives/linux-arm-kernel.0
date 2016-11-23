From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Wed, 23 Nov 2016 17:20:40 +0100
Subject: [PATCH 2/2] ARM64: dts: meson-gxm: add SCPI configuration for GXM
In-Reply-To: <20161123162040.24843-1-martin.blumenstingl@googlemail.com>
References: <20161123162040.24843-1-martin.blumenstingl@googlemail.com>
Message-ID: <20161123162040.24843-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the SCPI DVFS clock index and configures the CPU cores
accordingly.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
index c1974bb..2b1d276e 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
@@ -85,6 +85,7 @@
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			clocks = <&scpi_dvfs 1>;
 		};
 
 		cpu5: cpu at 101 {
@@ -93,6 +94,7 @@
 			reg = <0x0 0x101>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			clocks = <&scpi_dvfs 1>;
 		};
 
 		cpu6: cpu at 102 {
@@ -101,6 +103,7 @@
 			reg = <0x0 0x102>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			clocks = <&scpi_dvfs 1>;
 		};
 
 		cpu7: cpu at 103 {
@@ -109,6 +112,12 @@
 			reg = <0x0 0x103>;
 			enable-method = "psci";
 			next-level-cache = <&l2>;
+			clocks = <&scpi_dvfs 1>;
 		};
 	};
 };
+
+&scpi_dvfs {
+	clock-indices = <0 1>;
+	clock-output-names = "vbig", "vlittle";
+};
-- 
2.10.2
