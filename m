From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 25 Sep 2012 16:00:26 +0800
Subject: [PATCH] ARM: mxs_defconfig: Improve USB related support
In-Reply-To: <1348541611-15717-1-git-send-email-festevam@gmail.com>
References: <1348541611-15717-1-git-send-email-festevam@gmail.com>
Message-ID: <20120925080024.GM27291@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2012 at 11:53:31PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Select the following USB related options:
> 
> - USB Video Class (webcam)
> - USB Ethernet adapter
> - Native language support (needed for mounting USB pen drives, for example)

I do not want defconfig/zImage get bloated by these features for
particular applications.  We should try to maintain a minimum feature
set that takes care of mxs building and testing coverage.  Anything
more than that can just be selected by custom configuration.

Shawn

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/configs/mxs_defconfig |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
> index 048aaca..da51790 100644
> --- a/arch/arm/configs/mxs_defconfig
> +++ b/arch/arm/configs/mxs_defconfig
> @@ -61,6 +61,8 @@ CONFIG_MTD_NAND_GPMI_NAND=y
>  CONFIG_NETDEVICES=y
>  CONFIG_NET_ETHERNET=y
>  CONFIG_ENC28J60=y
> +CONFIG_USB_USBNET=y
> +CONFIG_USB_NET_SMSC95XX=y
>  # CONFIG_NETDEV_1000 is not set
>  # CONFIG_NETDEV_10000 is not set
>  # CONFIG_WLAN is not set
> @@ -106,6 +108,10 @@ CONFIG_SND_SOC_I2C_AND_SPI=y
>  CONFIG_SND_SOC_SGTL5000=y
>  CONFIG_REGULATOR=y
>  CONFIG_REGULATOR_FIXED_VOLTAGE=y
> +CONFIG_MEDIA_SUPPORT=y
> +CONFIG_MEDIA_CAMERA_SUPPORT=y
> +CONFIG_MEDIA_USB_SUPPORT=y
> +CONFIG_USB_VIDEO_CLASS=y
>  CONFIG_FB=y
>  CONFIG_FB_MXS=y
>  CONFIG_BACKLIGHT_LCD_SUPPORT=y
> @@ -158,6 +164,10 @@ CONFIG_NFS_V3=y
>  CONFIG_NFS_V3_ACL=y
>  CONFIG_NFS_V4=y
>  CONFIG_ROOT_NFS=y
> +CONFIG_NLS_CODEPAGE_437=y
> +CONFIG_NLS_CODEPAGE_850=y
> +CONFIG_NLS_ISO8859_1=y
> +CONFIG_NLS_ISO8859_15=y
>  CONFIG_PRINTK_TIME=y
>  CONFIG_FRAME_WARN=2048
>  CONFIG_MAGIC_SYSRQ=y
> -- 
> 1.7.9.5
> 
