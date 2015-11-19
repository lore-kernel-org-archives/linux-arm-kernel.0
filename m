From: cory.tusar@pid1solutions.com (Cory Tusar)
Date: Wed, 18 Nov 2015 22:54:39 -0500
Subject: [PATCH] ARM: dts: vfxxx: Fix dspi[01] spi-num-chipselects.
Message-ID: <1447905280-5172-1-git-send-email-cory.tusar@pid1solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Per the Vybrid Reference Manual (section 3.8.6.1), dspi0 has 6 chip
select signals associated with it, while dspi1 has only 4.

Signed-off-by: Cory Tusar <cory.tusar@pid1solutions.com>
---
 arch/arm/boot/dts/vfxxx.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 6736bae..1cca43a 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -158,7 +158,7 @@
 				interrupts = <67 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_DSPI0>;
 				clock-names = "dspi";
-				spi-num-chipselects = <5>;
+				spi-num-chipselects = <6>;
 				status = "disabled";
 			};
 
@@ -170,7 +170,7 @@
 				interrupts = <68 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks VF610_CLK_DSPI1>;
 				clock-names = "dspi";
-				spi-num-chipselects = <5>;
+				spi-num-chipselects = <4>;
 				status = "disabled";
 			};
 
-- 
2.4.10
