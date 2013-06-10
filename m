From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 10 Jun 2013 11:40:32 +0100
Subject: [PATCH v2 09/11] ARM:stixxxx: Add stixxxx options to
 multi_v7_defconfig
In-Reply-To: <1370856477-7237-1-git-send-email-srinivas.kandagatla@st.com>
References: <1370855828-5318-1-git-send-email-srinivas.kandagatla@st.com>
 <1370856477-7237-1-git-send-email-srinivas.kandagatla@st.com>
Message-ID: <20130610104032.GA2513@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 10:27:57AM +0100, Srinivas KANDAGATLA wrote:
> This patch adds stih415 and stih416 support to multi_v7_defconfig.

This seems to drop a few options also:

CONFIG_ARM_ARCH_TIMER
CONFIG_ARM_ERRATA_754322
CONFIG_EXPERIMENTAL
CONFIG_GPIO_PL061
CONFIG_MMC_WMT

I just applied this to v3.10-rc5, and ran `make ARCH=arm multi_v7_defconfig`.
It seems MMC_WMT and GPIO_PL061 get selected elsewhere, but ARM_ARCH_TIMER and
ARM_ERRATA_754322 are left unselected.

Thanks,
Mark.

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/configs/multi_v7_defconfig |   32 +++++++++++++++-----------------
>  1 files changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 2e67a27..8a5cd5c 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -1,23 +1,20 @@
> -CONFIG_EXPERIMENTAL=y
>  CONFIG_NO_HZ=y
>  CONFIG_HIGH_RES_TIMERS=y
>  CONFIG_ARCH_MVEBU=y
>  CONFIG_MACH_ARMADA_370=y
> -CONFIG_ARCH_SIRF=y
>  CONFIG_MACH_ARMADA_XP=y
>  CONFIG_ARCH_HIGHBANK=y
>  CONFIG_ARCH_SOCFPGA=y
> -CONFIG_ARCH_SUNXI=y
> -CONFIG_ARCH_WM8850=y
> -# CONFIG_ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA is not set
> -CONFIG_ARCH_ZYNQ=y
> -CONFIG_ARM_ERRATA_754322=y
>  CONFIG_PLAT_SPEAR=y
>  CONFIG_ARCH_SPEAR13XX=y
>  CONFIG_MACH_SPEAR1310=y
>  CONFIG_MACH_SPEAR1340=y
> +CONFIG_ARCH_STIXXXX=y
> +CONFIG_ARCH_SUNXI=y
> +CONFIG_ARCH_SIRF=y
> +CONFIG_ARCH_WM8850=y
> +CONFIG_ARCH_ZYNQ=y
>  CONFIG_SMP=y
> -CONFIG_ARM_ARCH_TIMER=y
>  CONFIG_AEABI=y
>  CONFIG_HIGHMEM=y
>  CONFIG_HIGHPTE=y
> @@ -25,27 +22,30 @@ CONFIG_ARM_APPENDED_DTB=y
>  CONFIG_VFP=y
>  CONFIG_NEON=y
>  CONFIG_NET=y
> +CONFIG_DEVTMPFS=y
>  CONFIG_BLK_DEV_SD=y
>  CONFIG_ATA=y
> +CONFIG_SATA_AHCI_PLATFORM=y
>  CONFIG_SATA_HIGHBANK=y
>  CONFIG_SATA_MV=y
> -CONFIG_SATA_AHCI_PLATFORM=y
>  CONFIG_NETDEVICES=y
>  CONFIG_NET_CALXEDA_XGMAC=y
>  CONFIG_SMSC911X=y
>  CONFIG_STMMAC_ETH=y
> +CONFIG_KEYBOARD_SPEAR=y
>  CONFIG_SERIO_AMBAKMI=y
>  CONFIG_SERIAL_8250=y
>  CONFIG_SERIAL_8250_CONSOLE=y
>  CONFIG_SERIAL_8250_DW=y
> -CONFIG_KEYBOARD_SPEAR=y
>  CONFIG_SERIAL_AMBA_PL011=y
>  CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
> -CONFIG_SERIAL_OF_PLATFORM=y
>  CONFIG_SERIAL_SIRFSOC=y
>  CONFIG_SERIAL_SIRFSOC_CONSOLE=y
>  CONFIG_SERIAL_VT8500=y
>  CONFIG_SERIAL_VT8500_CONSOLE=y
> +CONFIG_SERIAL_OF_PLATFORM=y
> +CONFIG_SERIAL_ST_ASC=y
> +CONFIG_SERIAL_ST_ASC_CONSOLE=y
>  CONFIG_IPMI_HANDLER=y
>  CONFIG_IPMI_SI=y
>  CONFIG_I2C=y
> @@ -54,7 +54,6 @@ CONFIG_I2C_SIRF=y
>  CONFIG_SPI=y
>  CONFIG_SPI_PL022=y
>  CONFIG_SPI_SIRF=y
> -CONFIG_GPIO_PL061=y
>  CONFIG_FB=y
>  CONFIG_FB_ARMCLCD=y
>  CONFIG_FB_WM8505=y
> @@ -67,7 +66,6 @@ CONFIG_MMC_ARMMMCI=y
>  CONFIG_MMC_SDHCI=y
>  CONFIG_MMC_SDHCI_PLTFM=y
>  CONFIG_MMC_SDHCI_SPEAR=y
> -CONFIG_MMC_WMT=y
>  CONFIG_EDAC=y
>  CONFIG_EDAC_MM_EDAC=y
>  CONFIG_EDAC_HIGHBANK_MC=y
> @@ -75,9 +73,9 @@ CONFIG_EDAC_HIGHBANK_L2=y
>  CONFIG_RTC_CLASS=y
>  CONFIG_RTC_DRV_PL031=y
>  CONFIG_RTC_DRV_VT8500=y
> -CONFIG_PWM=y
> -CONFIG_PWM_VT8500=y
>  CONFIG_DMADEVICES=y
> -CONFIG_PL330_DMA=y
> -CONFIG_SIRF_DMA=y
>  CONFIG_DW_DMAC=y
> +CONFIG_SIRF_DMA=y
> +CONFIG_PL330_DMA=y
> +CONFIG_PWM=y
> +CONFIG_PWM_VT8500=y
> -- 
> 1.7.6.5
> 
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
> 
