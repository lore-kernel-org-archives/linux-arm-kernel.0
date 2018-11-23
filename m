From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 23 Nov 2018 11:15:55 +0100
Subject: [PATCH 6/7] ARM64: dts: marvell: armada-37xx: declare SATA clock
In-Reply-To: <20181123101556.29888-1-miquel.raynal@bootlin.com>
References: <20181123101556.29888-1-miquel.raynal@bootlin.com>
Message-ID: <20181123101556.29888-7-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SATA IP get its clock from the north-bridge.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 036d6fd6c9ef..65bf774516ec 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -389,6 +389,7 @@
 				compatible = "marvell,armada-3700-ahci";
 				reg = <0xe0000 0x178>;
 				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&nb_periph_clk 1>;
 				status = "disabled";
 			};
 
-- 
2.19.1
