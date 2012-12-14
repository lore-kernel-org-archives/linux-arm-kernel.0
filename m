From: tony@atomide.com (Tony Lindgren)
Date: Fri, 14 Dec 2012 10:10:51 -0800
Subject: [PATCH 1/1] ARM: OMAP2+: enable devtmpfs and devtmpfs automount
In-Reply-To: <1353504411-19811-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1353504411-19811-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <20121214181051.GY4989@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Javier Martinez Canillas <javier.martinez@collabora.co.uk> [121121 05:29]:
> Since udev-182, udev no longer creates device nodes under /dev
> and this has to be managed by the kernel devtmpfs filesystem.
> 
> This means that a kernel built with the current OMAP2+ config
> will not boot on a system with a recent udev.
> 
> Also, it is good to have /dev automatically mounted since some
> non-initramfs based setups assumes this and don't manually mount it.

Thanks applying into omap-for-v3.8/fixes-for-merge-window.

Regards,

Tony
 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/configs/omap2plus_defconfig |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 6230304..6333e96 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -65,6 +65,8 @@ CONFIG_MAC80211_RC_PID=y
>  CONFIG_MAC80211_RC_DEFAULT_PID=y
>  CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  CONFIG_CONNECTOR=y
> +CONFIG_DEVTMPFS=y
> +CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_MTD=y
>  CONFIG_MTD_CMDLINE_PARTS=y
>  CONFIG_MTD_CHAR=y
> -- 
> 1.7.7.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
