From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Mon, 10 Feb 2014 18:41:19 +0200
Subject: [PATCH v3 2/4] ARM: dts: keystone-evm: add leds supports
In-Reply-To: <1392050481-19086-1-git-send-email-grygorii.strashko@ti.com>
References: <1392050481-19086-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <1392050481-19086-3-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keystone EVMK2HX supports 4 debug LEDs controlled by GPIO lines as
following (active level is high);

DBG_D1 green gpio12
DBG_D1 red   gpio13
DBG_D1 blue  gpio14
DBG_D1 blue  gpio15

For more information see schematics:
 http://wfcache.advantech.com/www/support/TI-EVM/download/Schematics/PDF/K2H_K2EVM-HK_SCH_A102_Rev1_0.pdf

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 arch/arm/boot/dts/k2hk-evm.dts |   23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/k2hk-evm.dts b/arch/arm/boot/dts/k2hk-evm.dts
index eaefdfe..3513f8b 100644
--- a/arch/arm/boot/dts/k2hk-evm.dts
+++ b/arch/arm/boot/dts/k2hk-evm.dts
@@ -52,6 +52,29 @@
 			};
 		};
 	};
+
+	leds {
+		compatible = "gpio-leds";
+		debug1_1 {
+			label = "keystone:green:debug1";
+			gpios = <&gpio0 12 GPIO_ACTIVE_HIGH>; /* 12 */
+		};
+
+		debug1_2 {
+			label = "keystone:red:debug1";
+			gpios = <&gpio0 13 GPIO_ACTIVE_HIGH>; /* 13 */
+		};
+
+		debug2 {
+			label = "keystone:blue:debug2";
+			gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>; /* 14 */
+		};
+
+		debug3 {
+			label = "keystone:blue:debug3";
+			gpios = <&gpio0 15 GPIO_ACTIVE_HIGH>; /* 15 */
+		};
+	};
 };
 
 &usb_phy {
-- 
1.7.9.5
