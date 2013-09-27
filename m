From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 27 Sep 2013 08:48:16 +0200
Subject: [PATCH 2/2] ARM: AT91: Animeo IP: add ADC support
In-Reply-To: <1380264496-16887-1-git-send-email-plagnioj@jcrosoft.com>
References: <1380264496-16887-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1380264496-16887-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable ADC driver in dt defconfig

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/animeo_ip.dts    | 7 +++++++
 arch/arm/configs/at91_dt_defconfig | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/animeo_ip.dts b/arch/arm/boot/dts/animeo_ip.dts
index 6b4b6a1..ee188ce 100644
--- a/arch/arm/boot/dts/animeo_ip.dts
+++ b/arch/arm/boot/dts/animeo_ip.dts
@@ -90,6 +90,13 @@
 				};
 			};
 
+			adc0: adc at fffe0000 {
+				atmel,adc-channels-used = <0x3>;
+				atmel,adc-sleep-mode;
+				atmel,adc-sample-hold-time = <2>;
+				status = "okay";
+			};
+
 			watchdog at fffffd40 {
 				status = "okay";
 			};
diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index 690e892..1eae64f 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -177,6 +177,8 @@ CONFIG_RTC_DRV_AT91RM9200=y
 CONFIG_RTC_DRV_AT91SAM9=y
 CONFIG_DMADEVICES=y
 # CONFIG_IOMMU_SUPPORT is not set
+CONFIG_IIO=y
+CONFIG_AT91_ADC=y
 CONFIG_EXT4_FS=y
 CONFIG_FANOTIFY=y
 CONFIG_VFAT_FS=y
-- 
1.8.4.rc3
