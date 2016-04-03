From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  3 Apr 2016 04:03:48 +0200
Subject: [PATCH 6/8] ARM: kirkwood: DT: Remove address from gpio-i2c unit name
In-Reply-To: <1459649030-21886-1-git-send-email-andrew@lunn.ch>
References: <1459649030-21886-1-git-send-email-andrew@lunn.ch>
Message-ID: <1459649030-21886-7-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

gpio-i2c does not have a reg property, just a list of gpios.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/kirkwood-km_common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/kirkwood-km_common.dtsi b/arch/arm/boot/dts/kirkwood-km_common.dtsi
index f6096f56046d..7962bdefde49 100644
--- a/arch/arm/boot/dts/kirkwood-km_common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-km_common.dtsi
@@ -24,7 +24,7 @@
 		};
 	};
 
-	i2c at 0 {
+	i2c {
 		compatible = "i2c-gpio";
 		gpios = < &gpio0 8 GPIO_ACTIVE_HIGH		/* sda */
 			  &gpio0 9 GPIO_ACTIVE_HIGH>;		/* scl */
-- 
2.7.0
