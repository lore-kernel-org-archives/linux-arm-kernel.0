From: rabin@rab.in (Rabin Vincent)
Date: Sun, 3 Apr 2011 09:28:37 +0530
Subject: [PATCH] arm: nomadik: avoid assigning u32 to bool
In-Reply-To: <20110401235113.083787a7@absol.kitzblitz>
References: <20110401235113.083787a7@absol.kitzblitz>
Message-ID: <BANLkTinujPcSq86wjue+SGw5ZMiiLRaT_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 2, 2011 at 03:21, Nicolas Kaiser <nikai@nikai.net> wrote:
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

Why?  There are dozens of places in the kernel where this done, the code
generated should be the same, and it's pretty obvious what is being done
as it is.
