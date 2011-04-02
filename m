From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 2 Apr 2011 23:02:49 +0200
Subject: [PATCH] arm: nomadik: avoid assigning u32 to bool
In-Reply-To: <20110401235113.083787a7@absol.kitzblitz>
References: <20110401235113.083787a7@absol.kitzblitz>
Message-ID: <BANLkTikAG4diz-A6qfFx4cODvyR0c4oQ6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/1 Nicolas Kaiser <nikai@nikai.net>:

> Avoid assigning u32 to the bool 'enabled'.
>
> Signed-off-by: Nicolas Kaiser <nikai@nikai.net>
> ---
> ?arch/arm/plat-nomadik/gpio.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/plat-nomadik/gpio.c b/arch/arm/plat-nomadik/gpio.c
> index f49748e..8b722f7 100644
> --- a/arch/arm/plat-nomadik/gpio.c
> +++ b/arch/arm/plat-nomadik/gpio.c
> @@ -636,7 +636,7 @@ static int nmk_gpio_irq_set_type(struct irq_data *d, unsigned int type)
> ? ? ? ?if (type & IRQ_TYPE_LEVEL_LOW)
> ? ? ? ? ? ? ? ?return -EINVAL;
>
> - ? ? ? enabled = nmk_chip->enabled & bitmask;
> + ? ? ? enabled = !!(nmk_chip->enabled & bitmask);

I've learned to live this way of casting stuff into boolean,
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Linus Walleij
