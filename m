From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 14 Jun 2018 13:56:04 +1000
Subject: [PATCH 2/3] arm: dts: Update AST2500 device-tree
In-Reply-To: <20180614035605.25286-1-benh@kernel.crashing.org>
References: <20180614035605.25286-1-benh@kernel.crashing.org>
Message-ID: <20180614035605.25286-2-benh@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the missing node for the CVIC (the coprocessor interrupt
controller) and add a label to the SRAM node so it can be
referenced from the board device-tree file.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 17f2714d18a7..251664984398 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -127,6 +127,11 @@
 			reg = <0x1e6c0080 0x80>;
 		};
 
+		cvic: interrupt-controller at 1e6c2000 {
+			compatible = "aspeed,ast2400-cvic";
+			reg = <0x1e6c2000 0x80>;
+		};
+
 		mac0: ethernet at 1e660000 {
 			compatible = "aspeed,ast2500-mac", "faraday,ftgmac100";
 			reg = <0x1e660000 0x180>;
@@ -211,7 +216,7 @@
 				status = "disabled";
 			};
 
-			sram at 1e720000 {
+			sram: sram at 1e720000 {
 				compatible = "mmio-sram";
 				reg = <0x1e720000 0x9000>;	// 36K
 			};
-- 
2.17.0
