From: public_timo.s@silentcreek.de (Timo Sigurdsson)
Date: Fri, 20 Nov 2015 02:55:17 +0100
Subject: [PATCH v2 1/3] ARM: sunxi: Re-enable SID driver in sunxi_defconfig
In-Reply-To: <1447983979-12751-1-git-send-email-public_timo.s@silentcreek.de>
References: <1447724578-4786-1-git-send-email-public_timo.s@silentcreek.de>
 <1447983979-12751-1-git-send-email-public_timo.s@silentcreek.de>
Message-ID: <1447984517.1404.30.camel@silentcreek.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, I probably shouldn't send patches at an hour I should rather be
sleeping... As a result, I forgot to add the patch history.

Here it is:

Changes in v2:
- Move the extra cleanup work for sunxi_defconfig to a separate patch
- Add another patch to meet the dependencies of
  CONFIG_KEYBOARD_SUN4I_LRADC and not have it removed while cleaning up


Good night,

Timo

Am Freitag, den 20.11.2015, 02:46 +0100 schrieb Timo Sigurdsson:
> Commit 3d0b16a66c8a ("nvmem: sunxi: Move the SID driver to the nvmem
> framework") moved the the sunxi SID driver to a new framework, but left
> sunxi_defconfig with the deprecated config symbol EEPROM_SUNXI_SID
> instead of the new symbol NVMEM_SUNXI_SID. Hence, re-enable the driver
> in sunxi_defconfig.
> 
> Signed-off-by: Timo Sigurdsson <public_timo.s@silentcreek.de>
> ---
>  arch/arm/configs/sunxi_defconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
> index 3c36e16..0bbc2ee 100644
> --- a/arch/arm/configs/sunxi_defconfig
> +++ b/arch/arm/configs/sunxi_defconfig
> @@ -37,7 +37,6 @@ CONFIG_CAN_SUN4I=y
>  # CONFIG_WIRELESS is not set
>  CONFIG_DEVTMPFS=y
>  CONFIG_DEVTMPFS_MOUNT=y
> -CONFIG_EEPROM_SUNXI_SID=y
>  CONFIG_BLK_DEV_SD=y
>  CONFIG_ATA=y
>  CONFIG_AHCI_SUNXI=y
> @@ -123,6 +122,8 @@ CONFIG_PWM=y
>  CONFIG_PWM_SUN4I=y
>  CONFIG_PHY_SUN4I_USB=y
>  CONFIG_PHY_SUN9I_USB=y
> +CONFIG_NVMEM=y
> +CONFIG_NVMEM_SUNXI_SID=y
>  CONFIG_EXT4_FS=y
>  CONFIG_VFAT_FS=y
>  CONFIG_TMPFS=y
