From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 13 Jun 2017 15:57:09 +0200
Subject: [PATCH v3 4/6] arm64: dts: marvell: armada-37xx: Use angle bracket
 for each register set
In-Reply-To: <20170613135711.7622-1-gregory.clement@free-electrons.com>
References: <20170613135711.7622-1-gregory.clement@free-electrons.com>
Message-ID: <20170613135711.7622-5-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When several groups of register address and size are used with reg, then
surround each one by angle bracket.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index c1076fd0bd9e..65562319770b 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -281,8 +281,8 @@
 
 			xor at 60900 {
 				compatible = "marvell,armada-3700-xor";
-				reg = <0x60900 0x100
-				       0x60b00 0x100>;
+				reg = <0x60900 0x100>,
+				      <0x60b00 0x100>;
 
 				xor10 {
 					interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
@@ -295,8 +295,8 @@
 			sdhci0: sdhci at d8000 {
 				compatible = "marvell,armada-3700-sdhci",
 					     "marvell,sdhci-xenon";
-				reg = <0xd8000 0x300
-				       0x17808 0x4>;
+				reg = <0xd8000 0x300>,
+				      <0x17808 0x4>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&nb_periph_clk 0>;
 				clock-names = "core";
-- 
2.11.0
