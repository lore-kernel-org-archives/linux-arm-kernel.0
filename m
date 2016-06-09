From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 9 Jun 2016 10:08:38 +0200
Subject: [PATCH] pinctrl: sh-pfc: fix warnings by include core.h
In-Reply-To: <CACRpkdaq8jzBT8o8RVnnA6xQ1YVqFoYf+wgmrWciJx0qbDLs=g@mail.gmail.com>
References: <1465320786-10333-1-git-send-email-ben.dooks@codethink.co.uk>
 <CACRpkdaq8jzBT8o8RVnnA6xQ1YVqFoYf+wgmrWciJx0qbDLs=g@mail.gmail.com>
Message-ID: <CAMuHMdU6AmOi1+gDMkqKpQ2+QGrv=FtGpx21a951Vr3+F=C5UA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus, Ben,

On Wed, Jun 8, 2016 at 2:08 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Jun 7, 2016 at 7:33 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>
>> Fix warnings about emev2_pinmux_info and r8a7779_pinmux_info
>> by using core.h instead of sh_pfc.h in these files. This gives
>> the declarations of the two structures and removes the following
>> warnings:
>>
>> drivers/pinctrl/sh-pfc/pfc-emev2.c:1695:30: warning: symbol 'emev2_pinmux_info' was not declared. Should it be static?
>> drivers/pinctrl/sh-pfc/pfc-r8a7779.c:3888:30: warning: symbol 'r8a7779_pinmux_info' was not declared. Should it be static?
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Ben: Thanks for your patch!

>
> Geert/Laurent:
>
> - take a look at this patch

These are fixes for sparse warnings, and look fine to me.
However, it seems "core.h" should be included by all the remaining
drivers/pinctrl/sh-pfc/pfc-sh* files for ARCH=sh, too.
At which point I start to question: why not merge core.h with sh_pfc.h?

> - shall I apply this directly?

i could take it through sh-pfc-for-v4.8.
I expect more pfc stuff to follow soon anyway.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
