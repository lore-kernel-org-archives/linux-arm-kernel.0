From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun,  5 Feb 2012 11:38:55 +0100
Subject: [PATCH 3/4] ARM: at91: usb_a9g20 add DT i2c support
In-Reply-To: <1328438337-21185-1-git-send-email-plagnioj@jcrosoft.com>
References: <1328438337-21185-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1328438337-21185-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

use gpio-i2c and enable rv3029 RTC

enable the in the sam9g20 defconfig

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: devicetree-discuss at lists.ozlabs.org
---
 arch/arm/boot/dts/usb_a9g20.dts        |    9 +++++++++
 arch/arm/configs/at91sam9g20_defconfig |    3 +++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/usb_a9g20.dts b/arch/arm/boot/dts/usb_a9g20.dts
index 11be3e9..9d84374 100644
--- a/arch/arm/boot/dts/usb_a9g20.dts
+++ b/arch/arm/boot/dts/usb_a9g20.dts
@@ -121,6 +121,15 @@
 
 			};
 
+			i2c-gpio at 0 {
+				status = "okay";
+
+				rv3029c2 at 56 {
+					compatible = "rv3029c2";
+					reg = <0x56>;
+				};
+			};
+
 		};
 	};
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
