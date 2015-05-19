From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 19 May 2015 11:15:43 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Add Atmel SAMA5 family
In-Reply-To: <1428051678-20450-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1428051678-20450-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <555AFF3F.10400@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 03/04/2015 11:01, Alexandre Belloni a ?crit :
> Add the Atmel sama5d3 and sama5d4 and their peripherals to multi_v7_defconfig.
> 
> Note that the console will be ttyAT0 instead of the usual ttyS0.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

It seems good to me: thanks Alexandre.

Arnd, Olof, Kevin: do you have a comment about this addition?

If it's okay on your side, I may have to rebase it on top of whichever
branch you want, just to avoid conflicts:
- your most recent arm-soc/next/defconfig branch
- or the v4.1-rc3 tag on which the branch is made from?

Bye.


> ---
>  arch/arm/configs/multi_v7_defconfig | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index b7e6b6fba5e0..adab236c80db 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -18,6 +18,9 @@ CONFIG_MACH_ARMADA_375=y
>  CONFIG_MACH_ARMADA_38X=y
>  CONFIG_MACH_ARMADA_XP=y
>  CONFIG_MACH_DOVE=y
> +CONFIG_ARCH_AT91=y
> +CONFIG_SOC_SAMA5D3=y
> +CONFIG_SOC_SAMA5D4=y
>  CONFIG_ARCH_BCM=y
>  CONFIG_ARCH_BCM_CYGNUS=y
>  CONFIG_ARCH_BCM_21664=y
> @@ -131,6 +134,7 @@ CONFIG_CAN=y
>  CONFIG_CAN_RAW=y
>  CONFIG_CAN_BCM=y
>  CONFIG_CAN_DEV=y
> +CONFIG_CAN_AT91=m
>  CONFIG_CAN_XILINXCAN=y
>  CONFIG_CAN_MCP251X=y
>  CONFIG_CFG80211=m
> @@ -149,13 +153,16 @@ CONFIG_MTD_CMDLINE_PARTS=y
>  CONFIG_MTD_BLOCK=y
>  CONFIG_MTD_M25P80=y
>  CONFIG_MTD_NAND=y
> +CONFIG_MTD_NAND_ATMEL=y
>  CONFIG_MTD_NAND_DAVINCI=y
>  CONFIG_MTD_SPI_NOR=y
>  CONFIG_MTD_UBI=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_AD525X_DPOT=y
>  CONFIG_AD525X_DPOT_I2C=y
> +CONFIG_ATMEL_TCLIB=y
>  CONFIG_ICS932S401=y
> +CONFIG_ATMEL_SSC=m
>  CONFIG_APDS9802ALS=y
>  CONFIG_ISL29003=y
>  CONFIG_EEPROM_AT24=y
> @@ -202,6 +209,7 @@ CONFIG_RT2X00=m
>  CONFIG_RT2800USB=m
>  CONFIG_INPUT_JOYDEV=y
>  CONFIG_INPUT_EVDEV=y
> +CONFIG_KEYBOARD_QT1070=m
>  CONFIG_KEYBOARD_GPIO=y
>  CONFIG_KEYBOARD_TEGRA=y
>  CONFIG_KEYBOARD_SPEAR=y
> @@ -225,6 +233,9 @@ CONFIG_SERIAL_8250_EM=y
>  CONFIG_SERIAL_8250_MT6577=y
>  CONFIG_SERIAL_AMBA_PL011=y
>  CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
> +CONFIG_SERIAL_ATMEL=y
> +CONFIG_SERIAL_ATMEL_CONSOLE=y
> +CONFIG_SERIAL_ATMEL_TTYAT=y
>  CONFIG_SERIAL_MESON=y
>  CONFIG_SERIAL_MESON_CONSOLE=y
>  CONFIG_SERIAL_SAMSUNG=y
> @@ -250,15 +261,18 @@ CONFIG_SERIAL_FSL_LPUART=y
>  CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
>  CONFIG_SERIAL_ST_ASC=y
>  CONFIG_SERIAL_ST_ASC_CONSOLE=y
> +CONFIG_HW_RANDOM=y
>  CONFIG_I2C_CHARDEV=y
>  CONFIG_I2C_DAVINCI=y
>  CONFIG_I2C_MUX=y
>  CONFIG_I2C_MUX_PCA954x=y
>  CONFIG_I2C_MUX_PINCTRL=y
> +CONFIG_I2C_AT91=m
>  CONFIG_I2C_CADENCE=y
>  CONFIG_I2C_DESIGNWARE_PLATFORM=y
>  CONFIG_I2C_GPIO=m
>  CONFIG_I2C_EXYNOS5=y
> +CONFIG_I2C_GPIO=m
>  CONFIG_I2C_MV64XXX=y
>  CONFIG_I2C_RIIC=y
>  CONFIG_I2C_S3C2410=y
> @@ -269,6 +283,7 @@ CONFIG_I2C_TEGRA=y
>  CONFIG_I2C_XILINX=y
>  CONFIG_I2C_RCAR=y
>  CONFIG_SPI=y
> +CONFIG_SPI_ATMEL=m
>  CONFIG_SPI_CADENCE=y
>  CONFIG_SPI_DAVINCI=y
>  CONFIG_SPI_OMAP24XX=y
> @@ -397,6 +412,8 @@ CONFIG_SND=y
>  CONFIG_SND_DYNAMIC_MINORS=y
>  CONFIG_SND_USB_AUDIO=y
>  CONFIG_SND_SOC=y
> +CONFIG_SND_ATMEL_SOC=m
> +CONFIG_SND_ATMEL_SOC_WM8904=m
>  CONFIG_SND_SOC_SH4_FSI=m
>  CONFIG_SND_SOC_RCAR=m
>  CONFIG_SND_SOC_TEGRA=y
> @@ -455,6 +472,7 @@ CONFIG_MMC_SDHCI_BCM_KONA=y
>  CONFIG_MMC_SDHCI_ST=y
>  CONFIG_MMC_OMAP=y
>  CONFIG_MMC_OMAP_HS=y
> +CONFIG_MMC_ATMELMCI=y
>  CONFIG_MMC_MVSDIO=y
>  CONFIG_MMC_SDHI=y
>  CONFIG_MMC_DW=y
> @@ -495,6 +513,8 @@ CONFIG_RTC_DRV_TPS65910=y
>  CONFIG_RTC_DRV_S35390A=m
>  CONFIG_RTC_DRV_EM3027=y
>  CONFIG_RTC_DRV_PL031=y
> +CONFIG_RTC_DRV_AT91RM9200=m
> +CONFIG_RTC_DRV_AT91SAM9=m
>  CONFIG_RTC_DRV_VT8500=y
>  CONFIG_RTC_DRV_SUN6I=y
>  CONFIG_RTC_DRV_SUNXI=y
> @@ -502,6 +522,8 @@ CONFIG_RTC_DRV_MV=y
>  CONFIG_RTC_DRV_TEGRA=y
>  CONFIG_DMADEVICES=y
>  CONFIG_DW_DMAC=y
> +CONFIG_AT_HDMAC=y
> +CONFIG_AT_XDMAC=y
>  CONFIG_MV_XOR=y
>  CONFIG_TEGRA20_APB_DMA=y
>  CONFIG_SH_DMAE=y
> @@ -536,9 +558,12 @@ CONFIG_TEGRA_IOMMU_SMMU=y
>  CONFIG_MEMORY=y
>  CONFIG_TI_AEMIF=y
>  CONFIG_IIO=y
> +CONFIG_AT91_ADC=m
>  CONFIG_XILINX_XADC=y
>  CONFIG_AK8975=y
>  CONFIG_PWM=y
> +CONFIG_PWM_ATMEL=m
> +CONFIG_PWM_ATMEL_TCB=m
>  CONFIG_PWM_RENESAS_TPU=y
>  CONFIG_PWM_TEGRA=y
>  CONFIG_PWM_VT8500=y
> @@ -575,3 +600,6 @@ CONFIG_LOCKUP_DETECTOR=y
>  CONFIG_CRYPTO_DEV_TEGRA_AES=y
>  CONFIG_CPUFREQ_DT=y
>  CONFIG_KEYSTONE_IRQ=y
> +CONFIG_CRYPTO_DEV_ATMEL_AES=m
> +CONFIG_CRYPTO_DEV_ATMEL_TDES=m
> +CONFIG_CRYPTO_DEV_ATMEL_SHA=m
> 


-- 
Nicolas Ferre
