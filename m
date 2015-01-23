From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 23 Jan 2015 14:05:22 +0100
Subject: [PATCH v12 00/15] arm: Fix DEBUG_LL for multi-platform kernels
 (without PL01X)
In-Reply-To: <1822066.pI6QN22RDx@wuerfel>
References: <1414148076-12685-1-git-send-email-daniel.thompson@linaro.org>
 <1822066.pI6QN22RDx@wuerfel>
Message-ID: <CAMuHMdUpNtL+K28DdC8xJ3vUPZGmviWcYGOVUNuhKQoobdL00Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Fri, Oct 24, 2014 at 5:46 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> There is still a related bug that we should also fix, but I'd say let's
> take your current patches first and then add whatever is missing
> on top. Specifically, a snippet like this
>
>         default 0xd4017000 if DEBUG_MMP_UART2
>         default 0xd4018000 if DEBUG_MMP_UART3
>         default 0xe0000000 if ARCH_SPEAR13XX
>         default 0xe4007000 if DEBUG_HIP04_UART
>         default 0xf0000be0 if ARCH_EBSA110
>
> still means you get the wrong default when you build a multiplatform
> kernel that you want to boot on HIP04 and you set DEBUG_HIP04_UART
> but you happen to also have ARCH_SPEAR13XX enabled.
>
> I have a patch that I use locally for randconfig builds that tries
> to fix this. It has some overlaps with your work but most parts are
> distinct. See below.

This is still desperately needed for anyone who wants to enable DEBUG_LL
on other platforms using multi_v7_defconfig.

Can you please upstream it?

Thanks!


Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
