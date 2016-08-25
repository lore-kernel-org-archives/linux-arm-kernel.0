From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 25 Aug 2016 09:52:47 +0200
Subject: [PATCH v3] clk: let clk_disable() return immediately if clk is
 NULL
In-Reply-To: <1472059613-30551-1-git-send-email-yamada.masahiro@socionext.com>
References: <1472059613-30551-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAMuHMdUC9d4KNPTDY51DCptmMFQ1F2jLmRDO9WLt=WZA09qRew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 7:26 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Many of clk_disable() implementations just return for NULL pointer,
> but this check is missing from some.  Let's make it tree-wide
> consistent.  It will allow clock consumers to call clk_disable()
> without NULL pointer check.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Acked-by: Greg Ungerer <gerg@uclinux.org>
> Acked-by: Wan Zongshun <mcuos.com@gmail.com>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
