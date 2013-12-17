From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Tue, 17 Dec 2013 16:47:14 +0100
Subject: [PATCH] drivers/misc: atmel_tclib: document clock properties
Message-ID: <1387295234-7123-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the clock properties required by the atmel_tclib driver.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 .../devicetree/bindings/arm/atmel-at91.txt         |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/atmel-at91.txt b/Documentation/devicetree/bindings/arm/atmel-at91.txt
index 1196290..78530e6 100644
--- a/Documentation/devicetree/bindings/arm/atmel-at91.txt
+++ b/Documentation/devicetree/bindings/arm/atmel-at91.txt
@@ -20,6 +20,10 @@ TC/TCLIB Timer required properties:
 - interrupts: Should contain all interrupts for the TC block
   Note that you can specify several interrupt cells if the TC
   block has one interrupt per channel.
+- clock-names: tuple listing input clock names.
+	Required elements: "t0_clk"
+	Optional elements: "t1_clk", "t2_clk"
+- clocks: phandles to input clocks.
 
 Examples:
 
@@ -28,6 +32,8 @@ One interrupt per TC block:
 		compatible = "atmel,at91rm9200-tcb";
 		reg = <0xfff7c000 0x100>;
 		interrupts = <18 4>;
+		clocks = <&tcb0_clk>;
+		clock-names = "t0_clk";
 	};
 
 One interrupt per TC channel in a TC block:
@@ -35,6 +41,8 @@ One interrupt per TC channel in a TC block:
 		compatible = "atmel,at91rm9200-tcb";
 		reg = <0xfffdc000 0x100>;
 		interrupts = <26 4 27 4 28 4>;
+		clocks = <&tcb1_clk>;
+		clock-names = "t0_clk";
 	};
 
 RSTC Reset Controller required properties:
-- 
1.7.9.5
