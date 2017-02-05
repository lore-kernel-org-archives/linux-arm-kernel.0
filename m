From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Sun, 5 Feb 2017 11:03:14 +0100 (CET)
Subject: [PATCH 4/4] ARM: dts: add PCI to the Gemini DTSI
In-Reply-To: <20170128204839.18330-4-linus.walleij@linaro.org>
References: <20170128204839.18330-1-linus.walleij@linaro.org>
 <20170128204839.18330-4-linus.walleij@linaro.org>
Message-ID: <alpine.LNX.2.00.1702051101110.26313@T420s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus

We need to the remove hwirq 26-28 from DT.
First one will print this warning while boot.

irq: type mismatch, failed to map hwirq-26 for /soc/interrupt-controller at 48000000!

 arch/arm/boot/dts/gemini.dtsi | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/gemini.dtsi b/arch/arm/boot/dts/gemini.dtsi
index 11441e577058..0e2c021cd8c5 100644
--- a/arch/arm/boot/dts/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini.dtsi
@@ -114,10 +114,7 @@
 		pci at 50000000 {
 			compatible = "cortina,gemini-pci";
 			reg = <0x50000000 0x100>;
-			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>, /* PCI A */
-				   	<26 IRQ_TYPE_LEVEL_HIGH>, /* PCI B */
-					<27 IRQ_TYPE_LEVEL_HIGH>, /* PCI C */
-					<28 IRQ_TYPE_LEVEL_HIGH>; /* PCI D */
+			interrupts = <8 IRQ_TYPE_LEVEL_HIGH>; /* chained irq PCI A-D */
 			#address-cells = <3>;
 			#size-cells = <2>;
 			#interrupt-cells = <1>;
-- 
2.11.0
