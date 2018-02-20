From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 20 Feb 2018 11:53:05 +0100
Subject: [PATCH 7/9] serial: sh-sci: Fix out-of-bounds access through DT
 alias
In-Reply-To: <1519119624-1268-8-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
 <1519119624-1268-8-git-send-email-geert+renesas@glider.be>
Message-ID: <CAMuHMdVqoBC0oD+JXWJU_p5KJy7adZj681rwxYFYj_L5kwD=ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 10:40 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> The sci_ports[] array is indexed using a value derived from the
> "serialN" alias in DT, which may lead to an out-of-bounds access.
>
> Fix this by adding a range check.
>
> Note that the array size is defined by a Kconfig symbol
> (CONFIG_SERIAL_SH_SCI_NR_UARTS), so this can even be triggered using a
> legitimate DTB.
>
> Fixes: f650cdf1c115498e ("serial: sh-sci: Fix out-of-bounds access through DT alias")

Fixes: 97ed9790c514066b ("serial: sh-sci: Remove unused platform data
capabilities field")

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
