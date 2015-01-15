From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 15 Jan 2015 14:50:43 +0100
Subject: [PATCH v2 1/2] ARM: shmobile: r8a73a4: Correct mask for GIC PPI
 interrupts
In-Reply-To: <1421329844-19707-1-git-send-email-geert+renesas@glider.be>
References: <1421329844-19707-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1421329844-19707-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

R-Mobile APE6 (r8a73a4) contains four Cortex-A15 and four Cortex-A7
cores, hence the second interrupt specifier cell for Private Peripheral
Interrupts should use "GIC_CPU_MASK_SIMPLE(8)", so GIC interrupts are
delivered to all 8 processor cores.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Untested

v2:
  - Drop RFC status after receiving confirmation from Liviu Dudau.
---
 arch/arm/boot/dts/r8a73a4.dtsi | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/r8a73a4.dtsi b/arch/arm/boot/dts/r8a73a4.dtsi
index 38136d9f6d95a16e..424c189640812c91 100644
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
 
 	dbsc1: memory-controller at e6790000 {
@@ -375,6 +375,6 @@
 			<0 0xf1002000 0 0x1000>,
 			<0 0xf1004000 0 0x2000>,
 			<0 0xf1006000 0 0x2000>;
-		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
+		interrupts = <1 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 };
-- 
1.9.1
