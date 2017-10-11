From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Wed, 11 Oct 2017 15:29:58 +1300
Subject: [PATCH 3/3] ARM: mvebu: dts: connect interrupt for WD on armada-38x
In-Reply-To: <20171011022958.31268-1-chris.packham@alliedtelesis.co.nz>
References: <20171011022958.31268-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20171011022958.31268-4-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The watchdog timer interrupt is available internally on the Armada-38x
SoCs. Connect it so that we can have the orion_wdt_irq generate debug
information when a watchdog timeout occurs.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 arch/arm/boot/dts/armada-38x.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 7ff0811e61db..9ac76c54c9e5 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -408,6 +408,7 @@
 				reg = <0x20300 0x34>, <0x20704 0x4>, <0x18260 0x4>;
 				clocks = <&coreclk 2>, <&refclk>;
 				clock-names = "nbclk", "fixed";
+				interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			cpurst: cpurst at 20800 {
-- 
2.14.2
