From: peron.clem@gmail.com (=?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?=)
Date: Mon,  4 Jun 2018 12:00:33 +0200
Subject: [PATCH v5 2/4] dt-bindings: timer: add i.MX EPIT timer binding
In-Reply-To: <20180604100035.19558-1-peron.clem@gmail.com>
References: <20180604100035.19558-1-peron.clem@gmail.com>
Message-ID: <20180604100035.19558-3-peron.clem@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cl?ment Peron <clement.peron@devialet.com>

Add devicetree binding document for NXP's i.MX SoC specific
EPIT timer driver.

Signed-off-by: Cl?ment Peron <clement.peron@devialet.com>
---
 .../devicetree/bindings/timer/fsl,imxepit.txt | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/fsl,imxepit.txt

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxepit.txt b/Documentation/devicetree/bindings/timer/fsl,imxepit.txt
new file mode 100644
index 000000000000..de2e6ef68d24
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/fsl,imxepit.txt
@@ -0,0 +1,21 @@
+Binding for the i.MX Enhanced Periodic Interrupt Timer (EPIT)
+
+The Enhanced Periodic Interrupt Timer (EPIT) is a 32-bit set-and-forget timer
+that is capable of providing precise interrupts at regular intervals with
+minimal processor intervention.
+
+Required properties:
+- compatible: should be "fsl,<chip>-epit", "fsl,imx31-epit" where <chip> is
+  imx25, imx6qdl, imx6sl, imx6sul or imx6sx.
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: Should contain EPIT controller interrupt
+- clocks : The clock provided by the SoC to drive the timer.
+
+Example for i.MX6QDL:
+	epit1: epit at 20d0000 {
+		compatible = "fsl,imx6qdl-epit", "fsl,imx31-epit";
+		reg = <0x020d0000 0x4000>;
+		interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clks IMX6QDL_CLK_EPIT1>;
+	};
-- 
2.17.0
