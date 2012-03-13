From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 13 Mar 2012 13:33:42 +0100
Subject: [PATCH 3/5 v4] ARM: at91: usb_a9g20 add DT i2c support
In-Reply-To: <a>
References: <a>
Message-ID: <1331642024-19869-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use i2c-gpio and enable rv3029 RTC.

Enable the rtc in the sam9g20 defconfig.

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Grant Likely <grant.likely@secretlab.ca>
Acked-by: Rob Herring <rob.herring@calxeda.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: devicetree-discuss at lists.ozlabs.org
---
 arch/arm/boot/dts/usb_a9g20.dts        |    9 +++++++++
 arch/arm/configs/at91sam9g20_defconfig |    3 +++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/usb_a9g20.dts b/arch/arm/boot/dts/usb_a9g20.dts
index 71d83ef..0ea90b5 100644
--- a/arch/arm/boot/dts/usb_a9g20.dts
+++ b/arch/arm/boot/dts/usb_a9g20.dts
@@ -97,4 +97,13 @@
 			gpio-key,wakeup;
 		};
 	};
+
+	i2c at 0 {
+		status = "okay";
+
+		rv3029c2 at 56 {
+			compatible = "rv3029c2";
+			reg = <0x56>;
+		};
+	};
 };
diff --git a/arch/arm/configs/at91sam9g20_defconfig b/arch/arm/configs/at91sam9g20_defconfig
index 9123568..994d331 100644
--- a/arch/arm/configs/at91sam9g20_defconfig
+++ b/arch/arm/configs/at91sam9g20_defconfig
@@ -74,6 +74,8 @@ CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_SERIAL_ATMEL=y
 CONFIG_SERIAL_ATMEL_CONSOLE=y
 CONFIG_HW_RANDOM=y
+CONFIG_I2C=y
+CONFIG_I2C_GPIO=y
 CONFIG_SPI=y
 CONFIG_SPI_ATMEL=y
 CONFIG_SPI_SPIDEV=y
@@ -105,6 +107,7 @@ CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_RV3029C2=y
 CONFIG_RTC_DRV_AT91SAM9=y
 CONFIG_EXT2_FS=y
 CONFIG_MSDOS_FS=y
-- 
1.7.7
