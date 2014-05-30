From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 30 May 2014 18:56:00 +0200
Subject: [PATCH v6 2/6] dt-bindings: add mtk-timer bindings
In-Reply-To: <1401468964-5307-1-git-send-email-matthias.bgg@gmail.com>
References: <1401468964-5307-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <1401468964-5307-3-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding documentation for the General Porpose Timer driver of
the Mediatek SoCs.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 .../bindings/timer/mediatek,mtk-timer.txt          |   18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
new file mode 100644
index 0000000..0558ddd0
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -0,0 +1,18 @@
+Mediatek MT6577, MT6572 and MT6589 Timers
+---------------------------------------
+
+Required properties:
+- compatible: Should be "mediatek,mt6577-timer"
+- reg: Should contain location and length for timers register.
+- clocks: Clocks driving the timer hardware. This list shoud include two
+	clocks. The order is system clock and as second clock the RTC clock.
+
+Examples:
+
+	timer at 10008000 {
+		compatible = "mediatek,mt6577-timer";
+		reg = <0x10008000 0x80>;
+		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&system_clk>, <&rtc_clk>;
+		clock-names = "system-clk", "rtc-clk";
+	};
-- 
1.7.9.5
