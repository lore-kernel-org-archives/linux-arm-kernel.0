From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 26 Feb 2014 14:45:19 +0000
Subject: [PATCH] ARM: XEN depends on having a MMU
In-Reply-To: <1393425046-23317-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1393425046-23317-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <alpine.DEB.2.02.1402261445020.31489@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 26 Feb 2014, Uwe Kleine-K?nig wrote:
> arch/arm/xen/enlighten.c (and maybe others) use MMU-specific functions
> like pte_mkspecial which are only available on MMU builds. So let XEN
> depend on MMU.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


>  arch/arm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index e25419817791..1eb3a250210a 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1903,6 +1903,7 @@ config XEN
>  	depends on ARM && AEABI && OF
>  	depends on CPU_V7 && !CPU_V6
>  	depends on !GENERIC_ATOMIC64
> +	depends on MMU
>  	select ARM_PSCI
>  	select SWIOTLB_XEN
>  	select ARCH_DMA_ADDR_T_64BIT
> -- 
> 1.8.5.3
> 
