From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 20 Sep 2018 15:05:21 -0700
Subject: [PATCH] ARM: dts: ux500: Mark PRCMU as syscon compatible
Message-ID: <20180920220521.15978-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to distribute out the responsibilities of the PRCMU
registers instead of having one big lump handling everything.
By making it syscon compatible, we can start grabbing the
register map elsewhere when needed.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 48b3323265da..e6ed7c0354a2 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -493,7 +493,7 @@
 		};
 
 		prcmu: prcmu at 80157000 {
-			compatible = "stericsson,db8500-prcmu";
+			compatible = "stericsson,db8500-prcmu", "syscon";
 			reg = <0x80157000 0x2000>, <0x801b0000 0x8000>, <0x801b8000 0x1000>;
 			reg-names = "prcmu", "prcmu-tcpm", "prcmu-tcdm";
 			interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.17.1
