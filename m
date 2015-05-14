From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 14 May 2015 18:11:04 +0200
Subject: [PATCH 1/4] ARM: scu: document Snoop Control Unit DT bindings
In-Reply-To: <1431619867-14700-1-git-send-email-linus.walleij@linaro.org>
References: <1431619867-14700-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1431619867-14700-2-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds device tree bindings for the ARM Cortex-A5 and
Cortex-A9 Snoop Control Units.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Several device trees already contain DT nodes for the Cortex-A9
and Cortex-A5 Snoop Control Units, this documents the already
existing and used bindings.
---
---
 Documentation/devicetree/bindings/arm/scu.txt | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/scu.txt

diff --git a/Documentation/devicetree/bindings/arm/scu.txt b/Documentation/devicetree/bindings/arm/scu.txt
new file mode 100644
index 000000000000..c447680519bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/scu.txt
@@ -0,0 +1,25 @@
+* ARM Snoop Control Unit (SCU)
+
+As part of the MPCore complex, Cortex-A5 and Cortex-A9 are provided
+with a Snoop Control Unit. The register range is usually 256 (0x100)
+bytes.
+
+References:
+
+- Cortex-A9: see DDI0407E Cortex-A9 MPCore Technical Reference Manual
+  Revision r2p0
+- Cortex-A5: see DDI0434B Cortex-A5 MPCore Technical Reference Manual
+  Revision r0p1
+
+- compatible : Should be:
+	"arm,cortex-a9-scu"
+	"arm,cortex-a5-scu"
+
+- reg : Specify the base address and the size of the SCU register window.
+
+Example:
+
+scu at a04100000 {
+	compatible = "arm,cortex-a9-scu";
+	reg = <0xa0410000 0x100>;
+};
-- 
1.9.3
