From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 28 Sep 2012 00:10:49 -0400 (EDT)
Subject: [PATCH] ARM: ensure vm_struct has its phys_addr member filled in
In-Reply-To: <E1THM9W-0004mm-OY@rmk-PC.arm.linux.org.uk>
References: <E1THM9W-0004mm-OY@rmk-PC.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1209280010280.6667@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 27 Sep 2012, Russell King wrote:

> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
>  arch/arm/mm/ioremap.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
> index a8372b8..22ed380 100644
> --- a/arch/arm/mm/ioremap.c
> +++ b/arch/arm/mm/ioremap.c
> @@ -249,6 +249,7 @@ void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
>   	if (!area)
>   		return NULL;
>   	addr = (unsigned long)area->addr;
> +	area->phys_addr = __pfn_to_phys(pfn);
>  
>  #if !defined(CONFIG_SMP) && !defined(CONFIG_ARM_LPAE)
>  	if (DOMAIN_IO == 0 &&
> -- 
> 1.7.4.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
