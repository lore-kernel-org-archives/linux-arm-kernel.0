From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 27 Nov 2014 11:57:19 +0100
Subject: [PATCH/RFC 4/4] ARM: shmobile: r8a73a4: Correct mask for GIC PPI
 interrupts
In-Reply-To: <1417085839-22836-1-git-send-email-geert+renesas@glider.be>
References: <1417085839-22836-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1417085839-22836-5-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R-Mobile APE6 (r8a73a4) contains four Cortex-A15 and four Cortex-A7
cores, hence the second interrupt specifier cell for Private Peripheral
Interrupts should use "GIC_CPU_MASK_SIMPLE(8)".

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Untested.
Is this correct? Or should the interrupts be delivered to the four
Cortex-A15 cores only by default?
---
 arch/arm/boot/dts/r8a73a4.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 5ac57babc3b95c99..6291a57fe8bf440f 100644
--- a/arch/arm/boot/dts/r8a73a4.dtsi
+++ b/arch/arm/boot/dts/r8a73a4.dtsi
@@ -32,10 +32,10 @@
 
 	timer {
 		compatible = "arm,armv7-timer";
-		interrupts = <1 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <1 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <1 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-			     <1 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts = <1 13 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <1 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <1 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
+			     <1 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
 	};
 
 	dmac: dma-multiplexer {
@@ -365,6 +365,6 @@
 			<0 0xf1002000 0 0x1000>,
 			<0 0xf1004000 0 0x2000>,
 			<0 0xf1006000 0 0x2000>;
-		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 };
-- 
1.9.1
