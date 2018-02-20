From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 20 Feb 2018 11:50:13 +0100
Subject: [PATCH 1/9] serial: arc_uart: Fix out-of-bounds access through DT
 alias
In-Reply-To: <1519119624-1268-2-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
 <1519119624-1268-2-git-send-email-geert+renesas@glider.be>
Message-ID: <CAMuHMdVVzK9Fisi6yjXq8ScM1QzBgm5aaV4QgU8Q=3b+_78Anw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 10:40 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> The arc_uart_ports[] array is indexed using a value derived from the
> "serialN" alias in DT, which may lead to an out-of-bounds access.
>
> Fix this by adding a range check.
>
> Note that the array size is defined by a Kconfig symbol
> (CONFIG_SERIAL_ARC_NR_PORTS), so this can even be triggered using a
> legitimate DTB.
>
> Fixes: 10640deb04b7949a ("serial: arc_uart: Fix out-of-bounds access through DT alias")

Fixes: ea28fd56fcde69af ("serial/arc-uart: switch to devicetree based probing")

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
