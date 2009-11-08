From: ben-linux@fluff.org (Ben Dooks)
Date: Sun, 8 Nov 2009 23:58:47 +0000
Subject: [PATCH 01/17] ARM: MM: use 64bytes of L1 cache on plat S5PC1xx
In-Reply-To: <1255421482-26455-2-git-send-email-m.szyprowski@samsung.com>
References: <1255421482-26455-1-git-send-email-m.szyprowski@samsung.com>
	<1255421482-26455-2-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20091108235847.GE4808@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 13, 2009 at 10:11:06AM +0200, Marek Szyprowski wrote:
> Samsung S5PC1xx SoCs are Coretex8 based, so use 64 bytes of L1 cache
> line instead of the default 32 bytes.
> 
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

This worries me, either this patch was from 'Kyungmin Park' and thus
should have either been sent by, or have an 'From:' line at the top
of the description. If this has been appraised by Kyungmin then the
signoff should either be after Marek's (as this is the sender) or be
something other than a signed-off-by.

> ---
>  arch/arm/mm/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
> index e993140..9cf7706 100644
> --- a/arch/arm/mm/Kconfig
> +++ b/arch/arm/mm/Kconfig
> @@ -777,5 +777,5 @@ config CACHE_XSC3L2
>  
>  config ARM_L1_CACHE_SHIFT
>  	int
> -	default 6 if ARCH_OMAP3
> +	default 6 if ARCH_OMAP3 || ARCH_S5PC1XX
>  	default 5
> -- 
> 1.6.4
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
