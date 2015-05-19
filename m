From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 19 May 2015 09:26:50 +0200
Subject: [PATCH v4 1/7] ARM: lpc18xx: add basic support for NXP
 LPC18xx/43xx SoCs
In-Reply-To: <1431381653-25356-2-git-send-email-manabian@gmail.com>
References: <1431381653-25356-1-git-send-email-manabian@gmail.com>
 <1431381653-25356-2-git-send-email-manabian@gmail.com>
Message-ID: <CAMuHMdVfh6-Y6BuRpxXRJexXK+U-Bp0P+W-2e4ioAZ=60C_TYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 12:00 AM, Joachim Eastwood <manabian@gmail.com> wrote:
> --- a/arch/arm/Kconfig.debug
> +++ b/arch/arm/Kconfig.debug
> @@ -1359,6 +1359,7 @@ config DEBUG_UART_PHYS
>         default 0x20201000 if DEBUG_BCM2835
>         default 0x3e000000 if DEBUG_BCM_KONA_UART
>         default 0x4000e400 if DEBUG_LL_UART_EFM32
> +       default 0x40081000 if ARCH_LPC18XX

This will be used in any multi-platform kernel with DEBUG_LL=y,  possible
overriding a correct value, even if low-level LPC18XX debug support itself
(what's the config option for that, I couldn't find it?) is disabled.
Please make this dependent on an appropriate DEBUG_LPC18XX
option. Thanks!

I noticed this was already applied...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
