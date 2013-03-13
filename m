From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 13 Mar 2013 06:25:13 +0100
Subject: [PATCH v2 05/14] ARM: integrator: use clocksource_of_init for
 sp804
In-Reply-To: <201303121854.45864.arnd@arndb.de>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
 <1363108124-17484-6-git-send-email-haojian.zhuang@linaro.org>
 <201303121854.45864.arnd@arndb.de>
Message-ID: <CACRpkdZ8w3yehwduwXKc3NK98fEOg7Bz9EG1_frJ4bZTCd45Kg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 7:54 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 12 March 2013, Haojian Zhuang wrote:

>>         timer1: timer at 13000100 {
>>                 compatible = "arm,sp804", "arm,primecell";
>> +               arm,sp804-clockevent = <0>;
>> +               status = "ok";
>>         };
>
> I would prefer to keep the old way of doing this. The "aliases" node is
> meant for configuration, while the timer device itself should not care
> whether it is used as a clockevent or clocksource or some other device.
>
> We could probably change the identifiers in the aliases to
> "linux,clocksource" and "linux,clockevents" instead of
> "arm,timer-primary" and "arm,timer-secondary".

I named it like that exactly to be OS-neutral.

The idea is that what timer is to be used for primary and secondary
may have implications on things like power consumption and
one timer may be broken in the HW etc. That is not a Linux-specific
thing.

A bit hard to do things right here :-/

Yours,
Linus Walleij
