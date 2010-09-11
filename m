From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Sat, 11 Sep 2010 13:22:04 +0200
Subject: [PATCH] MMCI: use _cansleep GPIO functions
In-Reply-To: <AANLkTikOOZED5i86j6Jayqvccmw8pa6+RKmG+xYFF-2b@mail.gmail.com>
References: <1284064315-14515-1-git-send-email-linus.walleij@stericsson.com>
	<AANLkTikOOZED5i86j6Jayqvccmw8pa6+RKmG+xYFF-2b@mail.gmail.com>
Message-ID: <AANLkTi=oMh2ff+VnE3E5-1TpJFsfYe5PoNZOar3OXQfV@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/9/11 Rabin Vincent <rabin@rab.in>:
> On Fri, Sep 10, 2010 at 2:01 AM, Linus Walleij
> <linus.walleij@stericsson.com> wrote:
>> - ? ? ? ? ? ? ? status = !!gpio_get_value(host->gpio_cd) ^ plat->cd_invert;
>> + ? ? ? ? ? ? ? status = gpio_get_value_cansleep(host->gpio_cd) ^
>> + ? ? ? ? ? ? ? ? ? ? ? plat->cd_invert;
>
> Why do you remove the double negation? ?gpio_get_value*()
> can return non-zero values, and we need to make it 1 for the
> inversion xor to work.

Aha I get it. But !! is a bit hard to parse in head is it not...

Cast a non-zero to C internal bool type, negate it and then
negate the negation so the end result is bool, not just
non-zero. I never saw that idiom before.

I don't know if I'm particularly dumb but it makes my reading
take time.

I'll slam in some intermediate bool or something so it's super
clear what's happening, OK?

Yours,
Linus Walleij
