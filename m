From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 15 Feb 2018 14:44:23 +0100
Subject: [PATCH] ARM64: dts: marvell: armada-cp110: Add registers clock for
 sata node
Message-ID: <20180215134423.11800-1-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This extra clock is needed to access the registers of the AHCI SATA
controller used on the Armada 7K/8K SoCs.

The ahci drivers was already designed to support up to 5 clocks so there
is only need to update the device tree to use it. It was not noticed
until now because of wrong assumption in the clock drivers, but as this
IP really needs 2 clocks, we had to declare both of them.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
index 50038434dd53..b8cf1497dc22 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
@@ -236,7 +236,8 @@
 			"generic-ahci";
 			reg = <0x540000 0x30000>;
 			interrupts = <ICU_GRP_NSR 107 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&CP110_LABEL(clk) 1 15>;
+			clocks = <&CP110_LABEL(clk) 1 15>,
+				 <&CP110_LABEL(clk) 1 16>;
 			status = "disabled";
 		};
 
-- 
2.15.1
