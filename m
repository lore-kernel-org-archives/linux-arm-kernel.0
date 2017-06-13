From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Tue, 13 Jun 2017 15:58:44 +0800
Subject: [PATCH V2 1/2] dt-bindings: timer: add nxp tpm timer binding doc
In-Reply-To: <1497340725-26594-1-git-send-email-aisheng.dong@nxp.com>
References: <1497340725-26594-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1497340725-26594-2-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding NXP Low Power Timer/Pulse Width Modulation Module (TPM)
binding doc.

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: devicetree at vger.kernel.org
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Bai Ping <ping.bai@nxp.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

---
ChangeLog:
 v1->v2:
 * No changes
---
 .../devicetree/bindings/timer/nxp,tpm-timer.txt    | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt

diff --git a/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt b/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
new file mode 100644
index 0000000..b4aa7dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt
@@ -0,0 +1,28 @@
+NXP Low Power Timer/Pulse Width Modulation Module (TPM)
+
+The Timer/PWM Module (TPM) supports input capture, output compare,
+and the generation of PWM signals to control electric motor and power
+management applications. The counter, compare and capture registers
+are clocked by an asynchronous clock that can remain enabled in low
+power modes. TPM can support global counter bus where one TPM drives
+the counter bus for the others, provided bit width is the same.
+
+Required properties:
+
+- compatible :	should be "fsl,imx7ulp-tpm"
+- reg :		Specifies base physical address and size of the register sets
+		for the clock event device and clock source device.
+- interrupts :	Should be the clock event device interrupt.
+- clocks :	The clocks provided by the SoC to drive the timer, must contain
+		an entry for each entry in clock-names.
+- clock-names : Must include the following entries: "igp" and "per".
+
+Example:
+tpm5: tpm at 40260000 {
+	compatible = "fsl,imx7ulp-tpm";
+	reg = <0x40260000 0x1000>;
+	interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
+	clocks = <&clks IMX7ULP_CLK_NIC1_BUS_DIV>,
+		 <&clks IMX7ULP_CLK_LPTPM5>;
+	clock-names = "ipg", "per";
+};
-- 
2.7.4
