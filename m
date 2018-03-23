From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 23 Mar 2018 22:38:16 +0800
Subject: [PATCH v2 7/7] ARM64: dts: meson-axg: add an 32K alt aoclk
In-Reply-To: <20180323143816.200573-1-yixun.lan@amlogic.com>
References: <20180323143816.200573-1-yixun.lan@amlogic.com>
Message-ID: <20180323143816.200573-8-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ao_clk81 in AO domain have two clock source,
one from a 32K alt crystal we name it as ao_alt_clk,
another is the clk81 signal from EE domain.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index b3d394f5d95a..48584d5a329b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -109,6 +109,13 @@
 		#clock-cells = <0>;
 	};
 
+	ao_alt_xtal: ao_alt_xtal-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <32000000>;
+		clock-output-names = "ao_alt_xtal";
+		#clock-cells = <0>;
+	};
+
 	soc {
 		compatible = "simple-bus";
 		#address-cells = <2>;
-- 
2.15.1
