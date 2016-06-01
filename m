From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed,  1 Jun 2016 23:43:28 +0200
Subject: [PATCH 19/32] bcm2837-rpi-3-b.dts: move most RPi default pin groups
 to their devices
In-Reply-To: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
References: <1464817421-8519-1-git-send-email-kraxel@redhat.com>
Message-ID: <1464817421-8519-20-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
index 8579df3..4636c16 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dts
@@ -25,17 +25,9 @@
 	};
 };
 
-&gpio {
-	pinctrl-0 = <&i2c0_gpio0
-		     &i2c1_gpio2
-		     &gpclk0_gpio4
-		     &gpclk1_gpio5
-		     &spi0_gpio7
-		     &pcm_gpio18
-		     &pwm0_gpio40
-		     &pwm1_gpio45
-		     &emmc_gpio48
-		     &gpioout>;
+&i2s {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcm_gpio18>;
 };
 
 &uart1 {
-- 
1.8.3.1
