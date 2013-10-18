From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 18 Oct 2013 11:05:23 +0200
Subject: [PATCH 4/5] ARM: ux500: fix I2C4 clock bit
Message-ID: <1382087123-31702-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PCLK for I2C4 is controlled by bit 10 in the PCKEN registers
while the KCLK is controlled by bit 9 on the KCKEN, it's
one of these odd assymetric things. Correct the PCLK bit to 10.

Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 5112f4c..b7d1738 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -694,7 +694,7 @@
 
 			clock-frequency = <400000>;
 
-			clocks = <&prcc_kclk 1 9>, <&prcc_pclk 1 9>;
+			clocks = <&prcc_kclk 1 10>, <&prcc_pclk 1 9>;
 			clock-names = "i2cclk", "apb_pclk";
 		};
 
-- 
1.8.3.1
