From: stuart.yoder@nxp.com (Stuart Yoder)
Date: Tue, 19 Apr 2016 17:39:23 -0500
Subject: [PATCH 3/3] arm64: defconfig: enable freescale/nxp config options
Message-ID: <1461105563-23916-1-git-send-email-stuart.yoder@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable standard drivers for the NXP/Freescale ls2080a and
ls1043a SoCs:
   -system clock driver
   -sata (AHCI)
   -sd/mmc (ESDHC)
   -i2c support and i2c mux
   -i2c rtc clock
   -i2c sensors (as modules)

Signed-off-by: Stuart Yoder <stuart.yoder@nxp.com>
---
 arch/arm64/configs/defconfig | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e8bc263..523e19d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -102,6 +102,7 @@ CONFIG_SATA_AHCI_PLATFORM=y
 CONFIG_AHCI_CEVA=y
 CONFIG_AHCI_MVEBU=y
 CONFIG_AHCI_XGENE=y
+CONFIG_AHCI_QORIQ=y
 CONFIG_SATA_RCAR=y
 CONFIG_PATA_PLATFORM=y
 CONFIG_PATA_OF_PLATFORM=y
@@ -146,7 +147,10 @@ CONFIG_SERIAL_MVEBU_UART=y
 CONFIG_VIRTIO_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_MUX=y
+CONFIG_I2C_MUX_PCA954x=y
 CONFIG_I2C_DESIGNWARE_PLATFORM=y
+CONFIG_I2C_IMX=y
 CONFIG_I2C_MV64XXX=y
 CONFIG_I2C_QUP=y
 CONFIG_I2C_TEGRA=y
@@ -167,7 +171,8 @@ CONFIG_GPIO_XGENE=y
 CONFIG_POWER_RESET_MSM=y
 CONFIG_POWER_RESET_XGENE=y
 CONFIG_POWER_RESET_SYSCON=y
-# CONFIG_HWMON is not set
+CONFIG_SENSORS_LM90=m
+CONFIG_SENSORS_INA2XX=m
 CONFIG_THERMAL=y
 CONFIG_THERMAL_EMULATION=y
 CONFIG_EXYNOS_THERMAL=y
@@ -213,6 +218,7 @@ CONFIG_MMC_BLOCK_MINORS=32
 CONFIG_MMC_ARMMMCI=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
+CONFIG_MMC_SDHCI_OF_ESDHC=y
 CONFIG_MMC_SDHCI_TEGRA=y
 CONFIG_MMC_SDHCI_MSM=y
 CONFIG_MMC_SPI=y
@@ -229,6 +235,7 @@ CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_S5M=y
+CONFIG_RTC_DRV_DS3232=y
 CONFIG_RTC_DRV_EFI=y
 CONFIG_RTC_DRV_PL031=y
 CONFIG_RTC_DRV_SUN6I=y
@@ -246,6 +253,7 @@ CONFIG_XEN_GNTDEV=y
 CONFIG_XEN_GRANT_DEV_ALLOC=y
 CONFIG_COMMON_CLK_SCPI=y
 CONFIG_COMMON_CLK_CS2000_CP=y
+CONFIG_CLK_QORIQ=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_MSM_GCC_8916=y
 CONFIG_HWSPINLOCK_QCOM=y
-- 
1.9.0
