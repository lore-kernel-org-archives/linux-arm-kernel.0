From: kraxel@redhat.com (Gerd Hoffmann)
Date: Mon, 19 Sep 2016 10:43:19 +0200
Subject: [PATCH v4 3/7] ARM: dts: bcm283x: add pinctrl group to &pwm,
 drop pins from &gpio
In-Reply-To: <1474274603-24215-1-git-send-email-kraxel@redhat.com>
References: <1474274603-24215-1-git-send-email-kraxel@redhat.com>
Message-ID: <1474274603-24215-4-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 88bcd0c..ff62236 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -38,7 +38,7 @@
 	};
 
 	alt0: alt0 {
-		brcm,pins = <0 1 2 3 4 5 7 8 9 10 11 40 45>;
+		brcm,pins = <0 1 2 3 4 5 7 8 9 10 11>;
 		brcm,function = <BCM2835_FSEL_ALT0>;
 	};
 
@@ -68,6 +68,8 @@
 };
 
 &pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_gpio40 &pwm1_gpio45>;
 	status = "okay";
 };
 
-- 
1.8.3.1
