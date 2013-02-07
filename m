From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 06 Feb 2013 17:07:31 -0700
Subject: [PATCH 02/14] mfd: ab8500: provide a irq_set_type() function
In-Reply-To: <1360093715-6348-3-git-send-email-linus.walleij@stericsson.com>
References: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
 <1360093715-6348-3-git-send-email-linus.walleij@stericsson.com>
Message-ID: <5112F043.6040700@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/2013 12:48 PM, Linus Walleij wrote:
> From: Lee Jones <lee.jones@linaro.org>
> 
> In the AB8500 IRQ mask and unmask functions, we rely on testing for
> IRQ_TYPE_EDGE_RISING and IRQ_TYPE_EDGE_FALLING interrupts to
> physically mask and unmask the correct interrupt lines. In order
> for us to do that, the trigger needs to be set in the associated
> flags. However, unless a irq_set_type() function pointer is passed
> when registering the IRQ chip, the IRQ subsystem will refuse to do
> it. For that reason, we're providing one.

> diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c

> +static int ab8500_irq_set_type(struct irq_data *data, unsigned int type)
> +{
> +	return 0;
> +}

I think patch 0 implied that only rising/falling edges can be detected,
not levels? If so, should that function validate that the requested type
can be supported?
