From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 18 Dec 2017 12:35:46 +0100
Subject: [PATCH] ARM64: meson-axg: enable hardware rng
Message-ID: <20171218113546.13116-1-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the hardware random generator

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Hi Kevin,

This patch depends on the changes adding the ethernet controller [0],
for including the axg clock binding header.

Cheers
Jerome

[0]: https://lkml.kernel.org/r/20171216035527.96952-2-yixun.lan at amlogic.com


 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index dea1bc31b4de..c741fc16486f 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -212,6 +212,13 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xff634000 0x0 0x2000>;
 
+			hwrng: rng {
+				compatible = "amlogic,meson-rng";
+				reg = <0x0 0x18 0x0 0x4>;
+				clocks = <&clkc CLKID_RNG0>;
+				clock-names = "core";
+			};
+
 			pinctrl_periphs: pinctrl at 480 {
 				compatible = "amlogic,meson-axg-periphs-pinctrl";
 				#address-cells = <2>;
-- 
2.14.3
