From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue,  4 Jul 2017 13:59:25 +0200
Subject: [PATCH v2 7/9] ASoC: atmel-classd: remove aclk clock from DT binding
In-Reply-To: <20170704115927.32662-1-quentin.schulz@free-electrons.com>
References: <20170704115927.32662-1-quentin.schulz@free-electrons.com>
Message-ID: <20170704115927.32662-8-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since gclk (generated-clk) is now able to determine the rate of the
audio_pll, there is no need for classd to have a direct phandle to the
audio_pll while already having a phandle to gclk.

This binding is used by no board in mainline so it is safe to be
modified.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

added in v2

 Documentation/devicetree/bindings/sound/atmel-classd.txt | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/atmel-classd.txt b/Documentation/devicetree/bindings/sound/atmel-classd.txt
index 549e701cb7a1..898551076382 100644
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
2.11.0
