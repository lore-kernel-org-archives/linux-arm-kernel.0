From: noralf@tronnes.org (=?UTF-8?q?Noralf=20Tr=C3=B8nnes?=)
Date: Tue,  9 Jun 2015 12:21:45 +0200
Subject: [PATCH 3/3] ARM: dts: bcm2835-rpi: Add "brcm,
 raspberrypi-pm-wdt" to wdt compatible
In-Reply-To: <1433845305-17329-1-git-send-email-noralf@tronnes.org>
References: <1433845305-17329-1-git-send-email-noralf@tronnes.org>
Message-ID: <1433845305-17329-3-git-send-email-noralf@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Raspberry Pi uses a new value for halt in the PM_RSTS watchdog
register. Expand the compatible string to cover this.

Signed-off-by: Noralf Tr?nnes <noralf@tronnes.org>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 4 ++++
 arch/arm/boot/dts/bcm2835.dtsi     | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index 46780bb..feb1282 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -16,6 +16,10 @@
 	};
 };
 
+&watchdog {
+	compatible = "brcm,raspberrypi-pm-wdt", "brcm,bcm2835-pm-wdt";
+};
+
 &gpio {
 	pinctrl-names = "default";
 
diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
index 301c73f..3445bb3 100644
--- a/arch/arm/boot/dts/bcm2835.dtsi
+++ b/arch/arm/boot/dts/bcm2835.dtsi
@@ -52,7 +52,7 @@
 			#interrupt-cells = <2>;
 		};
 
-		watchdog at 7e100000 {
+		watchdog: watchdog at 7e100000 {
 			compatible = "brcm,bcm2835-pm-wdt";
 			reg = <0x7e100000 0x28>;
 		};
-- 
2.2.2
