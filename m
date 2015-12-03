From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 3 Dec 2015 10:53:54 +0100
Subject: [PATCH v2 4/4] ARM: at91/dt: sama5d2 Xplained: pmic needs a specific
 sda hold time
In-Reply-To: <1449136434-27619-1-git-send-email-ludovic.desroches@atmel.com>
References: <1449136434-27619-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1449136434-27619-6-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Data have to be held longer for the PMIC device. The ACT8945A
datasheet claims that minimum SDA data hold time is about 300 ns.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/boot/dts/at91-sama5d2_xplained.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
index ad6de73..9bced00 100644
--- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
@@ -129,6 +129,7 @@
 				dmas = <0>, <0>;
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_i2c0_default>;
+				i2c-sda-hold-time-ns = <350>;
 				status = "okay";
 
 				pmic: act8865 at 5b {
-- 
2.5.0
