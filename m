From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 21 Jan 2015 10:32:04 +0100
Subject: [PATCH 5/7] ARM: mvebu: Use macros for interrupt flags on Armada 38x
 sdhci node
In-Reply-To: <1421832726-21656-1-git-send-email-gregory.clement@free-electrons.com>
References: <1421832726-21656-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1421832726-21656-6-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Instead of hardcoding the values of the interrupt flags, use the
macros provided by <include/dt-bindings/interrupt-controller/irq.h>
and <include/dt-bindings/interrupt-controller/arm-gic.h> for the
Armada 38x SDHCI node.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/armada-38x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 79c4acf186e2..71d4eca5b497 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -516,7 +516,7 @@
 			sdhci at d8000 {
 				compatible = "marvell,armada-380-sdhci";
 				reg = <0xd8000 0x1000>, <0xdc000 0x100>;
-				interrupts = <0 25 0x4>;
+				interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&gateclk 17>;
 				mrvl,clk-delay-cycles = <0x1F>;
 				status = "disabled";
-- 
1.9.1
