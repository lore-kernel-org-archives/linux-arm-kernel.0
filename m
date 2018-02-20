From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 20 Feb 2018 11:51:13 +0100
Subject: [PATCH 2/9] serial: fsl_lpuart: Fix out-of-bounds access through
 DT alias
In-Reply-To: <1519119624-1268-3-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
 <1519119624-1268-3-git-send-email-geert+renesas@glider.be>
Message-ID: <CAMuHMdXrFQbopFKipo0yGejyayHXWXy_t50ZDJMbn6dj04LtOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 10:40 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> The lpuart_ports[] array is indexed using a value derived from the
> "serialN" alias in DT, which may lead to an out-of-bounds access.
>
> Fix this by adding a range check.
>
> Fixes: 970416c691dc68b5 ("serial: fsl_lpuart: Fix out-of-bounds access through DT alias")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Fixes: c9e2e946fb0ba5d2 ("tty: serial: add Freescale lpuart driver support")

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
