From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 25 Jul 2017 09:37:08 +0200
Subject: [PATCH v4 7/9] ASoC: atmel-classd: remove aclk clock from DT binding
In-Reply-To: <cover.c8ce78c15296190b2aa5c452c0c4512528e28518.1500968090.git-series.quentin.schulz@free-electrons.com>
References: <cover.c8ce78c15296190b2aa5c452c0c4512528e28518.1500968090.git-series.quentin.schulz@free-electrons.com>
Message-ID: <db5404c2be1d59603dd3770c5f95a065fe4c321f.1500968090.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since gclk (generated-clk) is now able to determine the rate of the
audio_pll, there is no need for classd to have a direct phandle to the
audio_pll while already having a phandle to gclk.

This binding is used by no board in mainline so it is safe to be
modified.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/atmel-classd.txt |  9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/atmel-classd.txt b/Documentation/devicetree/bindings/sound/atmel-classd.txt
index 549e701..8985510 100644
--- a/Documentation/devicetree/bindings/sound/atmel-classd.txt
+++ b/Documentation/devicetree/bindings/sound/atmel-classd.txt
@@ -13,13 +13,11 @@ Required properties:
 	Must be "tx".
 - clock-names
 	Tuple listing input clock names.
-	Required elements: "pclk", "gclk" and "aclk".
+	Required elements: "pclk" and "gclk".
 - clocks
 	Please refer to clock-bindings.txt.
 - assigned-clocks
 	Should be <&classd_gclk>.
-- assigned-clock-parents
-	Should be <&audio_pll_pmc>.
 
 Optional properties:
 - pinctrl-names, pinctrl-0
@@ -45,10 +43,9 @@ classd: classd at fc048000 {
 			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
 			| AT91_XDMAC_DT_PERID(47))>;
 		dma-names = "tx";
-		clocks = <&classd_clk>, <&classd_gclk>, <&audio_pll_pmc>;
-		clock-names = "pclk", "gclk", "aclk";
+		clocks = <&classd_clk>, <&classd_gclk>;
+		clock-names = "pclk", "gclk";
 		assigned-clocks = <&classd_gclk>;
-		assigned-clock-parents = <&audio_pll_pmc>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_classd_default>;
-- 
git-series 0.9.1
