From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 19 Jul 2011 16:38:37 +0400
Subject: [PATCH] gpio/mxc/mxs: fix build error introduced by the reanming
	of irq_gc_ack()
In-Reply-To: <1311046444-25423-1-git-send-email-shawn.guo@linaro.org>
References: <1311046444-25423-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <4E257ACD.6080608@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 19-07-2011 7:34, Shawn Guo wrote:

> The following commit renames irq_gc_ack() to irq_gc_ack_set_bit(),
> and makes gpio-mxc and gpio-mxs fail to build.

>    659fb32d1b67476f4ade25e9ea0e2642a5b9c4b5
>    genirq: replace irq_gc_ack() with {set,clr}_bit variants (fwd)

> Signed-off-by: Shawn Guo<shawn.guo@linaro.org>
> ---
> The build error is being seen on linux-next.

>   drivers/gpio/gpio-mxc.c |    2 +-
>   drivers/gpio/gpio-mxs.c |    2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

> diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
> index 89fda58..4a46fbe 100644
> --- a/drivers/gpio/gpio-mxc.c
> +++ b/drivers/gpio/gpio-mxc.c
> @@ -297,7 +297,7 @@ static void __init mxc_gpio_init_gc(struct mxc_gpio_port *port)
>   	gc->private = port;
>
>   	ct = gc->chip_types;
> -	ct->chip.irq_ack = irq_gc_ack,
> +	ct->chip.irq_ack = irq_gc_ack_set_bit,

    There should be semicolon rathern than comma at the end.

>   	ct->chip.irq_mask = irq_gc_mask_clr_bit;
>   	ct->chip.irq_unmask = irq_gc_mask_set_bit;
>   	ct->chip.irq_set_type = gpio_set_irq_type;
> diff --git a/drivers/gpio/gpio-mxs.c b/drivers/gpio/gpio-mxs.c
> index d8cafba..88f8506 100644
> --- a/drivers/gpio/gpio-mxs.c
> +++ b/drivers/gpio/gpio-mxs.c
> @@ -156,7 +156,7 @@ static void __init mxs_gpio_init_gc(struct mxs_gpio_port *port)
>   	gc->private = port;
>
>   	ct = gc->chip_types;
> -	ct->chip.irq_ack = irq_gc_ack,
> +	ct->chip.irq_ack = irq_gc_ack_set_bit,

    Same here.

WBR, Sergei
