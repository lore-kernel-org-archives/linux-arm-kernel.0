From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Thu, 22 Nov 2018 22:04:19 +0100
Subject: [PATCH 5/6] ARM64: dts: marvell: armada-37xx: fix SATA node scope
In-Reply-To: <20181122210420.14861-1-miquel.raynal@bootlin.com>
References: <20181122210420.14861-1-miquel.raynal@bootlin.com>
Message-ID: <20181122210420.14861-6-miquel.raynal@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the SATA IP memory area which is only 0x178 bytes long (from
Marvell A3700 specification). Actually, starting from the offset
0xe0178, there is an area dedicated to the COMPHY driver.

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 4472bcd8f9fb..e7405931f381 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -358,7 +358,7 @@
 
 			sata: sata at e0000 {
 				compatible = "marvell,armada-3700-ahci";
-				reg = <0xe0000 0x2000>;
+				reg = <0xe0000 0x178>;
 				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
 				status = "disabled";
 			};
-- 
2.19.1
