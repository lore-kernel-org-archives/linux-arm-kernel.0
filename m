From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 29 Jan 2015 15:09:11 +0100
Subject: [PATCH v6 3/8] ARM: dt: Binding documentation for imx25 touchscreen
 controller
In-Reply-To: <1422540556-14828-1-git-send-email-mpa@pengutronix.de>
References: <1422540556-14828-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1422540556-14828-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the touchscreen conversion queue binding documentation. It uses
the shared imx25 ADC.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

Notes:
    Changes in v5:
     - Fix signed/unsigned comparison
     - Fix unused variable settling_time by putting it in the correct argument list
     - Use continous conversion queue with the repeat feature and a proper
       repeat-wait. Previously the touchscreen caused massive number of interrupts.

 .../bindings/input/touchscreen/fsl-mx25-tcq.txt    | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt

diff --git a/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt b/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
new file mode 100644
index 000000000000..4214a99d197a
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/fsl-mx25-tcq.txt
@@ -0,0 +1,29 @@
+Freescale mx25 TS conversion queue module
+
+mx25 touchscreen conversion queue module which controls the ADC unit of the
+mx25 for attached touchscreens.
+
+Required properties:
+ - compatible: Should be "fsl,imx25-tcq".
+ - reg: Memory range of the device.
+ - interrupts: Should be the interrupt number associated with this module within
+   the tscadc unit (<0>).
+ - interrupt-parent: Should be a phandle to the tscadc unit.
+ - fsl,wires: Should be '<4>' or '<5>'
+
+Optional properties:
+ - fsl,pen-debounce: Pen debounce time.
+ - fsl,pen-threshold: Pen-down threshold for the touchscreen.
+ - fsl,settling-time: Settling time in nanoseconds.
+
+This device includes two conversion queues which can be added as subnodes.
+The first queue is for the touchscreen, the second for general purpose ADC.
+
+Example:
+	tsc: tcq at 50030400 {
+		compatible = "fsl,imx25-tcq";
+		reg = <0x50030400 0x60>;
+		interrupt-parent = <&tscadc>;
+		interrupts = <0>;
+		fsl,wires = <4>;
+	};
-- 
2.1.4
