From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 14 Jan 2015 17:21:56 +0100
Subject: [PATCH 04/12] mfd: syscon: Add Atmel SMC binding doc
In-Reply-To: <1421252524-24452-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421252524-24452-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1421252524-24452-5-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>

The SMC registers are used to configure Atmel EBI (External Bus Interface)
to interface with standard memory devices (NAND, NOR, SRAM or specialized
devices like FPGAs).

Declare this memory region as a syscon, so that different drivers can
configure the SMC interface (mostly timing configuration) according to
their need.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/mfd/atmel-smc.txt | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/atmel-smc.txt

diff --git a/Documentation/devicetree/bindings/mfd/atmel-smc.txt b/Documentation/devicetree/bindings/mfd/atmel-smc.txt
new file mode 100644
index 000000000000..26eeed373934
--- /dev/null
+++ b/Documentation/devicetree/bindings/mfd/atmel-smc.txt
@@ -0,0 +1,19 @@
+* Device tree bindings for Atmel SMC (Static Memory Controller)
+
+The SMC registers are used to configure Atmel EBI (External Bus Interface)
+to interface with standard memory devices (NAND, NOR, SRAM or specialized
+devices like FPGAs).
+
+Required properties:
+- compatible:		Should be one of the following
+			"atmel,at91sam9260-smc", "syscon"
+			"atmel,sama5d3-smc", "syscon"
+- reg:			Contains offset/length value of the SMC memory
+			region.
+
+Example:
+
+smc: smc at ffffc000 {
+	compatible = "atmel,sama5d3-smc", "syscon";
+	reg = <0xffffc000 0x1000>;
+};
-- 
2.1.0
