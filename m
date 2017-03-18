From: ralph.sennhauser@gmail.com (Ralph Sennhauser)
Date: Sat, 18 Mar 2017 16:43:04 +0100
Subject: [PATCH v2 4/4] mvebu: wrt1900ac: Use pwm-fan rather than gpio-fan
In-Reply-To: <20170318154305.28348-1-ralph.sennhauser@gmail.com>
References: <20170318154305.28348-1-ralph.sennhauser@gmail.com>
Message-ID: <20170318154305.28348-5-ralph.sennhauser@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>

The mvebu gpio driver can also perform PWM on some pins. Us the pwm-fan
driver to control the fan of the WRT1900AC, giving us finer grained
control over its speed and hence noise.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
URL: https://patchwork.ozlabs.org/patch/427291/
Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
---
 arch/arm/boot/dts/armada-xp-linksys-mamba.dts | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
index 3744ba3..836b275e 100644
--- a/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
+++ b/arch/arm/boot/dts/armada-xp-linksys-mamba.dts
@@ -293,13 +293,11 @@
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
+		pwms = <&gpio0 24 4000 0>;
 	};
 
 	dsa {
-- 
2.10.2
