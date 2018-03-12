From: harald@ccbib.org (Harald Geyer)
Date: Mon, 12 Mar 2018 16:10:47 +0000
Subject: [PATCH 2/5] arm64: dts: allwinner: a64: Add watchdog
In-Reply-To: <20180312161050.7647-1-harald@ccbib.org>
References: <20180312161050.7647-1-harald@ccbib.org>
Message-ID: <20180312161050.7647-3-harald@ccbib.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a watchdog node for the A64, automatically enabled on all boards.
Tested on Olimex Teres I.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 64e452a758fa..ca1b365bc722 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -665,5 +665,11 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
+		wdt0: watchdog at 1c20ca0 {
+			compatible = "allwinner,sun6i-a31-wdt";
+			reg = <0x01c20ca0 0x20>;
+			interrupts = <GIC_SPI 25 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 };
-- 
2.11.0
