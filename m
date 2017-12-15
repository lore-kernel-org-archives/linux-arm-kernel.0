From: joel@jms.id.au (Joel Stanley)
Date: Fri, 15 Dec 2017 16:03:32 +1030
Subject: [PATCH] ARM: dts: aspeed-g4: Correct VUART IRQ number
Message-ID: <20171215053332.31690-1-joel@jms.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This should have always been 8.

Fixes: db4d6d9d80fa ("ARM: dts: aspeed: Correctly order UART nodes")
Cc: stable at vger.kernel.org
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
ARM maintainers, please include this fix for 4.15

 arch/arm/boot/dts/aspeed-g4.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index 45d815a86d42..de08d9045cb8 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -219,7 +219,7 @@
 				compatible = "aspeed,ast2400-vuart";
 				reg = <0x1e787000 0x40>;
 				reg-shift = <2>;
-				interrupts = <10>;
+				interrupts = <8>;
 				clocks = <&clk_uart>;
 				no-loopback-test;
 				status = "disabled";
-- 
2.14.1
