From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 20 Feb 2018 11:52:43 +0100
Subject: [PATCH 6/9] serial: samsung: Fix out-of-bounds access through DT
 alias
In-Reply-To: <1519119624-1268-7-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
 <1519119624-1268-7-git-send-email-geert+renesas@glider.be>
Message-ID: <CAMuHMdUPb8cubv5v7OD4qHokwk1tPScNkju0Tizwm2sOFpcF3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 10:40 AM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> The s3c24xx_serial_ports[] array is indexed using a value derived from
> the "serialN" alias in DT, which may lead to an out-of-bounds access.
>
> Fix this by adding a range check.
>
> Note that the array size is defined by a Kconfig symbol
> (CONFIG_SERIAL_SAMSUNG_UARTS), so this can even be triggered using a
> legitimate DTB.
>
> Fixes: 3ac337e76a1c637b ("serial: samsung: Fix out-of-bounds access through DT alias")

Fixes: 13a9f6c64fdc55eb ("serial: samsung: Consider DT alias when probing po
rts")

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
