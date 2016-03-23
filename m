From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Wed, 23 Mar 2016 10:49:06 +0100
Subject: [PATCH 1/1] ARM: dts: ls1021a: DSPI has 6 chip-selects
Message-ID: <1458726546-29453-1-git-send-email-alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both DSPI have signals SPIn_PCS[0:5] so in summary 6 chip-selects, not 5.
Fix that.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 arch/arm/boot/dts/ls1021a.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index bdc1dfd..e976d61 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -274,7 +274,7 @@
 			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "dspi";
 			clocks = <&platform_clk 1>;
-			spi-num-chipselects = <5>;
+			spi-num-chipselects = <6>;
 			big-endian;
 			status = "disabled";
 		};
@@ -287,7 +287,7 @@
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 			clock-names = "dspi";
 			clocks = <&platform_clk 1>;
-			spi-num-chipselects = <5>;
+			spi-num-chipselects = <6>;
 			big-endian;
 			status = "disabled";
 		};
-- 
2.7.3
