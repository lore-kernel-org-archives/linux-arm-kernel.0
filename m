From: uwe@kleine-koenig.org (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 26 May 2017 20:06:07 +0200
Subject: [PATCH RFC 3/5] ARM: dts: at91-sama5d4: use IRQ_TYPE_* to specify irq
 flags
In-Reply-To: <20170526180609.2699-1-uwe@kleine-koenig.org>
References: <20170526180609.2699-1-uwe@kleine-koenig.org>
Message-ID: <20170526180609.2699-3-uwe@kleine-koenig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the binding documentation and the source code the atmel-gpio
controller takes IRQ_TYPE_* as its flags values, not GPIO_ACTIVE_*.

This patch uses the right variable type which yields the same result
when compiled. Note that this might be wrong and actually
IRQ_TYPE_LEVEL_LOW is intended by the dt author.

Signed-off-by: Uwe Kleine-K?nig <uwe@kleine-koenig.org>
---
Hello,

can somebody with the hardware or it's documentation please check which
flag is the right one?

Best regards
Uwe

 arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi b/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
index b5a5a91bc2ef..b813fdfa2842 100644
--- a/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
+++ b/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
@@ -75,7 +75,7 @@
 					reg = <0>;
 					clocks = <&clk20m>;
 					interrupt-parent = <&pioE>;
-					interrupts = <6 GPIO_ACTIVE_LOW>;
+					interrupts = <6 IRQ_TYPE_EDGE_RISING>;
 					spi-max-frequency = <10000000>;
 				};
 
@@ -84,7 +84,7 @@
 					reg = <1>;
 					clocks = <&clk20m>;
 					interrupt-parent = <&pioE>;
-					interrupts = <7 GPIO_ACTIVE_LOW>;
+					interrupts = <7 IRQ_TYPE_EDGE_RISING>;
 					spi-max-frequency = <10000000>;
 				};
 			};
-- 
2.11.0
