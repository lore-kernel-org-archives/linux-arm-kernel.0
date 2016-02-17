From: andre.przywara@arm.com (Andre Przywara)
Date: Wed, 17 Feb 2016 11:44:00 +0000
Subject: [PATCH v2 8/8] arm64: add defconfig options for Allwinner SoCs
In-Reply-To: <1455709440-8668-1-git-send-email-andre.przywara@arm.com>
References: <1455709440-8668-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1455709440-8668-9-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the Allwinner platform now supported, enable it in the defconfig
and add some options to give some decent out-of-the-box experience on
those SoCs.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Will,

feel free to take this more as a reference than an actual patch.
I can either resend this later or you pick the respective options
yourself.

Cheers,
Andre.

 arch/arm64/configs/defconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 91ae263..8aaa09a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -30,6 +30,7 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
 # CONFIG_IOSCHED_DEADLINE is not set
+CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_BCM_IPROC=y
 CONFIG_ARCH_BERLIN=y
 CONFIG_ARCH_EXYNOS7=y
@@ -138,6 +139,8 @@ CONFIG_SERIAL_XILINX_PS_UART=y
 CONFIG_SERIAL_XILINX_PS_UART_CONSOLE=y
 CONFIG_VIRTIO_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_MV64XXX=y
 CONFIG_I2C_QUP=y
 CONFIG_I2C_UNIPHIER_F=y
 CONFIG_I2C_RCAR=y
@@ -147,6 +150,7 @@ CONFIG_SPI_QUP=y
 CONFIG_SPMI=y
 CONFIG_PINCTRL_MSM8916=y
 CONFIG_PINCTRL_QCOM_SPMI_PMIC=y
+CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_PL061=y
 CONFIG_GPIO_RCAR=y
 CONFIG_GPIO_XGENE=y
@@ -191,8 +195,10 @@ CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_TEGRA=y
 CONFIG_MMC_SPI=y
+CONFIG_MMC_SUNXI=y
 CONFIG_MMC_DW=y
 CONFIG_MMC_DW_EXYNOS=y
+CONFIG_MMC_BLOCK_MINORS=16
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
 CONFIG_LEDS_SYSCON=y
@@ -202,6 +208,7 @@ CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_EFI=y
 CONFIG_RTC_DRV_PL031=y
+CONFIG_RTC_DRV_SUN6I=y
 CONFIG_RTC_DRV_XGENE=y
 CONFIG_DMADEVICES=y
 CONFIG_QCOM_BAM_DMA=y
-- 
2.6.4
