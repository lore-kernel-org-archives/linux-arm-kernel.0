From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  3 Mar 2016 12:39:58 +0100
Subject: [PATCH 05/17] dt-bindings: Add PLX Technology RPS Timer bindings
In-Reply-To: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
References: <1457005210-18485-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1457005210-18485-6-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/timer/plxtech,rps-timer.txt     | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/plxtech,rps-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/plxtech,rps-timer.txt b/Documentation/devicetree/bindings/timer/plxtech,rps-timer.txt
new file mode 100644
index 0000000..bc7cb33
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/plxtech,rps-timer.txt
@@ -0,0 +1,17 @@
+PLX Technology OXNAS SoCs Family RPS Timer
+==========================================
+
+Required properties:
+- compatible: Should be "plxtech,nas782x-rps-timer"
+- reg : Specifies base physical address and size of the registers.
+- interrupts : The interrupt of the first timer
+- clocks : The phandle of the timer clock source
+
+example:
+
+timer0: timer at 200 {
+	compatible = "plxtech,nas782x-rps-timer";
+	reg = <0x200 0x40>;
+	clocks = <&rpsclk>;
+	interrupts = <4 5>;
+};
-- 
1.9.1
