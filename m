From: joel@jms.id.au (Joel Stanley)
Date: Mon, 12 Feb 2018 18:13:23 +1030
Subject: [PATCH 4/6] ARM: dts: aspeed: Add LPC clock phandles
In-Reply-To: <20180212074325.23436-1-joel@jms.id.au>
References: <20180212074325.23436-1-joel@jms.id.au>
Message-ID: <20180212074325.23436-5-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LPC device uses LCLK.

Tested-by: Lei YU <mine260309@gmail.com>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 1 +
 arch/arm/boot/dts/aspeed-g5.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 8b18176dca59..48c28a71ae7e 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -233,6 +233,7 @@
 					lpc_ctrl: lpc-ctrl at 0 {
 						compatible = "aspeed,ast2400-lpc-ctrl";
 						reg = <0x0 0x80>;
+						clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
 						status = "disabled";
 					};
 
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index e0b6803f6845..8eac57c33880 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -283,6 +283,7 @@
 					lpc_ctrl: lpc-ctrl at 0 {
 						compatible = "aspeed,ast2500-lpc-ctrl";
 						reg = <0x0 0x80>;
+						clocks = <&syscon ASPEED_CLK_GATE_LCLK>;
 						status = "disabled";
 					};
 
-- 
2.15.1
