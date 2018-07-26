From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 26 Jul 2018 12:15:25 +0200
Subject: [PATCH 2/7] clocksource/drivers/timer-mediatek: Add system timer
 bindings
In-Reply-To: <1532600131-28168-1-git-send-email-daniel.lezcano@linaro.org>
References: <014f94f9-54d4-1ee0-aa89-67ca5d221989@free.fr>
 <1532600131-28168-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1532600131-28168-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stanley Chu <stanley.chu@mediatek.com>

This patch adds bindings of new "System Timer" on Mediatek SoCs.

Remove RTC clock in the same time because it is not used by
both "General Purpose Timer" and "System Timer" now.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../bindings/timer/mediatek,mtk-timer.txt          | 34 +++++++++++++---------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
index b1fe7e9..18d4d01 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -1,19 +1,25 @@
-Mediatek MT6577, MT6572 and MT6589 Timers
----------------------------------------
+Mediatek Timers
+---------------
+
+Mediatek SoCs have two different timers on different platforms,
+- GPT (General Purpose Timer)
+- SYST (System Timer)
+
+The proper timer will be selected automatically by driver.
 
 Required properties:
 - compatible should contain:
-	* "mediatek,mt2701-timer" for MT2701 compatible timers
-	* "mediatek,mt6580-timer" for MT6580 compatible timers
-	* "mediatek,mt6589-timer" for MT6589 compatible timers
-	* "mediatek,mt7623-timer" for MT7623 compatible timers
-	* "mediatek,mt8127-timer" for MT8127 compatible timers
-	* "mediatek,mt8135-timer" for MT8135 compatible timers
-	* "mediatek,mt8173-timer" for MT8173 compatible timers
-	* "mediatek,mt6577-timer" for MT6577 and all above compatible timers
-- reg: Should contain location and length for timers register.
-- clocks: Clocks driving the timer hardware. This list should include two
-	clocks. The order is system clock and as second clock the RTC clock.
+	* "mediatek,mt2701-timer" for MT2701 compatible timers (GPT)
+	* "mediatek,mt6580-timer" for MT6580 compatible timers (GPT)
+	* "mediatek,mt6589-timer" for MT6589 compatible timers (GPT)
+	* "mediatek,mt7623-timer" for MT7623 compatible timers (GPT)
+	* "mediatek,mt8127-timer" for MT8127 compatible timers (GPT)
+	* "mediatek,mt8135-timer" for MT8135 compatible timers (GPT)
+	* "mediatek,mt8173-timer" for MT8173 compatible timers (GPT)
+	* "mediatek,mt6577-timer" for MT6577 and all above compatible timers (GPT)
+	* "mediatek,mt6765-timer" for MT6765 compatible timers (SYST)
+- reg: Should contain location and length for timer register.
+- clocks: Should contain system clock.
 
 Examples:
 
@@ -21,5 +27,5 @@ Examples:
 		compatible = "mediatek,mt6577-timer";
 		reg = <0x10008000 0x80>;
 		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&system_clk>, <&rtc_clk>;
+		clocks = <&system_clk>;
 	};
-- 
2.7.4
