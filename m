From: eric@anholt.net (Eric Anholt)
Date: Wed, 12 Jul 2017 12:13:16 -0700
Subject: [PATCH] pinctrl: bcm2835: constify gpio_chip structure
In-Reply-To: <20170711180339.GA17806@embeddedgus>
References: <20170711180339.GA17806@embeddedgus>
Message-ID: <877ezdh3jn.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Gustavo A. R. Silva" <garsilva@embeddedor.com> writes:

> This structure is only used to copy into other structure, so declare
> it as const.
>
> This issue was detected using Coccinelle and the following semantic patch:

Acked-by: Eric Anholt <eric@anholt.net>

> ---
>  drivers/pinctrl/bcm/pinctrl-bcm2835.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
> index 2308831..7203f35 100644
> --- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
> +++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
> @@ -353,7 +353,7 @@ static int bcm2835_gpio_direction_output(struct gpio_chip *chip,
>  	return pinctrl_gpio_direction_output(chip->base + offset);
>  }
>  
> -static struct gpio_chip bcm2835_gpio_chip = {
> +static const struct gpio_chip bcm2835_gpio_chip = {
>  	.label = MODULE_NAME,
>  	.owner = THIS_MODULE,
>  	.request = gpiochip_generic_request,
> -- 
> 2.5.0
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170712/1e036ba0/attachment.sig>
