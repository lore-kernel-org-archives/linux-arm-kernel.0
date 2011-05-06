From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Fri, 6 May 2011 11:13:50 +0200
Subject: [RFC/PATCH] OMAP PM: remove OMAP_PM_NONE config option
In-Reply-To: <1304673087-24643-1-git-send-email-j-pihet@ti.com>
References: <1304673087-24643-1-git-send-email-j-pihet@ti.com>
Message-ID: <BANLkTi=YJ8+7Nv=0wbem_CqytRMiKQjgJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Please note that this code is based on khilman's for_2.6.40/pm-cleanup branch.

Jean

On Fri, May 6, 2011 at 11:11 AM, Jean Pihet <jean.pihet@newoldbits.com> wrote:
> The current code base is not linking with the OMAP_PM_NONE
> option set.
> Since the option OMAP_PM_NOOP provides a no-op/debug layer,
> OMAP_PM_NONE can be removed.
> OMAP_PM_NOOP is enabled by default by Kconfig.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
> ?arch/arm/plat-omap/Kconfig ? ? ? ? ? ? ? ?| ? ?3 ---
> ?arch/arm/plat-omap/include/plat/omap-pm.h | ? ?8 --------
> ?2 files changed, 0 insertions(+), 11 deletions(-)
>
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index cd5f993..16e3293 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -209,9 +209,6 @@ choice
> ? ? ? ?depends on ARCH_OMAP
> ? ? ? ?default OMAP_PM_NOOP
>
> -config OMAP_PM_NONE
> - ? ? ? bool "No PM layer"
> -
> ?config OMAP_PM_NOOP
> ? ? ? ?bool "No-op/debug PM layer"
>
> diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/plat-omap/include/plat/omap-pm.h
> index c0a7520..0840df8 100644
> --- a/arch/arm/plat-omap/include/plat/omap-pm.h
> +++ b/arch/arm/plat-omap/include/plat/omap-pm.h
> @@ -40,11 +40,7 @@
> ?* framework starts. ?The "_if_" is to avoid name collisions with the
> ?* PM idle-loop code.
> ?*/
> -#ifdef CONFIG_OMAP_PM_NONE
> -#define omap_pm_if_early_init() 0
> -#else
> ?int __init omap_pm_if_early_init(void);
> -#endif
>
> ?/**
> ?* omap_pm_if_init - OMAP PM init code called after clock fw init
> @@ -52,11 +48,7 @@ int __init omap_pm_if_early_init(void);
> ?* The main initialization code. ?OPP tables are passed in here. ?The
> ?* "_if_" is to avoid name collisions with the PM idle-loop code.
> ?*/
> -#ifdef CONFIG_OMAP_PM_NONE
> -#define omap_pm_if_init() 0
> -#else
> ?int __init omap_pm_if_init(void);
> -#endif
>
> ?/**
> ?* omap_pm_if_exit - OMAP PM exit code
> --
> 1.7.1
>
>
