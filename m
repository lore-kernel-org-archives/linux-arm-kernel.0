From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 30 Sep 2014 18:19:46 +0200
Subject: [PATCH 5/6] ARM: at91/dt: add trng node
In-Reply-To: <1412093987-30241-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1412093987-30241-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1412093987-30241-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a DT node for the TRNG (True Random Number Generator) block.

Keep this block enabled as it does not depend on any external connection,
and thus should be available on all boards.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9g45.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
index 932a669..790c890 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91sam9g45.dtsi
@@ -934,6 +934,13 @@
 				status = "disabled";
 			};
 
+			trng at fffcc000 {
+				compatible = "atmel,at91sam9g45-trng";
+				reg = <0xfffcc000 0x4000>;
+				interrupts = <6 IRQ_TYPE_LEVEL_HIGH 0>;
+				clocks = <&trng_clk>;
+			};
+
 			i2c0: i2c at fff84000 {
 				compatible = "atmel,at91sam9g10-i2c";
 				reg = <0xfff84000 0x100>;
-- 
1.9.1
