From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 31 Aug 2016 18:11:04 +0200
Subject: [PATCH 1/5] Documentation: dt: atmel-at91: Document secumod bindings
In-Reply-To: <20160831161108.8780-1-alexandre.belloni@free-electrons.com>
References: <20160831161108.8780-1-alexandre.belloni@free-electrons.com>
Message-ID: <20160831161108.8780-2-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A security module is available starting with sama5d2, add its bindings.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree at vger.kernel.org
 Documentation/devicetree/bindings/arm/atmel-at91.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
index e1f5ad855f14..eea1f44d5666 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
@@ -225,3 +225,20 @@ required properties:
 		compatible = "atmel,sama5d3-sfr", "syscon";
 		reg = <0xf0038000 0x60>;
 	};
+
+Security Module (SECUMOD)
+
+The Security Module macrocell provides all necessary secure functions to avoid
+voltage, temperature, frequency and mechanical attacks on the chip. It also
+embeds secure memories that can be scrambled
+
+required properties:
+- compatible: Should be "atmel,<chip>-secumod", "syscon".
+  <chip> can be "sama5d2".
+- reg: Should contain registers location and length
+
+	secumod at fc040000 {
+		compatible = "atmel,sama5d2-secumod", "syscon";
+		reg = <0xfc040000 0x100>;
+	};
+
-- 
2.9.3
