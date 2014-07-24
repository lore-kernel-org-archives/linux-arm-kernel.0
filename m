From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Thu, 24 Jul 2014 13:51:02 +0200
Subject: [PATCH v2 5/6] ARM: at91: change compatibility string for sama5d3x gem
In-Reply-To: <cover.1406192657.git.cyrille.pitchen@atmel.com>
References: <cover.1406192657.git.cyrille.pitchen@atmel.com>
Message-ID: <b8cbfb4e8d5d156d477634164c21cfa6f509c4ea.1406192657.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this new compatibility string prevents macb/gem driver from using the
scatter-gather and gso features on sama5d3x boards.

Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>
---
 arch/arm/boot/dts/sama5d3_gmac.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sama5d3_gmac.dtsi b/arch/arm/boot/dts/sama5d3_gmac.dtsi
index a6cb050..de5ed59 100644
--- a/arch/arm/boot/dts/sama5d3_gmac.dtsi
+++ b/arch/arm/boot/dts/sama5d3_gmac.dtsi
@@ -74,7 +74,7 @@
 			};
 
 			macb0: ethernet at f0028000 {
-				compatible = "cdns,pc302-gem", "cdns,gem";
+				compatible = "atmel,sama5d3-gem";
 				reg = <0xf0028000 0x100>;
 				interrupts = <34 IRQ_TYPE_LEVEL_HIGH 3>;
 				pinctrl-names = "default";
-- 
1.8.2.2
