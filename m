From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 14 Mar 2013 13:08:56 +0100
Subject: [PATCH 1/7] ARM: i.MX: Add GPT devicetree Documentation
In-Reply-To: <1363262942-26702-1-git-send-email-s.hauer@pengutronix.de>
References: <1363262942-26702-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1363262942-26702-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GPT binding is already used on i.MX6 and i.MX25, but not yet
documented. Add a binding document for it.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 Documentation/devicetree/bindings/timer/fsl,imxgpt.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/fsl,imxgpt.txt

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
new file mode 100644
index 0000000..544890a
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.txt
@@ -0,0 +1,18 @@
+Freescale i.MX GPT
+
+Required properties:
+
+- compatible : should be "fsl,<soc>-gpt"
+- reg : Specifies base physical address and size of the registers.
+- interrupts : A list of 4 interrupts; one per timer channel.
+- clocks : The clocks provided by the SoC to drive the timer.
+
+Example:
+
+gpt1: timer at 10003000 {
+	compatible = "fsl,imx27-gpt", "fsl,imx1-gpt";
+	reg = <0x10003000 0x1000>;
+	interrupts = <26>;
+	clocks = <&clks 46>, <&clks 61>;
+	clock-names = "ipg", "per";
+};
-- 
1.8.2.rc2
