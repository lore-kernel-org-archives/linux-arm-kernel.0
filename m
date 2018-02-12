From: joel@jms.id.au (Joel Stanley)
Date: Mon, 12 Feb 2018 18:13:20 +1030
Subject: [PATCH 1/6] ARM: dts: aspeed: Add IPMI BT node
In-Reply-To: <20180212074325.23436-1-joel@jms.id.au>
References: <20180212074325.23436-1-joel@jms.id.au>
Message-ID: <20180212074325.23436-2-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IPMI BT device part of the LPC interface and is used for
communication with the host processor.

Acked-by: Andrew Jeffery <andrew@aj.id.au>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 7 +++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index b0d8431a3700..8b18176dca59 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -247,6 +247,13 @@
 						compatible = "aspeed,ast2400-lhc";
 						reg = <0x20 0x24 0x48 0x8>;
 					};
+
+					ibt: ibt at c0  {
+						compatible = "aspeed,ast2400-ibt-bmc";
+						reg = <0xc0 0x18>;
+						interrupts = <8>;
+						status = "disabled";
+					};
 				};
 			};
 
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 40de3b66c33f..18185484a224 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -298,6 +298,13 @@
 						compatible = "aspeed,ast2500-lhc";
 						reg = <0x20 0x24 0x48 0x8>;
 					};
+
+					ibt: ibt at c0 {
+						compatible = "aspeed,ast2500-ibt-bmc";
+						reg = <0xc0 0x18>;
+						interrupts = <8>;
+						status = "disabled";
+					};
 				};
 			};
 
-- 
2.15.1
