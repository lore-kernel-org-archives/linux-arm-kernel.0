From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Fri, 14 Apr 2017 17:40:55 +0200
Subject: [PATCH v6 4/4] ARM: dts: armada-xp: Use pwm-fan rather than gpio-fan
In-Reply-To: <20170414154056.32055-1-ralph.sennhauser@gmail.com>
References: <20170414154056.32055-1-ralph.sennhauser@gmail.com>
Message-ID: <20170414154056.32055-5-ralph.sennhauser@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>

The mvebu GPIO driver can also perform PWM on some pins. Use the pwm-fan
driver to control the fan of the WRT1900AC, giving us finer grained control
over its speed and hence noise.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
URL: https://patchwork.ozlabs.org/patch/427291/
[Ralph Sennhauser: drop flags paramter from pwms, no longer used]
Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Tested-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index 9efcf59..6d705f5 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -308,13 +308,11 @@
 		};
 	};
 
-	gpio_fan {
+	pwm_fan {
 		/* SUNON HA4010V4-0000-C99 */
-		compatible = "gpio-fan";
-		gpios = <&gpio0 24 0>;
 
-		gpio-fan,speed-map = <0    0
-				      4500 1>;
+		compatible = "pwm-fan";
+		pwms = <&gpio0 24 4000>;
 	};
 
 	dsa {
-- 
2.10.2
