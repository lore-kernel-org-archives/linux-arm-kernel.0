From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue,  6 Dec 2016 14:53:45 +1100
Subject: [PATCH v4 3/6] arm: dts: aspeed-g5: Add SoC Display Controller node
In-Reply-To: <20161206035348.29948-1-andrew@aj.id.au>
References: <20161206035348.29948-1-andrew@aj.id.au>
Message-ID: <20161206035348.29948-4-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 arch/arm/boot/dts/aspeed-g5.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index dd94d9361fda..c7ff3ea4bf37 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -71,6 +71,12 @@
 				reg = <0x1e6e202c 0x4>;
 			};
 
+			gfx: display at 1e6e6000 {
+				compatible = "aspeed,ast2500-gfx", "syscon";
+				reg = <0x1e6e6000 0x1000>;
+				reg-io-width = <4>;
+			};
+
 			sram at 1e720000 {
 				compatible = "mmio-sram";
 				reg = <0x1e720000 0x9000>;	// 36K
-- 
2.9.3
