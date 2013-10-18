From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 18 Oct 2013 11:04:20 +0200
Subject: [PATCH 1/5] ARM: ux500: fix clock for GPIO block 8
Message-ID: <1382087060-31584-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clock assignment in the device tree for GPIO block 8 was
incorrect, indicating this was managed by bit 1 on PRCC 6
while it was in fact bit 1 on PRCC 5.

Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 2ef30c1..55abf12 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -227,7 +227,7 @@
 			#gpio-cells = <2>;
 			gpio-bank = <8>;
 
-			clocks = <&prcc_pclk 6 1>;
+			clocks = <&prcc_pclk 5 1>;
 		};
 
 		pinctrl {
-- 
1.8.3.1
