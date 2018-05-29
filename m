From: peron.clem@gmail.com (=?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?=)
Date: Tue, 29 May 2018 19:04:34 +0200
Subject: [PATCH v3 3/5] Documentation: DT: add i.MX EPIT timer binding
In-Reply-To: <20180529170436.22711-1-peron.clem@gmail.com>
References: <20180529170436.22711-1-peron.clem@gmail.com>
Message-ID: <20180529170436.22711-4-peron.clem@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cl?ment Peron <clement.peron@devialet.com>

Add devicetree binding document for NXP's i.MX SoC specific
EPIT timer driver.

Signed-off-by: Cl?ment Peron <clement.peron@devialet.com>
---
 .../devicetree/bindings/clock/imx6q,epit.txt  | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx6q,epit.txt

diff --git a/Documentation/devicetree/bindings/clock/imx6q,epit.txt b/Documentation/devicetree/bindings/clock/imx6q,epit.txt
new file mode 100644
index 000000000000..a84a60c6ae35
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imx6q,epit.txt
@@ -0,0 +1,24 @@
+Binding for the i.MX6 EPIT timer
+
+This binding uses the common clock binding[1].
+
+[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
+
+Required properties:
+- compatible: should be "fsl,imx6q-epit"
+- reg: physical base address of the controller and length of memory mapped
+  region.
+- interrupts: Should contain EPIT controller interrupt
+- clocks: list of clock specifiers, must contain an entry for each required
+  entry in clock-names
+- clock-names : should include entries "ipg", "per"
+
+Example:
+	epit1: epit at 20d0000 {
+		compatible = "fsl,imx6q-epit";
+		reg = <0x020d0000 0x4000>;
+		interrupts = <0 56 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&clks IMX6QDL_CLK_EPIT1>,
+			<&clks IMX6QDL_CLK_IPG_PER>;
+		clock-names = "ipg", "per";
+	};
-- 
2.17.0
