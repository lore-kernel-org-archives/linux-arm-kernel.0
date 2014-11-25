From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 25 Nov 2014 17:40:02 +0100
Subject: [PATCH v2 1/3] ARM: at91: Add Special Function Registers binding
 documentation
Message-ID: <1416933604-31446-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The special function registers gather some registers that allow to tweak
features provided by IPs controlled through another register range.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 Documentation/devicetree/bindings/arm/atmel-at91.txt | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
index 562cda9d86d9..a6427de45785 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
@@ -136,3 +136,20 @@ Example:
 		compatible = "atmel,at91sam9260-rstc";
 		reg = <0xfffffd00 0x10>;
 	};
+
+Special Function Registers (SFR)
+
+Special Function Registers (SFR) manage specific aspects of the integrated
+memory, bridge implementations, processor and other functionality not controlled
+elsewhere.
+
+required properties:
+- compatible: Should be "atmel,<chip>-sfr", "syscon".
+  <chip> can be "at91sam9260", "at91sam9rl" or "at91sam9x5".
+- reg: Should contain registers location and length
+
+	sfr at f0038000 {
+		compatible = "atmel,sama5d3-sfr", "syscon";
+		reg = <0xf0038000 0x4000>;
+	};
+
-- 
2.1.0
