From: grant.likely@secretlab.ca (Grant Likely)
Date: Fri, 30 Nov 2012 11:13:05 +0000
Subject: [PATCH] gpio: pl061: remove old comment
In-Reply-To: <9726894cfe3ff11c9f3a95e436ae386637eba98f.1353577495.git.baruch@tkos.co.il>
References: <9726894cfe3ff11c9f3a95e436ae386637eba98f.1353577495.git.baruch@tkos.co.il>
Message-ID: <20121130111305.E92EC3E14C4@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 22 Nov 2012 11:46:14 +0200, Baruch Siach <baruch@tkos.co.il> wrote:
> Since 3ab524754 (gpio: pl061: convert to use generic irq chip) we only have one
> spinlock in struct pl061_gpio.
> 
> Cc: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Applied, thanks.

g.

> ---
>  drivers/gpio/gpio-pl061.c |    7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-pl061.c b/drivers/gpio/gpio-pl061.c
> index b4b5da4..2b2e73c 100644
> --- a/drivers/gpio/gpio-pl061.c
> +++ b/drivers/gpio/gpio-pl061.c
> @@ -48,12 +48,7 @@ struct pl061_context_save_regs {
>  #endif
>  
>  struct pl061_gpio {
> -	/* Each of the two spinlocks protects a different set of hardware
> -	 * regiters and data structurs. This decouples the code of the IRQ from
> -	 * the GPIO code. This also makes the case of a GPIO routine call from
> -	 * the IRQ code simpler.
> -	 */
> -	spinlock_t		lock;		/* GPIO registers */
> +	spinlock_t		lock;
>  
>  	void __iomem		*base;
>  	int			irq_base;
> -- 
> 1.7.10.4
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
