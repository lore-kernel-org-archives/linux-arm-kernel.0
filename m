From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 30 Dec 2010 10:31:56 +0100
Subject: [PATCH v3 2/8] arm: plat-mxc: add full parameter macro to
	define gpio port
In-Reply-To: <1293684968-7338-2-git-send-email-richard.zhao@freescale.com>
References: <1293684968-7338-1-git-send-email-richard.zhao@freescale.com>
	<1293684968-7338-2-git-send-email-richard.zhao@freescale.com>
Message-ID: <20101230093156.GP14221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 30, 2010 at 12:56:03PM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/plat-mxc/gpio.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
> index 93a8d93..dd4f813 100644
> --- a/arch/arm/plat-mxc/gpio.c
> +++ b/arch/arm/plat-mxc/gpio.c
> @@ -350,15 +350,18 @@ int __init mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
>  	return 0;
>  }
>  
> -#define DEFINE_IMX_GPIO_PORT_IRQ(soc, _id, _hwid, _irq)			\
> +#define DEFINE_IMX_GPIO_PORT_IRQ_HIGH(soc, _id, _hwid, _irq, _irq_high)	\
>  	{								\
>  		.chip.label = "gpio-" #_id,				\
>  		.irq = _irq,						\
> +		.irq_high = _irq_high,					\
>  		.base = soc ## _IO_ADDRESS(				\
>  				soc ## _GPIO ## _hwid ## _BASE_ADDR),	\
>  		.virtual_irq_start = MXC_GPIO_IRQ_START + (_id) * 32,	\
>  	}
>  
> +#define DEFINE_IMX_GPIO_PORT_IRQ(soc, _id, _hwid, _irq)			\
> +	DEFINE_IMX_GPIO_PORT_IRQ_HIGH(soc, _id, _hwid, _irq, 0)
>  #define DEFINE_IMX_GPIO_PORT(soc, _id, _hwid)				\
>  	DEFINE_IMX_GPIO_PORT_IRQ(soc, _id, _hwid, 0)
>  
> -- 
> 1.6.3.3
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
