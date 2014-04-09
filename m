From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed,  9 Apr 2014 21:45:34 +0200
Subject: [PATCH 2/4] dt-bindings: add mtk-timer bindings
In-Reply-To: <1397072736-10793-1-git-send-email-matthias.bgg@gmail.com>
References: <1397072736-10793-1-git-send-email-matthias.bgg@gmail.com>
Message-ID: <1397072736-10793-3-git-send-email-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add binding documentation for the General Porpose Timer driver of
the Mediatek SoCs.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 .../bindings/timer/mediatek,mtk-timer.txt          |   19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
new file mode 100644
index 0000000..db3c836
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -0,0 +1,19 @@
+Mediatek MT6598, MT6577 and MT6572 Timers
+---------------------------------------
+
+Required properties:
+- compatible: Should be "mediatek,mtk6589-timer"
+- reg: Should contain location and length for timers register.
+- clock-names : Must include the following entries:
+  "sysclk" (13 MHz system clock),
+  "rtcclk" (32 KHz RTC clock).
+
+Examples:
+
+	timer {
+		compatible = "mediatek,mtk6589-timer";
+		reg = <0x10008000 0x80>;
+		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&system_clk>, <&rtc-clk>;
+		clock-names = "sysclk", "rtcclk";
+	};
-- 
1.7.9.5
