From: ben-linux@fluff.org (Ben Dooks)
Date: Fri, 13 Nov 2009 23:19:03 +0000
Subject: [PATCH 01/18] ARM: MM: use 64bytes of L1 cache on plat S5PC1xx
In-Reply-To: <1258014122-18185-2-git-send-email-m.szyprowski@samsung.com>
References: <1258014122-18185-1-git-send-email-m.szyprowski@samsung.com>
	<1258014122-18185-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20091113231903.GO4808@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2009 at 09:21:45AM +0100, Marek Szyprowski wrote:
> From: Kyungmin Park <kyungmin.park@samsung.com>
> 
> From: Kyungmin Park <kyungmin.park@samsung.com>

This one i'll keep out of the series, as it either needs to go to Russell's
patch tracker on be on a branch for Russell to merge into the main arm
tree.
 
> Samsung S5PC1xx SoCs are Coretex8 based, so use 64 bytes of L1 cache
> line instead of the default 32 bytes.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  arch/arm/mm/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index 9264d81..7b7d4c3 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -774,5 +774,5 @@ config CACHE_XSC3L2
>  
>  config ARM_L1_CACHE_SHIFT
>  	int
> -	default 6 if ARCH_OMAP3
> +	default 6 if ARCH_OMAP3 || ARCH_S5PC1XX
>  	default 5
> -- 
> 1.6.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
