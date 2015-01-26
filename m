From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 26 Jan 2015 09:56:10 +0200
Subject: [PATCH v4 1/2] clocksource: devicetree: document Conexant Digicolor
 timer binding
In-Reply-To: <cover.1422256855.git.baruch@tkos.co.il>
References: <cover.1422256855.git.baruch@tkos.co.il>
Message-ID: <c7f10f49db45099a393dc62db556c8de9ff63923.1422256855.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Conexant CX92755 SoC provides 8 32-bit timers as part of its so called
"Agent Communication" block. Timers can be configures either as free running or
one shot. Each timer has a dedicated interrupt source in the CX92755 interrupts
controller. The first timer (Timer A) can also be configured as watchdog.

This commit adds devicetree binding definition of this hardware module. The
binding defined here should be reusable for other SoCs in the Digicolor series.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 .../devicetree/bindings/timer/digicolor-timer.txt      | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/digicolor-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/digicolor-timer.txt b/Documentation/devicetree/bindings/timer/digicolor-timer.txt
new file mode 100644
index 000000000000..d1b659bbc29f
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/digicolor-timer.txt
@@ -0,0 +1,18 @@
+Conexant Digicolor SoCs Timer Controller
+
+Required properties:
+
+- compatible : should be "cnxt,cx92755-timer"
+- reg : Specifies base physical address and size of the "Agent Communication"
+  timer registers
+- interrupts : Contains 8 interrupts, one for each timer
+- clocks: phandle to the main clock
+
+Example:
+
+	timer at f0000fc0 {
+		compatible = "cnxt,cx92755-timer";
+		reg = <0xf0000fc0 0x40>;
+		interrupts = <19>, <31>, <34>, <35>, <52>, <53>, <54>, <55>;
+		clocks = <&main_clk>;
+	};
-- 
2.1.4
