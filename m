From: andre.przywara@arm.com (Andre Przywara)
Date: Mon, 22 Feb 2016 18:20:55 +0000
Subject: [PATCH v3 10/10] arm64: add defconfig options for Allwinner SoCs
In-Reply-To: <1456165255-31013-1-git-send-email-andre.przywara@arm.com>
References: <1456165255-31013-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1456165255-31013-11-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the Allwinner platform now supported, enable it in the defconfig
and add some options to give some decent out-of-the-box experience on
those SoCs.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/configs/defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 18ca9fb..7acadce 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -31,6 +31,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
+CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_BCM_IPROC=y
 CONFIG_ARCH_BERLIN=y
 CONFIG_ARCH_EXYNOS7=y
@@ -135,12 +136,15 @@ CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
 CONFIG_VIRTIO_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_MV64XXX=y
 CONFIG_I2C_QUP=y
 CONFIG_I2C_RCAR=y
 CONFIG_SPI=y
 CONFIG_SPI_PL022=y
 CONFIG_SPI_QUP=y
 CONFIG_PINCTRL_MSM8916=y
+CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_PL061=y
 CONFIG_GPIO_RCAR=y
 CONFIG_GPIO_XGENE=y
@@ -175,10 +179,12 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_TEGRA=y
 CONFIG_MMC_SPI=y
+CONFIG_MMC_SUNXI=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_IDMAC=y
 CONFIG_MMC_DW_PLTFM=y
 CONFIG_MMC_DW_EXYNOS=y
+CONFIG_MMC_BLOCK_MINORS=16
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_SYSCON=y
@@ -187,6 +193,7 @@ CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_EFI=y
+CONFIG_RTC_DRV_SUN6I=y
 CONFIG_RTC_DRV_XGENE=y
 CONFIG_DMADEVICES=y
 CONFIG_RCAR_DMAC=y
-- 
2.6.4
