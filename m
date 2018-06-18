From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Mon, 18 Jun 2018 14:59:02 +1000
Subject: [PATCH v2 4/4] arm: dts: Update AST2400 device-tree
In-Reply-To: <20180618045902.11453-1-benh@kernel.crashing.org>
References: <20180618045902.11453-1-benh@kernel.crashing.org>
Message-ID: <20180618045902.11453-5-benh@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the missing node for the CVIC (the coprocessor interrupt
controller) and add a label to the SRAM node so it can be
referenced from the board device-tree file.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 75df1573380e..b1a19f99a4c9 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -92,6 +92,12 @@
 			reg = <0x1e6c0080 0x80>;
 		};
 
+		cvic: copro-interrupt-controller at 1e6c2000 {
+			compatible = "aspeed,ast2400-cvic", "aspeed-cvic";
+			valid-sources = <0x7fffffff>;
+			reg = <0x1e6c2000 0x80>;
+		};
+
 		mac0: ethernet at 1e660000 {
 			compatible = "aspeed,ast2400-mac", "faraday,ftgmac100";
 			reg = <0x1e660000 0x180>;
@@ -161,7 +167,7 @@
 				status = "disabled";
 			};
 
-			sram at 1e720000 {
+			sram: sram at 1e720000 {
 				compatible = "mmio-sram";
 				reg = <0x1e720000 0x8000>;	// 32K
 			};
-- 
2.17.1
