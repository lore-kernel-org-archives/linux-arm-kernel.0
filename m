From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 2 Mar 2015 18:22:31 +0100
Subject: [PATCH 05/10] clkdev: add clkdev_create() helper
In-Reply-To: <E1YSTnW-0001Jk-Tm@rmk-PC.arm.linux.org.uk>
References: <20150302170538.GQ8656@n2100.arm.linux.org.uk>
 <E1YSTnW-0001Jk-Tm@rmk-PC.arm.linux.org.uk>
Message-ID: <CAMuHMdWHAu+zDKce0+ianDb=RHYR59eeMoiYBDK4PC=YMY0JXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 2, 2015 at 6:06 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> --- a/include/linux/clkdev.h
> +++ b/include/linux/clkdev.h
> @@ -37,6 +37,9 @@ struct clk_lookup *clkdev_alloc(struct clk *clk, const char *con_id,
>  void clkdev_add(struct clk_lookup *cl);
>  void clkdev_drop(struct clk_lookup *cl);
>
> +struct clk_lookup *clkdev_create(struct clk *clk, const char *con_id,
> +       const char *dev_fmt, ...);

__printf(3, 4)

While you're at it, can you please also add the __printf attribute to
clkdev_alloc() and clk_register_clkdev()?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
