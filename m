From: horms@verge.net.au (Simon Horman)
Date: Mon, 6 Jan 2014 16:59:51 +0900
Subject: [PATCH 1/4] ARM: shmobile: Disable /sbin/hotplug fork-bomb in
 defconfigs
In-Reply-To: <1388764128-27686-1-git-send-email-geert@linux-m68k.org>
References: <1388764128-27686-1-git-send-email-geert@linux-m68k.org>
Message-ID: <20140106075951.GP24653@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 03, 2014 at 04:48:45PM +0100, Geert Uytterhoeven wrote:
> From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> 
> Cfr. commit 7934779a69f1184f29d786b89e77dd14519bd226 ("Driver-Core: disable
> /sbin/hotplug by default").

Could you please flesh out this changelog a bit, perhaps
by including the body of the changelog of
7934779a69f1184f29d786b89e77dd14519bd226.

> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
> ---
>  arch/arm/configs/ape6evm_defconfig         |    1 -
>  arch/arm/configs/armadillo800eva_defconfig |    1 -
>  arch/arm/configs/bockw_defconfig           |    1 -
>  arch/arm/configs/genmai_defconfig          |    1 -
>  arch/arm/configs/koelsch_defconfig         |    1 -
>  arch/arm/configs/kzm9d_defconfig           |    1 -
>  arch/arm/configs/kzm9g_defconfig           |    1 -
>  arch/arm/configs/lager_defconfig           |    1 -
>  arch/arm/configs/mackerel_defconfig        |    1 -
>  arch/arm/configs/marzen_defconfig          |    1 -
>  10 files changed, 10 deletions(-)
> 
> diff --git a/arch/arm/configs/ape6evm_defconfig b/arch/arm/configs/ape6evm_defconfig
> index cb26c62dc722..c13f560f07db 100644
> --- a/arch/arm/configs/ape6evm_defconfig
> +++ b/arch/arm/configs/ape6evm_defconfig
> @@ -47,7 +47,6 @@ CONFIG_IP_PNP_DHCP=y
>  # CONFIG_INET_LRO is not set
>  # CONFIG_IPV6_SIT is not set
>  CONFIG_NETFILTER=y
> -CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  # CONFIG_FW_LOADER_USER_HELPER is not set
>  CONFIG_NETDEVICES=y
>  # CONFIG_NET_CADENCE is not set
> diff --git a/arch/arm/configs/armadillo800eva_defconfig b/arch/arm/configs/armadillo800eva_defconfig
> index 9287a62de830..1edc2ce32063 100644
> --- a/arch/arm/configs/armadillo800eva_defconfig
> +++ b/arch/arm/configs/armadillo800eva_defconfig
> @@ -57,7 +57,6 @@ CONFIG_IP_PNP_DHCP=y
>  # CONFIG_INET_DIAG is not set
>  # CONFIG_IPV6 is not set
>  # CONFIG_WIRELESS is not set
> -CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  CONFIG_SCSI=y
>  CONFIG_BLK_DEV_SD=y
>  CONFIG_MD=y
> diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
> index 80cff50beb34..564eab338f02 100644
> --- a/arch/arm/configs/bockw_defconfig
> +++ b/arch/arm/configs/bockw_defconfig
> @@ -43,7 +43,6 @@ CONFIG_IP_PNP_DHCP=y
>  # CONFIG_INET_LRO is not set
>  # CONFIG_INET_DIAG is not set
>  # CONFIG_IPV6 is not set
> -CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  # CONFIG_STANDALONE is not set
>  # CONFIG_PREVENT_FIRMWARE_BUILD is not set
>  # CONFIG_FW_LOADER is not set
> diff --git a/arch/arm/configs/genmai_defconfig b/arch/arm/configs/genmai_defconfig
> index aa0b704f48af..5fa44cb6e915 100644
> --- a/arch/arm/configs/genmai_defconfig
> +++ b/arch/arm/configs/genmai_defconfig
> @@ -49,7 +49,6 @@ CONFIG_IP_PNP_DHCP=y
>  # CONFIG_INET_DIAG is not set
>  # CONFIG_IPV6 is not set
>  # CONFIG_WIRELESS is not set
> -CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  CONFIG_NETDEVICES=y
>  # CONFIG_NET_CORE is not set
>  # CONFIG_NET_VENDOR_ARC is not set
> diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
> index e248f49d5549..c8ebeb1f0497 100644
> --- a/arch/arm/configs/koelsch_defconfig
> +++ b/arch/arm/configs/koelsch_defconfig
> @@ -35,7 +35,6 @@ CONFIG_UNIX=y
>  CONFIG_INET=y
>  CONFIG_IP_PNP=y
>  CONFIG_IP_PNP_DHCP=y
> -CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  CONFIG_NETDEVICES=y
>  # CONFIG_NET_VENDOR_ARC is not set
>  # CONFIG_NET_CADENCE is not set
> diff --git a/arch/arm/configs/kzm9d_defconfig b/arch/arm/configs/kzm9d_defconfig
> index e42ce3756af3..3ee3858939d9 100644
> --- a/arch/arm/configs/kzm9d_defconfig
> +++ b/arch/arm/configs/kzm9d_defconfig
> @@ -49,7 +49,6 @@ CONFIG_IP_PNP_DHCP=y
>  # CONFIG_INET_DIAG is not set
>  # CONFIG_IPV6 is not set
>  # CONFIG_WIRELESS is not set
> -CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  # CONFIG_BLK_DEV is not set
>  CONFIG_NETDEVICES=y
>  # CONFIG_NET_VENDOR_BROADCOM is not set
> diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
> index 9934dbc23d64..800faff9df1d 100644
> --- a/arch/arm/configs/kzm9g_defconfig
> +++ b/arch/arm/configs/kzm9g_defconfig
> @@ -59,7 +59,6 @@ CONFIG_IP_PNP_DHCP=y
>  CONFIG_IRDA=y
>  CONFIG_SH_IRDA=y
>  # CONFIG_WIRELESS is not set
> -CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  CONFIG_SCSI=y
>  CONFIG_BLK_DEV_SD=y
>  CONFIG_NETDEVICES=y
> diff --git a/arch/arm/configs/lager_defconfig b/arch/arm/configs/lager_defconfig
> index 883443f8f4f3..da8fa5e8719b 100644
> --- a/arch/arm/configs/lager_defconfig
> +++ b/arch/arm/configs/lager_defconfig
> @@ -48,7 +48,6 @@ CONFIG_IP_PNP_DHCP=y
>  # CONFIG_INET_DIAG is not set
>  # CONFIG_IPV6 is not set
>  # CONFIG_WIRELESS is not set
> -CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  CONFIG_NETDEVICES=y
>  # CONFIG_NET_CORE is not set
>  # CONFIG_NET_VENDOR_ARC is not set
> diff --git a/arch/arm/configs/mackerel_defconfig b/arch/arm/configs/mackerel_defconfig
> index a61e1653fc5e..9d406022d72b 100644
> --- a/arch/arm/configs/mackerel_defconfig
> +++ b/arch/arm/configs/mackerel_defconfig
> @@ -41,7 +41,6 @@ CONFIG_IP_PNP_DHCP=y
>  # CONFIG_INET_XFRM_MODE_BEET is not set
>  # CONFIG_IPV6 is not set
>  # CONFIG_WIRELESS is not set
> -CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  # CONFIG_FIRMWARE_IN_KERNEL is not set
>  CONFIG_MTD=y
>  CONFIG_MTD_CONCAT=y
> diff --git a/arch/arm/configs/marzen_defconfig b/arch/arm/configs/marzen_defconfig
> index f21bd405cc2a..fe3d8f7c0a2c 100644
> --- a/arch/arm/configs/marzen_defconfig
> +++ b/arch/arm/configs/marzen_defconfig
> @@ -42,7 +42,6 @@ CONFIG_IP_PNP=y
>  CONFIG_IP_PNP_DHCP=y
>  # CONFIG_IPV6 is not set
>  # CONFIG_WIRELESS is not set
> -CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
>  # CONFIG_STANDALONE is not set
>  # CONFIG_PREVENT_FIRMWARE_BUILD is not set
>  # CONFIG_FW_LOADER is not set
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
