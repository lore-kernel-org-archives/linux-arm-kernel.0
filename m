From: noralf@tronnes.org (=?UTF-8?q?Noralf=20Tr=C3=B8nnes?=)
Date: Tue, 27 Sep 2016 13:57:06 +0200
Subject: [PATCH v2 8/8] ARM: bcm2835: Disable i2c2 in the Device Tree
In-Reply-To: <1474977426-3272-1-git-send-email-noralf@tronnes.org>
References: <1474977426-3272-1-git-send-email-noralf@tronnes.org>
Message-ID: <1474977426-3272-9-git-send-email-noralf@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i2c2 is connected to the HDMI connector and is controlled by the
firmware. Disable it to stay out of harms way.

>From the downstream commit:
i2c-bcm2708/BCM270X_DT: Add support for I2C2

The third I2C bus (I2C2) is normally reserved for HDMI use. Careless
use of this bus can break an attached display - use with caution.

It is recommended to disable accesses by VideoCore by setting
hdmi_ignore_edid=1 or hdmi_edid_file=1 in config.txt.

Signed-off-by: Noralf Tr?nnes <noralf@tronnes.org>
---
 arch/arm/boot/dts/bcm2835-rpi.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
index e9b47b2..8bffbee 100644
--- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
+++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
@@ -59,10 +59,6 @@
 	clock-frequency = <100000>;
 };
 
-&i2c2 {
-	status = "okay";
-};
-
 &sdhci {
 	status = "okay";
 	bus-width = <4>;
-- 
2.8.2
