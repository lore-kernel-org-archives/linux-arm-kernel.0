From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 27 Jan 2010 11:41:08 +0100
Subject: [PATCH v4 4/8] ARM: S5PV210: Update Kconfig and Makefiles
In-Reply-To: <1264586648-22963-1-git-send-email-kgene.kim@samsung.com>
References: <1264586648-22963-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <002c01ca9f3d$40538fc0$c0faaf40$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, January 27, 2010 11:04 AM Kukjin Kim wrote:

> Updates arch/arm Kconfig and Makefile for building the S5PV210 support.
> Also modifies the plat-s5p Kconfig file to include the support for plat-s5p
> for S5PV210.
> 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/Kconfig          |   12 +++++++++++-
>  arch/arm/Makefile         |    1 +
>  arch/arm/mm/Kconfig       |    2 +-
>  arch/arm/plat-s5p/Kconfig |    2 +-
>  4 files changed, 14 insertions(+), 3 deletions(-)

snip

> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index baf6384..91617f7 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -779,5 +779,5 @@ config CACHE_XSC3L2
> 
>  config ARM_L1_CACHE_SHIFT
>  	int
> -	default 6 if ARCH_OMAP3 || ARCH_S5PC1XX
> +	default 6 if ARCH_OMAP3 || ARCH_S5PC1XX || ARCH_S5PV210
>  	default 5

This should be a separate patch, because it modifies other kernel subsystem
(ARM MM) than the others (Samsung sub-tree).

Anyway, what about introducing new Kconfig option
PLAT_SAMSUNG_HAS_6_L1_CACHE_SHIFT?

Then we can depend ARM_L1_CACHE_SHIFT = 6 on it. The option is would be
selected by ARCH_S5PC1XX and ARCH_S5PV210. There might be other Samsung chips
in the future that would require this and this way it can be properly handled
inside Samsung plat Kconfigs.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
