From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Mon, 18 Jun 2018 14:59:01 +1000
Subject: [PATCH v2 3/4] arm: dts: Update AST2500 device-tree
In-Reply-To: <20180618045902.11453-1-benh@kernel.crashing.org>
References: <20180618045902.11453-1-benh@kernel.crashing.org>
Message-ID: <20180618045902.11453-4-benh@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the missing node for the CVIC (the coprocessor interrupt
controller) and add a label to the SRAM node so it can be
referenced from the board device-tree file.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 17f2714d18a7..21141ca1bfa4 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -127,6 +127,13 @@
 			reg = <0x1e6c0080 0x80>;
 		};
 
+		cvic: copro-interrupt-controller at 1e6c2000 {
+			compatible = "aspeed,ast2500-cvic", "aspeed-cvic";
+			valid-sources = <0xffffffff>;
+			copro-sw-interrupts = <1>;
+			reg = <0x1e6c2000 0x80>;
+		};
+
 		mac0: ethernet at 1e660000 {
 			compatible = "aspeed,ast2500-mac", "faraday,ftgmac100";
 			reg = <0x1e660000 0x180>;
@@ -211,7 +218,7 @@
 				status = "disabled";
 			};
 
-			sram at 1e720000 {
+			sram: sram at 1e720000 {
 				compatible = "mmio-sram";
 				reg = <0x1e720000 0x9000>;	// 36K
 			};
-- 
2.17.1
