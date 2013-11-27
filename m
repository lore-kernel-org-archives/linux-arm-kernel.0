From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 28 Nov 2013 08:15:11 +0900
Subject: [PATCH 03/04] ARM: shmobile: Use r8a7778 suffix for INTC compat string
In-Reply-To: <20131127231450.29081.98054.sendpatchset@w520>
References: <20131127231450.29081.98054.sendpatchset@w520>
Message-ID: <20131127231511.29081.46719.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add "renesas,intc-irqpin-r8a7778" to the compatible string for the
IRQ pins in case of r8a7778 INTC. This makes the INTC irqpin follow
the same style as the other devices and also makes it more future proof.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7778.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/boot/dts/r8a7778.dtsi
+++ work/arch/arm/boot/dts/r8a7778.dtsi	2013-11-28 07:41:06.000000000 +0900
@@ -43,7 +43,7 @@
 
 	/* irqpin: IRQ0 - IRQ3 */
 	irqpin: irqpin at fe78001c {
-		compatible = "renesas,intc-irqpin";
+		compatible = "renesas,intc-irqpin-r8a7778", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		interrupt-controller;
 		status = "disabled"; /* default off */
