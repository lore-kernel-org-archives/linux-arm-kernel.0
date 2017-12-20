From: joel@jms.id.au (Joel Stanley)
Date: Wed, 20 Dec 2017 13:53:13 +1030
Subject: [PATCH v3 05/20] ARM: dts: aspeed: Add MAC clocks
In-Reply-To: <20171220032328.30584-1-joel@jms.id.au>
References: <20171220032328.30584-1-joel@jms.id.au>
Message-ID: <20171220032328.30584-6-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 2 ++
 arch/arm/boot/dts/aspeed-g5.dtsi | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index b938759f799e..57194d804051 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -90,6 +90,7 @@
 			compatible = "aspeed,ast2400-mac", "faraday,ftgmac100";
 			reg = <0x1e660000 0x180>;
 			interrupts = <2>;
+			clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>;
 			status = "disabled";
 		};
 
@@ -97,6 +98,7 @@
 			compatible = "aspeed,ast2400-mac", "faraday,ftgmac100";
 			reg = <0x1e680000 0x180>;
 			interrupts = <3>;
+			clocks = <&syscon ASPEED_CLK_GATE_MAC2CLK>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 1af600b48475..b6faaef2b1a7 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -124,6 +124,7 @@
 			compatible = "aspeed,ast2500-mac", "faraday,ftgmac100";
 			reg = <0x1e660000 0x180>;
 			interrupts = <2>;
+			clocks = <&syscon ASPEED_CLK_GATE_MAC1CLK>;
 			status = "disabled";
 		};
 
@@ -131,6 +132,7 @@
 			compatible = "aspeed,ast2500-mac", "faraday,ftgmac100";
 			reg = <0x1e680000 0x180>;
 			interrupts = <3>;
+			clocks = <&syscon ASPEED_CLK_GATE_MAC2CLK>;
 			status = "disabled";
 		};
 
-- 
2.15.1
