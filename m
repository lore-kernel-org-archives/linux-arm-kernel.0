From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 19 Nov 2014 17:07:57 +0100
Subject: [PATCH RESEND 3/4] hwrng: atmel: Add TRNG DT binding doc
In-Reply-To: <1416413278-10197-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1416413278-10197-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1416413278-10197-4-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document DT bindings of Atmel's TRNG (True Random Number Generator) IP.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 Documentation/devicetree/bindings/hwrng/atmel-trng.txt | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwrng/atmel-trng.txt

diff --git a/Documentation/devicetree/bindings/hwrng/atmel-trng.txt b/Documentation/devicetree/bindings/hwrng/atmel-trng.txt
new file mode 100644
index 0000000..4ac5aaa
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwrng/atmel-trng.txt
@@ -0,0 +1,16 @@
+Atmel TRNG (True Random Number Generator) block
+
+Required properties:
+- compatible : Should be "atmel,at91sam9g45-trng"
+- reg : Offset and length of the register set of this block
+- interrupts : the interrupt number for the TRNG block
+- clocks: should contain the TRNG clk source
+
+Example:
+
+trng at fffcc000 {
+	compatible = "atmel,at91sam9g45-trng";
+	reg = <0xfffcc000 0x4000>;
+	interrupts = <6 IRQ_TYPE_LEVEL_HIGH 0>;
+	clocks = <&trng_clk>;
+};
-- 
1.9.1
