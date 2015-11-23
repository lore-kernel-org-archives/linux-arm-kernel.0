From: songjun.wu@atmel.com (Songjun Wu)
Date: Mon, 23 Nov 2015 17:19:58 +0800
Subject: [PATCH] ASoC: Atmel: ClassD: add GCK's parent clock in DT binding
Message-ID: <1448270399-28728-1-git-send-email-songjun.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set GCK's parent as audio clock.

Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
---

 .../devicetree/bindings/sound/atmel-classd.txt     |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/atmel-classd.txt b/Documentation/devicetree/bindings/sound/atmel-classd.txt
index 0018451..549e701 100644
--- a/Documentation/devicetree/bindings/sound/atmel-classd.txt
+++ b/Documentation/devicetree/bindings/sound/atmel-classd.txt
@@ -16,6 +16,10 @@ Required properties:
 	Required elements: "pclk", "gclk" and "aclk".
 - clocks
 	Please refer to clock-bindings.txt.
+- assigned-clocks
+	Should be <&classd_gclk>.
+- assigned-clock-parents
+	Should be <&audio_pll_pmc>.
 
 Optional properties:
 - pinctrl-names, pinctrl-0
@@ -43,6 +47,8 @@ classd: classd at fc048000 {
 		dma-names = "tx";
 		clocks = <&classd_clk>, <&classd_gclk>, <&audio_pll_pmc>;
 		clock-names = "pclk", "gclk", "aclk";
+		assigned-clocks = <&classd_gclk>;
+		assigned-clock-parents = <&audio_pll_pmc>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_classd_default>;
-- 
1.7.9.5
