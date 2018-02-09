From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 9 Feb 2018 09:48:48 +0100
Subject: [PATCH] irqchip: Use %px to print pointer value
In-Reply-To: <20180209021031.20631-1-jaedon.shin@gmail.com>
References: <20180209021031.20631-1-jaedon.shin@gmail.com>
Message-ID: <CAMuHMdXOtrnMrNkuexHdpX+asaG1ADwmb5JWwAYYrvvvn0P8ZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jaedon,

On Fri, Feb 9, 2018 at 3:10 AM, Jaedon Shin <jaedon.shin@gmail.com> wrote:
> Since commit ad67b74d2469 ("printk: hash addresses printed with %p")
> pointers printed with %p are hashed. Use %px instead of %p to print
> pointer value.
>
> Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>

Thanks for your patch!

> --- a/drivers/irqchip/irq-bcm7038-l1.c
> +++ b/drivers/irqchip/irq-bcm7038-l1.c
> @@ -339,7 +339,7 @@ int __init bcm7038_l1_of_init(struct device_node *dn,
>                 goto out_unmap;
>         }
>
> -       pr_info("registered BCM7038 L1 intc (mem: 0x%p, IRQs: %d)\n",
> +       pr_info("registered BCM7038 L1 intc (mem: 0x%px, IRQs: %d)\n",
>                 intc->cpus[0]->map_base, IRQS_PER_WORD * intc->n_words);

I believe the printing of this value should just be removed.
Printing virtual addresses of mapped registers is usually not helpful, except
for an attacker.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
