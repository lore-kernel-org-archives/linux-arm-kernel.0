From: joel@jms.id.au (Joel Stanley)
Date: Wed,  4 Oct 2017 17:19:10 +1030
Subject: [PATCH v2 2/9] ARM: dts: aspeed: Reorder ADC node
In-Reply-To: <20171004064917.2498-1-joel@jms.id.au>
References: <20171004064917.2498-1-joel@jms.id.au>
Message-ID: <20171004064917.2498-3-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We try to keep the nodes in address order. The ADC node was out of
place.

Signed-off-by: Joel Stanley <joel@jms.id.au>

---
v2:
 - Don't introduce new clk bindings
---
 arch/arm/boot/dts/aspeed-g4.dtsi | 16 ++++++++--------
 arch/arm/boot/dts/aspeed-g5.dtsi | 16 ++++++++--------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 1edd0cee6221..c2d96b8a5065 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -129,6 +129,14 @@
 				};
 			};
 
+			adc: adc at 1e6e9000 {
+				compatible = "aspeed,ast2400-adc";
+				reg = <0x1e6e9000 0xb0>;
+				clocks = <&clk_apb>;
+				#io-channel-cells = <1>;
+				status = "disabled";
+			};
+
 			sram at 1e720000 {
 				compatible = "mmio-sram";
 				reg = <0x1e720000 0x8000>;	// 32K
@@ -227,14 +235,6 @@
 				no-loopback-test;
 				status = "disabled";
 			};
-
-			adc: adc at 1e6e9000 {
-				compatible = "aspeed,ast2400-adc";
-				reg = <0x1e6e9000 0xb0>;
-				clocks = <&clk_apb>;
-				#io-channel-cells = <1>;
-				status = "disabled";
-			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index f56dd67efa50..9e71c2dac0ba 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -173,6 +173,14 @@
 				reg-io-width = <4>;
 			};
 
+			adc: adc at 1e6e9000 {
+				compatible = "aspeed,ast2500-adc";
+				reg = <0x1e6e9000 0xb0>;
+				clocks = <&clk_apb>;
+				#io-channel-cells = <1>;
+				status = "disabled";
+			};
+
 			sram at 1e720000 {
 				compatible = "mmio-sram";
 				reg = <0x1e720000 0x9000>;	// 36K
@@ -307,14 +315,6 @@
 				no-loopback-test;
 				status = "disabled";
 			};
-
-			adc: adc at 1e6e9000 {
-				compatible = "aspeed,ast2500-adc";
-				reg = <0x1e6e9000 0xb0>;
-				clocks = <&clk_apb>;
-				#io-channel-cells = <1>;
-				status = "disabled";
-			};
 		};
 	};
 };
-- 
2.14.1
