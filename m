From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Tue, 26 Sep 2017 09:22:31 +0200
Subject: [PATCH v3 11/14] arm64: allwinner: a64: Fix node with unit name and
 no reg property
In-Reply-To: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
References: <20170926072234.27481-1-clabbe.montjoie@gmail.com>
Message-ID: <20170926072234.27481-12-clabbe.montjoie@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix the warning "xxx has a unit name, but no reg property" by
removing "@0" from such node

Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 662e8b7981b5..b02a8476b0c8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -347,7 +347,7 @@
 				function = "spi1";
 			};
 
-			uart0_pins_a: uart0 at 0 {
+			uart0_pins_a: uart0 {
 				pins = "PB8", "PB9";
 				function = "uart0";
 			};
@@ -571,7 +571,7 @@
 			interrupt-controller;
 			#interrupt-cells = <3>;
 
-			r_rsb_pins: rsb at 0 {
+			r_rsb_pins: rsb {
 				pins = "PL0", "PL1";
 				function = "s_rsb";
 			};
-- 
2.13.5
