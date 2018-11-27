From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 27 Nov 2018 13:45:37 +0100
Subject: [PATCH 36/77] ARM: dts: sun7i: Remove SoC node unit-name to avoid
 warnings
In-Reply-To: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
References: <cover.9a6e7d31e872acad71b4bc7f9edfc24ab01c22c3.1543321707.git-series.maxime.ripard@bootlin.com>
Message-ID: <4ed22cc15f873bc0708a8eab076f080ee3280ad4.1543321707.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our main node for all the in-SoC controllers used to have a unit name. The
unit-name, in addition to being actually false, would not match any reg
property, which generates a warning.

Remove it in order to remove those warnings.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 3ed0575ed301..2a88ff58fee4 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -258,7 +258,7 @@
 		status = "disabled";
 	};
 
-	soc at 1c00000 {
+	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
git-series 0.9.1
