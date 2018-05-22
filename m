From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 22 May 2018 16:33:37 +0200
Subject: [PATCH 3/9] ARM: dts: stout: Drop MTD partitioning from DT
In-Reply-To: <20180522120257.13232-3-marek.vasut+renesas@gmail.com>
References: <20180522120257.13232-1-marek.vasut+renesas@gmail.com>
 <20180522120257.13232-3-marek.vasut+renesas@gmail.com>
Message-ID: <CAMuHMdXw06zb-J7_858+KfRi3aAqQw8d3Js2k0Y69kKwzu2dTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2018 at 2:02 PM, Marek Vasut <marek.vasut@gmail.com> wrote:
> Drop the MTD partitioning from DT, since it does not describe HW
> and to give way to a more flexible kernel command line partition
> passing.
>
> To retain the original partitioning, assure you have enabled
> CONFIG_MTD_CMDLINE_PARTS in your kernel config and add the
> following to your kernel command line:
>
>   mtdparts=spi0.0:512k at 0(loader),256k(uboot),256k(uboot-env),-(flash)
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
