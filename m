From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 23 Nov 2018 15:18:30 +0100
Subject: [PATCH 11/12] ARM64: dts: marvell: armada-37xx: declare PCIe clock
In-Reply-To: <20181123141831.8214-1-miquel.raynal@bootlin.com>
References: <20181123141831.8214-1-miquel.raynal@bootlin.com>
Message-ID: <20181123141831.8214-12-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCIe IP is fed by a gated clock.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 9f7e932c8144..854b1d59b2ca 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -418,6 +418,7 @@
 			#address-cells = <3>;
 			#size-cells = <2>;
 			bus-range = <0x00 0xff>;
+			clocks = <&sb_periph_clk 13>;
 			interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 			#interrupt-cells = <1>;
 			msi-parent = <&pcie0>;
-- 
2.19.1
