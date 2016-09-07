From: kraxel@redhat.com (Gerd Hoffmann)
Date: Wed,  7 Sep 2016 12:31:29 +0200
Subject: [PATCH 8/8] ARM: dts: bcm283x: add pinctrl group to &sdhci,
 drop pins from &gpio
In-Reply-To: <1473244289-20728-1-git-send-email-kraxel@redhat.com>
References: <1473244289-20728-1-git-send-email-kraxel@redhat.com>
Message-ID: <1473244289-20728-9-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 8688204..3f0ce61 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -43,7 +43,7 @@
 	};
 
 	alt3: alt3 {
-		brcm,pins = <48 49 50 51 52 53>;
+		brcm,pins = <>;
 		brcm,function = <BCM2835_FSEL_ALT3>;
 	};
 };
@@ -67,6 +67,8 @@
 };
 
 &sdhci {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_gpio48>;
 	status = "okay";
 	bus-width = <4>;
 };
-- 
1.8.3.1
