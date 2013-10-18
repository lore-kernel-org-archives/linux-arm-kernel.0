From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 18 Oct 2013 11:05:12 +0200
Subject: [PATCH 3/5] ARM: ux500: fix clock for GPIO blocks 6 and 7
Message-ID: <1382087112-31665-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock assignment in the device tree for GPIO blocks 6
and 7 was incorrect, indicating this was managed by bit 1 on
PRCC 2 while it was in fact bit 11 on PRCC 2.

Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 55abf12..5112f4c 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -197,7 +197,7 @@
 			#gpio-cells = <2>;
 			gpio-bank = <6>;
 
-			clocks = <&prcc_pclk 2 1>;
+			clocks = <&prcc_pclk 2 11>;
 		};
 
 		gpio7: gpio at 8011e080 {
@@ -212,7 +212,7 @@
 			#gpio-cells = <2>;
 			gpio-bank = <7>;
 
-			clocks = <&prcc_pclk 2 1>;
+			clocks = <&prcc_pclk 2 11>;
 		};
 
 		gpio8: gpio at a03fe000 {
-- 
1.8.3.1
