From: horms@verge.net.au (Simon Horman)
Date: Fri, 26 Apr 2013 09:50:12 +0900
Subject: [PATCH 11/21] irqdomain: export irq_domain_add_simple
In-Reply-To: <1366910944-3033663-12-git-send-email-arnd@arndb.de>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
 <1366910944-3033663-12-git-send-email-arnd@arndb.de>
Message-ID: <20130426005012.GB20070@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 25, 2013 at 07:28:54PM +0200, Arnd Bergmann wrote:
> All other irq_domain_add_* functions are exported already, and apparently
> this one got left out by mistake, which causes build errors for ARM
> allmodconfig kernels:
> 
> ERROR: "irq_domain_add_simple" [drivers/gpio/gpio-rcar.ko] undefined!
> ERROR: "irq_domain_add_simple" [drivers/gpio/gpio-em.ko] undefined!
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Magnus Damm <damm@opensource.se>

Acked-by: Simon Horman <horms+renesas@verge.net.au>

Grant, could consider taking this one?

> ---
>  kernel/irq/irqdomain.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index 059a280..c532c15 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -194,6 +194,7 @@ struct irq_domain *irq_domain_add_simple(struct device_node *of_node,
>  	/* A linear domain is the default */
>  	return irq_domain_add_linear(of_node, size, ops, host_data);
>  }
> +EXPORT_SYMBOL_GPL(irq_domain_add_simple);
>  
>  /**
>   * irq_domain_add_legacy() - Allocate and register a legacy revmap irq_domain.
> -- 
> 1.8.1.2
> 
