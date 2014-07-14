From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 14 Jul 2014 17:54:19 +0200
Subject: [PATCH v2 2/6] clk: dts: document pxa clock binding
In-Reply-To: <1405353263-13424-1-git-send-email-robert.jarzmik@free.fr>
References: <1405353263-13424-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1405353263-13424-3-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the device-tree binding of Marvell PXA based SoCs.
PXA clocks are mostly fixed rate and fixed ratio clocks derived from an
external oscillator, and gated by a register set (CKEN or CKEN*).

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 Documentation/devicetree/bindings/clock/pxa-clock.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/pxa-clock.txt

diff --git a/Documentation/devicetree/bindings/clock/pxa-clock.txt b/Documentation/devicetree/bindings/clock/pxa-clock.txt
new file mode 100644
index 0000000..4b4a902
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/pxa-clock.txt
@@ -0,0 +1,16 @@
+* Clock bindings for Marvell PXA chips
+
+Required properties:
+- compatible: Should be "marvell,pxa-clocks"
+- #clock-cells: Should be <1>
+
+The clock consumer should specify the desired clock by having the clock
+ID in its "clocks" phandle cell (see include/.../pxa-clock.h).
+
+Examples:
+
+pxa2xx_clks: pxa2xx_clks at 41300004 {
+        compatible = "marvell,pxa-clocks";
+        #clock-cells = <1>;
+        status = "okay";
+};
-- 
2.0.0.rc2
