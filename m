From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Sep 2012 23:51:48 +0200
Subject: [PATCH 4/6 v2] ARM: integrator: initial device tree support
In-Reply-To: <5043E4BE.1060508@gmail.com>
References: <1346471760-23993-1-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-2-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-3-git-send-email-linus.walleij@linaro.org>
 <1346471760-23993-4-git-send-email-linus.walleij@linaro.org>
 <5043E4BE.1060508@gmail.com>
Message-ID: <CACRpkdbTRCUnx1JjCQ+WT4PoxtDG38MP=ctUp6TBPd64xQ39jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 3, 2012 at 12:59 AM, Rob Herring <robherring2@gmail.com> wrote:
> On 08/31/2012 10:55 PM, Linus Walleij wrote:

>> +/ {
>> +     model = "ARM Integrator/CP";
>> +     compatible = "arm,integrator-cp";
>> +     ranges;
>> +
>> +     aliases {
>> +             arm,integrator-clocksource = &timer2;
>> +             arm,integrator-clockevent = &timer1;
>
> This is linux specific and a common issue we need a solution for. Grant
> had done something for versatile and we discussed it some, but nothing
> ever got close to finalized. IIRC, Grant's solution was just add a
> "linux,clockevent" or "linux,clocksource" to the nodes that are to be
> used. But he wasn't really happy with it. Perhaps using these names as
> aliases would be better.

Atleast I'm honest about what this is, IMHO this is better than
any of the solutions we already have in boot/dts.

Look at the versatile express
arch/arm/boot/dts/vexpress-v2m.dtsi:

        aliases {
                arm,v2m_timer = &v2m_timer01;
        };

It's quite hard to tell that this "vtm_timer" is actually the block
serving as clock source and clockevent for the Vexpress,
but if you inspect the code you can see that this is what it is.

I can of course skip the aliases and go for the timer nodes
I want directly, but that isn't any helpful for people reading the
device tree, is it?

Maybe primary-timer, secondary-timer is sufficiently
good and neutral aliases?

Yours,
Linus Walleij
