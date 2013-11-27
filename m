From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 28 Nov 2013 08:15:18 +0900
Subject: [PATCH 04/04] ARM: shmobile: Use r8a7779 suffix for INTC compat string
In-Reply-To: <20131127231450.29081.98054.sendpatchset@w520>
References: <20131127231450.29081.98054.sendpatchset@w520>
Message-ID: <20131127231518.29081.570.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Add "renesas,intc-irqpin-r8a7779" to the compatible string for the
IRQ pins in case of r8a7779 INTC. This makes the INTC irqpin follow
the same style as the other devices and also makes it more future proof.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/boot/dts/r8a7779.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/boot/dts/r8a7779.dtsi
+++ work/arch/arm/boot/dts/r8a7779.dtsi	2013-11-28 07:42:50.000000000 +0900
@@ -135,7 +135,7 @@
 	};
 
 	irqpin0: irqpin at fe780010 {
-		compatible = "renesas,intc-irqpin";
+		compatible = "renesas,intc-irqpin-r8a7779", "renesas,intc-irqpin";
 		#interrupt-cells = <2>;
 		status = "disabled";
 		interrupt-controller;
