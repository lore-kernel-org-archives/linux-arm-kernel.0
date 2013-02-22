From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 21 Feb 2013 22:42:38 -0700
Subject: [PATCH] ARM: bcm2835: fix I2C module clock rate
Message-ID: <1361511758-5208-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

BCM2835-ARM-Peripherals.pdf states that the I2C module's input clock is
nominally 150MHz, and that value is currently reflected in bcm2835.dtsi.
However, practical measurements show that the rate is actually 250MHz,
and this agrees with various downstream kernels.

Switch the I2C clock's frequency to 250MHz so that the generated bus
clock rate is accurate.

Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
---
This is a bug-fix for 3.9.

 arch/arm/boot/dts/bcm2835.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 4bf2a87..7e0481e 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -105,7 +105,7 @@
 			compatible = "fixed-clock";
 			reg = <1>;
 			#clock-cells = <0>;
-			clock-frequency = <150000000>;
+			clock-frequency = <250000000>;
 		};
 	};
 };
-- 
1.7.10.4
