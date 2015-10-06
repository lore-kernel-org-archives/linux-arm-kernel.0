From: simon.guinot@sequanux.org (Simon Guinot)
Date: Tue,  6 Oct 2015 16:13:44 +0200
Subject: [PATCH v5 4/4] ARM: mvebu: enable options for Seagate NAS in
 mvebu_v7_defconfig
In-Reply-To: <1444140824-24132-1-git-send-email-simon.guinot@sequanux.org>
References: <1444140824-24132-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <1444140824-24132-5-git-send-email-simon.guinot@sequanux.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the following options needed by the Seagate
Personal Cloud 1 and 2-Bay and the Seagate NAS 2 and 4-Bay:

SATA_AHCI
POWER_RESET_GPIO
RTC_DRV_DS1307
RTC_DRV_PCF8563

Additionnally this patch also enables NEW_LEDS which was missing for
some reasons.

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
Acked-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/configs/mvebu_v7_defconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Changes for v3:
- Add Andrew's Acked-by.

diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index 13fcd020e375..c6729bf0a8dd 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -61,6 +61,7 @@ CONFIG_MTD_SPI_NOR=y
 CONFIG_EEPROM_AT24=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
+CONFIG_SATA_AHCI=y
 CONFIG_AHCI_MVEBU=y
 CONFIG_SATA_MV=y
 CONFIG_NETDEVICES=y
@@ -85,6 +86,9 @@ CONFIG_SPI=y
 CONFIG_SPI_ORION=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_PCA953X=y
+CONFIG_POWER_SUPPLY=y
+CONFIG_POWER_RESET=y
+CONFIG_POWER_RESET_GPIO=y
 CONFIG_SENSORS_GPIO_FAN=y
 CONFIG_THERMAL=y
 CONFIG_ARMADA_THERMAL=y
@@ -111,12 +115,15 @@ CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_DOVE=y
 CONFIG_MMC_SDHCI_PXAV3=y
 CONFIG_MMC_MVSDIO=y
-CONFIG_LEDS_GPIO=y
+CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_DRV_DS1307=y
+CONFIG_RTC_DRV_PCF8563=y
 CONFIG_RTC_DRV_S35390A=y
 CONFIG_RTC_DRV_MV=y
 CONFIG_RTC_DRV_ARMADA38X=y
-- 
2.1.4
