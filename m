From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 2 Oct 2011 23:15:44 +0200
Subject: [PATCH v2] mach-ep93xx: break out GPIO driver specifics
In-Reply-To: <20111001223914.GP11710@n2100.arm.linux.org.uk>
References: <1316508132-20020-1-git-send-email-linus.walleij@stericsson.com>
	<20110920174012.GE7781@ponder.secretlab.ca>
	<CACRpkdazjpKZRfpoYgZ=kC+auEj9q-KMHa6qsWsD+5Hpji+96w@mail.gmail.com>
	<20111001223914.GP11710@n2100.arm.linux.org.uk>
Message-ID: <CAKnu2Mrzxb04X411B-bNPfRmdGuf6KbQK7EEfqztCbiM3fJsKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/10/2 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Tue, Sep 20, 2011 at 10:32:13PM +0200, Linus Walleij wrote:
>
>> It'd dependent on Russells cleanups so it'll go through Russells
>> tree and his gpio cleanup branch there.
>
> It's dependent on other stuff elsewhere too:
>
> error: patch failed: drivers/gpio/gpio-ep93xx.c:24
> error: drivers/gpio/gpio-ep93xx.c: patch does not apply
>
> According to your patch, line 24 onwards is:
>
> ?#include <linux/module.h>
>
> ?#include <mach/hardware.h>
>
> whereas I have this around line 24:
>
> ?#include <linux/basic_mmio_gpio.h>
>
> ?#include <mach/hardware.h>

Aha it's that moduleh git that is changing stuff all over the place.

> So I've applied this with GNU patch instead, accepting the one line of
> fuzz:
>
> Hunk #1 succeeded at 23 with fuzz 1 (offset -1 lines).
>
> As a result, I expect sfr will report a trivial merge conflict here.

OK thanks Russell that seems to get this one in atleast,
if I run into more trouble we should just call it a day with this
stuff for this merge window so we don't get too much conflicts
piled up.

Yours,
Linus Walleij
