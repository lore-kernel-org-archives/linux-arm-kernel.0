From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  5 Oct 2017 12:49:44 +0200
Subject: [PATCH 09/20] ARM: dts: sun4i: Remove SoC node unit-name to avoid
 warnings
In-Reply-To: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
References: <cover.f5f905a5434f2a540d6844d23369a04af9f5314c.1507198895.git-series.maxime.ripard@free-electrons.com>
Message-ID: <c9f2be09d1e5d69e728e246567b289a278a1cb54.1507198895.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Our main node for all the in-SoC controllers used to have a unit name. The
unit-name, in addition to being actually false, would not match any reg
property, which generates a warning.

Remove it in order to remove those warnings.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
index f64544f615ea..6ce4aafdfd92 100644
--- a/arch/arm/boot/dts/sun4i-a10.dtsi
+++ b/arch/arm/boot/dts/sun4i-a10.dtsi
@@ -180,7 +180,7 @@
 		};
 	};
 
-	soc at 1c00000 {
+	soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
git-series 0.9.1
