From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 12 Sep 2012 18:16:09 +0200
Subject: [PATCH] of: specify initrd location using 64-bit
In-Reply-To: <1347465937-7056-1-git-send-email-cyril@ti.com>
References: <1347465937-7056-1-git-send-email-cyril@ti.com>
Message-ID: <CAMuHMdUuQzD0bq8PifBea2-0Pk7RhmPA0-GAFprsk+vMxMGjGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 6:05 PM, Cyril Chemparathy <cyril@ti.com> wrote:
> On some PAE architectures, the entire range of physical memory could reside
> outside the 32-bit limit.  These systems need the ability to specify the
> initrd location using 64-bit numbers.
>
> This patch globally modifies the early_init_dt_setup_initrd_arch() function to
> use 64-bit numbers instead of the current unsigned long.

> -void __init early_init_dt_setup_initrd_arch(unsigned long start, unsigned long end)
> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)

Why not phys_addr_t?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
