From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 10 Jul 2015 10:48:26 +0200
Subject: Gemini Soc timers
In-Reply-To: <975d474dd947bcef8d3dd70ef18a5c29@advem.lv>
References: <1292339307-14336-2-git-send-email-ulli.kroll@googlemail.com>
 <2131951.l0j0CIttAZ@wuerfel>
 <f22e65faa7d86074cda27973f83d7a52@advem.lv>
 <1781580.JRD7b0UrJA@wuerfel>
 <alpine.LNX.2.00.1507091343150.24357@localhost>
 <5e6214ee669fbd797ad2ef257ce52068@advem.lv>
 <CACRpkdYm-W8FqBgvustJUweizocmX9LtVS6Q=7j8EjF8D+H77Q@mail.gmail.com>
 <975d474dd947bcef8d3dd70ef18a5c29@advem.lv>
Message-ID: <CACRpkdbf2CfT7fJ6wAC3WB9=-Cp0A5xZAO1-Rh78o-U26Fr0Ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 9, 2015 at 6:48 PM, Roman Yeryomin <roman@advem.lv> wrote:
> [Me]
>> As usual they are just keeping it out of mainline, and this
>> is adding sched_clock() and other goodies so should
>> probably be upstreamed ASAP.
>
>
> This is what I initially submitted here.

Ah. I missed part of the start of the discussion it seems.

> But Arnd wanted to see a smaller patch which only fixes gemini timer issue
> (t.i. shed clock being 100Hz instead of 25MHz).
> Also I've submitted 4.1 support yesterday, but patches didn't change much
> comparing to 3.18

On the other hand I think the bigger patch is OK actually.

I rewrote the timer support some time back and did not get
anyone to test it properly at the time, so the patch went in
untested. So this is a fix.

I think this should be applied as-is since you can actually
test the whole thing on real hardware, and also add:

Fixes: f3372c01816e "ARM: gemini: convert to GENERIC_CLOCKEVENTS"
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

> I would love to see all those patches/drivers in mainline - tell me where do
> I submit all that :)

I recently looked at some of the patch stacks in OpenWRT and
get a bit sad that the stuff did not go upstream, so I am ready
to help in any way I can.

Anything GPIO related I am ready to help in reviewing/applying
and I will also help out with ARM32 if I can. Sadly I do not have
a Gemini system.

Yours,
Linus Walleij
