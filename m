From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 May 2011 02:57:04 +0200
Subject: [v2 0/7] OMAP: GPIO: Use PM runtime framework
In-Reply-To: <20110504061905.GD27860@atomide.com>
References: <1303139217-10285-1-git-send-email-charu@ti.com>
	<20110419062633.GA15620@atomide.com> <87r58w4gq3.fsf@ti.com>
	<20110421054221.GF5918@atomide.com>
	<BANLkTi=s=KzeZfvoq7Efg2=Ceahz_fQxMA@mail.gmail.com>
	<20110426072941.GA3755@atomide.com>
	<BANLkTimGU+kODvL0dC2x7UNSz0TReKveXQ@mail.gmail.com>
	<87y62ng3f8.fsf@ti.com>
	<BANLkTimW1PTavvxjPujVMEV38vzMvja9mw@mail.gmail.com>
	<20110504061905.GD27860@atomide.com>
Message-ID: <BANLkTikiUB4=y0sZtUSedcPveMsBSLJgpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/4 Tony Lindgren <tony@atomide.com>:
> * Linus Walleij <linus.walleij@linaro.org> [110504 00:37]:
>> 2011/5/3 Kevin Hilman <khilman@ti.com>:
>>
>> > Are you OK with a move of the current OMAP GPIO drivers (rather ugly)
>> > into drivers/gpio first, followed by the cleanup/restructure patches?
>>
>> In my case I actually did some cleanup after moving the driver for
>> U300, but I think this is a question to the GPIO maintainer who
>> I want to ACK this stuff in the end.
>>
>> Grant?
>>
>> You can always squash it later ...
>
> Personally I would prefer absolutely minimal clean-up of current
> code before moving to drivers/gpio to cut down the "crazy churn" in
> arch/arm/. Also then further changes are easier for the GPIO
> maintainers to review.
>
> Of course I understand that this might cause extra load for the
> GPIO maintainers, so it's up to the GPIO maintainers to set the
> required standards before accepting the code into drivers/gpio.

After discussion with Grant (in person) here at UDS I am informed
that he will not be able to review my GPIO consolidation patches in
time to make adjustments needed for this merge window, so we're
aiming at early 2.6.41 for these.

He has indicated that he has problems with the chosen config
mechanism and that we may need to back a few technical
assumptions out, and we need some more time for that.

For example we may need to refer to configurations by a string
or indeed export the struct gpio_chip accessor function
gpio_to_chip() and use custom functions for special stuff,
as was the first idea.

I will do the refactoring once I have a clear indication from the
maintainer where he wants this to end up, so my GPIO
consolidation patches will need to rest for a while.

For TI I guess this currently means you simply cannot work
on GPIO stuff until you know where to go with it unless you
allow the OMAP GPIO authors to keep churning in arch/arm/*...

That's unless Grant is OK with us moving stuff into
drivers/gpio that does *not* use gpiolib and utilize singletons to
get at the gpio_chip addresses (i.e. current form) and keep it
churning like that until it can be refactored.

Yours,
Linus Walleij
