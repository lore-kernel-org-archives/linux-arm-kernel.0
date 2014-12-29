From: balbi@ti.com (Felipe Balbi)
Date: Mon, 29 Dec 2014 13:11:59 -0600
Subject: [PATCH v2] ARM: config: multi_v7: Update it for Keystone defconfig
In-Reply-To: <1419879089-3293-1-git-send-email-santosh.shilimkar@oracle.com>
References: <1419879089-3293-1-git-send-email-santosh.shilimkar@oracle.com>
Message-ID: <20141229191159.GP29379@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 29, 2014 at 10:51:29AM -0800, Santosh Shilimkar wrote:
> From: Grygorii Strashko <grygorii.strashko@linaro.org>
> 
> Sync multi_v7_defconfig with the current keystone_defconfig with
> recent updates.
> 
>  CONFIG_PCI_KEYSTONE=y
>  CONFIG_MTD_NAND_DAVINCI=y
>  CONFIG_I2C_DAVINCI=y
>  CONFIG_SPI_DAVINCI=y
>  CONFIG_GPIO_DAVINCI=y
>  CONFIG_GPIO_SYSCON=y
>  CONFIG_POWER_RESET_KEYSTONE=y
>  CONFIG_DAVINCI_WATCHDOG
>  CONFIG_USB_DWC3=y
>  CONFIG_KEYSTONE_USB_PHY=y
>  CONFIG_TI_AEMIF=y
>  CONFIG_KEYSTONE_IRQ=y
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@linaro.org>
> Signed-off-by: Santosh Shilimkar <ssantosh@kernel.org>

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
> v2 : Dropped DWC DEBUG and VERBOSE options as suggested by Felipe
> 
> Tested (no LPAE):
> - boot
> - gpio
> - leds
> - reset
> - nand (partition detection)
> - usb (boot + dev detection)
>  arch/arm/configs/multi_v7_defconfig | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 2328fe7..94ae20c 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -78,6 +78,7 @@ CONFIG_ARCH_WM8850=y
>  CONFIG_ARCH_ZYNQ=y
>  CONFIG_TRUSTED_FOUNDATIONS=y
>  CONFIG_PCI=y
> +CONFIG_PCI_KEYSTONE=y
>  CONFIG_PCI_MSI=y
>  CONFIG_PCI_MVEBU=y
>  CONFIG_PCI_TEGRA=y
> @@ -132,6 +133,7 @@ CONFIG_MTD_CMDLINE_PARTS=y
>  CONFIG_MTD_BLOCK=y
>  CONFIG_MTD_M25P80=y
>  CONFIG_MTD_NAND=y
> +CONFIG_MTD_NAND_DAVINCI=y
>  CONFIG_MTD_SPI_NOR=y
>  CONFIG_MTD_UBI=y
>  CONFIG_BLK_DEV_LOOP=y
> @@ -220,6 +222,7 @@ CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
>  CONFIG_SERIAL_ST_ASC=y
>  CONFIG_SERIAL_ST_ASC_CONSOLE=y
>  CONFIG_I2C_CHARDEV=y
> +CONFIG_I2C_DAVINCI=y
>  CONFIG_I2C_MUX=y
>  CONFIG_I2C_MUX_PCA954x=y
>  CONFIG_I2C_MUX_PINCTRL=y
> @@ -233,6 +236,7 @@ CONFIG_I2C_TEGRA=y
>  CONFIG_I2C_ST=y
>  CONFIG_SPI=y
>  CONFIG_I2C_XILINX=y
> +CONFIG_SPI_DAVINCI=y
>  CONFIG_SPI_CADENCE=y
>  CONFIG_SPI_OMAP24XX=y
>  CONFIG_SPI_ORION=y
> @@ -251,23 +255,27 @@ CONFIG_PINCTRL_APQ8084=y
>  CONFIG_GPIO_SYSFS=y
>  CONFIG_GPIO_GENERIC_PLATFORM=y
>  CONFIG_GPIO_DWAPB=y
> +CONFIG_GPIO_DAVINCI=y
>  CONFIG_GPIO_XILINX=y
>  CONFIG_GPIO_ZYNQ=y
>  CONFIG_GPIO_PCA953X=y
>  CONFIG_GPIO_PCA953X_IRQ=y
>  CONFIG_GPIO_TWL4030=y
>  CONFIG_GPIO_PALMAS=y
> +CONFIG_GPIO_SYSCON=y
>  CONFIG_GPIO_TPS6586X=y
>  CONFIG_GPIO_TPS65910=y
>  CONFIG_BATTERY_SBS=y
>  CONFIG_CHARGER_TPS65090=y
>  CONFIG_POWER_RESET_AS3722=y
>  CONFIG_POWER_RESET_GPIO=y
> +CONFIG_POWER_RESET_KEYSTONE=y
>  CONFIG_POWER_RESET_SUN6I=y
>  CONFIG_SENSORS_LM90=y
>  CONFIG_SENSORS_LM95245=y
>  CONFIG_THERMAL=y
>  CONFIG_ARMADA_THERMAL=y
> +CONFIG_DAVINCI_WATCHDOG
>  CONFIG_ST_THERMAL_SYSCFG=y
>  CONFIG_ST_THERMAL_MEMMAP=y
>  CONFIG_WATCHDOG=y
> @@ -346,9 +354,11 @@ CONFIG_USB_OHCI_HCD=y
>  CONFIG_USB_OHCI_HCD_STI=y
>  CONFIG_USB_OHCI_HCD_PLATFORM=y
>  CONFIG_USB_STORAGE=y
> +CONFIG_USB_DWC3=y
>  CONFIG_USB_CHIPIDEA=y
>  CONFIG_USB_CHIPIDEA_HOST=y
>  CONFIG_AB8500_USB=y
> +CONFIG_KEYSTONE_USB_PHY=y
>  CONFIG_OMAP_USB3=y
>  CONFIG_SAMSUNG_USB2PHY=y
>  CONFIG_SAMSUNG_USB3PHY=y
> @@ -444,6 +454,7 @@ CONFIG_MSM_MMCC_8974=y
>  CONFIG_TEGRA_IOMMU_GART=y
>  CONFIG_TEGRA_IOMMU_SMMU=y
>  CONFIG_MEMORY=y
> +CONFIG_TI_AEMIF=y
>  CONFIG_IIO=y
>  CONFIG_XILINX_XADC=y
>  CONFIG_AK8975=y
> @@ -480,3 +491,4 @@ CONFIG_MAGIC_SYSRQ=y
>  CONFIG_LOCKUP_DETECTOR=y
>  CONFIG_CRYPTO_DEV_TEGRA_AES=y
>  CONFIG_CPUFREQ_DT=y
> +CONFIG_KEYSTONE_IRQ=y
> -- 
> 1.9.1
> 

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141229/5c6cd795/attachment.sig>
