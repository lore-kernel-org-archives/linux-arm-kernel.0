From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 10 Jun 2016 11:35:55 -0700
Subject: [PATCH 2/3] ARM: dts: BCM5301X: Add SRAB interrupts
In-Reply-To: <1465583756-26740-1-git-send-email-f.fainelli@gmail.com>
References: <1465583756-26740-1-git-send-email-f.fainelli@gmail.com>
Message-ID: <1465583756-26740-3-git-send-email-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add interrupt mapping for the Switch Register Access Block. Only 12
interrupts are usable at the moment even though up to 32 are dedicated
to the SRAB.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm5301x.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 9fb565841004..a20ebd2ac9a2 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -153,6 +153,21 @@
 			/* ChipCommon */
 			<0x00000000 0 &gic GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
 
+			/* Switch Register Access Block */
+			<0x00007000 0 &gic GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>,
+			<0x00007000 1 &gic GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+			<0x00007000 2 &gic GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+			<0x00007000 3 &gic GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+			<0x00007000 4 &gic GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+			<0x00007000 5 &gic GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+			<0x00007000 6 &gic GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
+			<0x00007000 7 &gic GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+			<0x00007000 8 &gic GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+			<0x00007000 9 &gic GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+			<0x00007000 10 &gic GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+			<0x00007000 11 &gic GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+			<0x00007000 12 &gic GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>,
+
 			/* PCIe Controller 0 */
 			<0x00012000 0 &gic GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
 			<0x00012000 1 &gic GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.7.4
