From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Tue, 17 Dec 2013 16:01:47 +0100
Subject: [PATCH] drivers/misc: atmel-ssc: document clock properties
Message-ID: <1387292507-6606-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document the clock properties required by the atmel-ssc driver.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 .../devicetree/bindings/misc/atmel-ssc.txt         |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/atmel-ssc.txt b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
index a45ae08..60960b2 100644
--- a/Documentation/devicetree/bindings/misc/atmel-ssc.txt
+++ b/Documentation/devicetree/bindings/misc/atmel-ssc.txt
@@ -6,6 +6,9 @@ Required properties:
 	- atmel,at91sam9g45-ssc: support dma transfer
 - reg: Should contain SSC registers location and length
 - interrupts: Should contain SSC interrupt
+- clock-names: tuple listing input clock names.
+	Required elements: "pclk"
+- clocks: phandles to input clocks.
 
 
 Required properties for devices compatible with "atmel,at91sam9g45-ssc":
@@ -20,6 +23,8 @@ ssc0: ssc at fffbc000 {
 	compatible = "atmel,at91rm9200-ssc";
 	reg = <0xfffbc000 0x4000>;
 	interrupts = <14 4 5>;
+	clocks = <&ssc0_clk>;
+	clock-names = "pclk";
 };
 
 - DMA transfer:
-- 
1.7.9.5
