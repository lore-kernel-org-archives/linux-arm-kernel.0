From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 6 Jun 2013 18:15:44 +0200
Subject: [PATCH v3 1/7] pcmcia: at91_cf: fix gpio_get_value in
 at91_cf_get_status
In-Reply-To: <cc6a02cb9d55ba52b48adca688fef362b8bea373.1370506678.git.nicolas.ferre@atmel.com>
References: <cover.1370506678.git.nicolas.ferre@atmel.com>
 <cc6a02cb9d55ba52b48adca688fef362b8bea373.1370506678.git.nicolas.ferre@atmel.com>
Message-ID: <20130606161544.GN23653@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:24 Thu 06 Jun     , Nicolas Ferre wrote:
> From: Joachim Eastwood <manabian@gmail.com>
> 
> Commit 80af9e6d (pcmcia at91_cf: fix raw gpio number usage) forgot
> to change the parameter in gpio_get_value after adding gpio
> validation.

this is a fix so should for in stable tree too

since #3.4

Best Regards,
J.
> 
> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/pcmcia/at91_cf.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pcmcia/at91_cf.c b/drivers/pcmcia/at91_cf.c
> index 01463c7..1b2c631 100644
> --- a/drivers/pcmcia/at91_cf.c
> +++ b/drivers/pcmcia/at91_cf.c
> @@ -100,9 +100,9 @@ static int at91_cf_get_status(struct pcmcia_socket *s, u_int *sp)
>  		int vcc	= gpio_is_valid(cf->board->vcc_pin);
>  
>  		*sp = SS_DETECT | SS_3VCARD;
> -		if (!rdy || gpio_get_value(rdy))
> +		if (!rdy || gpio_get_value(cf->board->irq_pin))
>  			*sp |= SS_READY;
> -		if (!vcc || gpio_get_value(vcc))
> +		if (!vcc || gpio_get_value(cf->board->vcc_pin))
>  			*sp |= SS_POWERON;
>  	} else
>  		*sp = 0;
> -- 
> 1.8.2.2
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
