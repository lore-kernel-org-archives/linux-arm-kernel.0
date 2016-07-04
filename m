From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 4 Jul 2016 16:18:57 +0200
Subject: [PATCH 4/4] bus: simple-pm-bus: convert bool SIMPLE_PM_BUS to
 tristate
In-Reply-To: <20160703173040.23612-5-paul.gortmaker@windriver.com>
References: <20160703173040.23612-1-paul.gortmaker@windriver.com>
 <20160703173040.23612-5-paul.gortmaker@windriver.com>
Message-ID: <CAMuHMdU7W05rPvcmZ7-2L7KU5nwpcLsYt6XSr+EfO2b0kWxC=A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On Sun, Jul 3, 2016 at 7:30 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:
> The Kconfig currently controlling compilation of this code is:
>
> config SIMPLE_PM_BUS
>         bool "Simple Power-Managed Bus Driver"
>
> ...meaning that it currently is not being built as a module by anyone.
>
> In removing the orphaned modular support in a previous patch set,
> Geert indicated he'd rather see this code converted to tristate.
>
> I normally don't do that because it extends functionality that I
> can't easily run time test or even know if the use case makes sense,
> but since in this case the author has nominated it as such, we do
> the conversion here.
>
> Note that doesn't change the lack of run time testing ; this change
> is only tested for sucessful compile and modpost.

Thanks!

> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: linux-arm-kernel at lists.infradead.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

Ethernet is probed successfully on sh73a0/kzm9g after insmodding
simple-pm-bus.ko.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
