From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun, 18 Sep 2016 16:13:11 +0200
Subject: [PATCH] ARM: tegra: nyan: Enable GPU node and related supply
Message-ID: <20160918141311.17140-1-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables the GPU node for tegra124 nyan boards, which is required to
get graphics acceleration with nouveau on these devices.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/tegra124-nyan.dtsi | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-nyan.dtsi b/arch/arm/boot/dts/tegra124-nyan.dtsi
index dab9509..225ca77 100644
--- a/arch/arm/boot/dts/tegra124-nyan.dtsi
+++ b/arch/arm/boot/dts/tegra124-nyan.dtsi
@@ -42,6 +42,12 @@
 		};
 	};
 
+	gpu at 0,57000000 {
+		status = "okay";
+
+		vdd-supply = <&vdd_gpu>;
+	};
+
 	serial at 70006000 {
 		/* Debug connector on the bottom of the board near SD card. */
 		status = "okay";
@@ -214,7 +220,7 @@
 					regulator-always-on;
 				};
 
-				sd6 {
+				vdd_gpu: sd6 {
 					regulator-name = "+VDD_GPU_AP";
 					regulator-min-microvolt = <650000>;
 					regulator-max-microvolt = <1200000>;
-- 
2.9.3
