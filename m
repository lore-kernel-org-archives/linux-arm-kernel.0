From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 May 2011 00:52:20 +0200
Subject: [PATCH 1/4] drivers: create a pinmux subsystem
In-Reply-To: <1305067020.19586.130.camel@Joe-Laptop>
References: <1304363786-30376-1-git-send-email-linus.walleij@stericsson.com>
	<1304365077.7792.40.camel@Joe-Laptop>
	<BANLkTi=XSevO72NqCYOYuketjE8XjeQU+A@mail.gmail.com>
	<1305067020.19586.130.camel@Joe-Laptop>
Message-ID: <BANLkTi=zDJLHUa2ogTeEkmdsbkhvGJCsEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/11 Joe Perches <joe@perches.com>:
> On Wed, 2011-05-11 at 00:18 +0200, Linus Walleij wrote:
>> 2011/5/2 Joe Perches <joe@perches.com>:
>> > On Mon, 2011-05-02 at 21:16 +0200, Linus Walleij wrote:
>> >> From: Linus Walleij <linus.walleij@linaro.org>
>> >> diff --git a/drivers/pinmux/core.c b/drivers/pinmux/core.c
>> > Trivial comments follow
>> >> +static inline int pin_is_valid(int pin)
>> >> +{
>> >> + ? ? return ((unsigned)pin) < MACH_NR_PINS;
>> >> +}
>> > Couldn't pin just be declared unsigned or maybe u32?
>> No, because like in the GPIO subsystem you *may* want to send in invalid
>> pins, and those are identified by negative numbers.
>
> Then I think this is clearer and the compiler
> should produce the same code.
>
> static inline bool pin_is_valid(int pin)
> {
> ? ? ? ?return pin >= 0 && pin < MACH_NR_PINS;
> }

Yes indeed, I'll fix. Can you propose a patch to the same pattern
found in include/asm-generic/gpio.h? It would bring equal
clarity there I believe.

Thanks!
Linus Walleij
