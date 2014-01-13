From: horms@verge.net.au (Simon Horman)
Date: Mon, 13 Jan 2014 09:38:12 +0900
Subject: [PATCH] ARM: shmobile: koelsch: Enable DEVTMPFS_MOUNT in defconfig
In-Reply-To: <1389525349-3722-1-git-send-email-geert@linux-m68k.org>
References: <1389525349-3722-1-git-send-email-geert@linux-m68k.org>
Message-ID: <20140113003811.GI15296@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 12, 2014 at 12:15:49PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> Without this, a Debian jessie nfsroot hangs early in the boot process.

If this is really necessary for Jessie to boot then I think
we should enabled it in all shmobile defconfigs.

> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> ---
>  arch/arm/configs/koelsch_defconfig |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
> index 8f283f725a12..7c06fbac21a7 100644
> --- a/arch/arm/configs/koelsch_defconfig
> +++ b/arch/arm/configs/koelsch_defconfig
> @@ -36,6 +36,8 @@ CONFIG_UNIX=y
>  CONFIG_INET=y
>  CONFIG_IP_PNP=y
>  CONFIG_IP_PNP_DHCP=y
> +CONFIG_DEVTMPFS=y
> +CONFIG_DEVTMPFS_MOUNT=y
>  CONFIG_MTD=y
>  CONFIG_MTD_M25P80=y
>  CONFIG_NETDEVICES=y
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
