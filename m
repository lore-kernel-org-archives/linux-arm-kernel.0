From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Wed, 27 Aug 2014 18:10:14 +0200
Subject: [PATCH 1/2] ARM: exynos_defconfig: Enable Control Groups support
In-Reply-To: <1409137341-20516-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1409137341-20516-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <53FE02E6.3030302@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 27.08.2014 13:02, schrieb Javier Martinez Canillas:
> systemd needs control groups support to be enabled in the
> kernel so let's enable it by default since is quite likely
> that a user-space with systemd will be used.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/configs/exynos_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 676c744..590abde 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -1,6 +1,7 @@
>  CONFIG_SYSVIPC=y
>  CONFIG_NO_HZ=y
>  CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_CGROUPS=y
>  CONFIG_BLK_DEV_INITRD=y
>  CONFIG_KALLSYMS_ALL=y
>  CONFIG_MODULES=y

CONFIG_FHANDLE=y is also needed for systemd to get a serial console.
multi_v7 has that already.

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
