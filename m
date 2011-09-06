From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 6 Sep 2011 09:26:00 +0200
Subject: [PATCH] arm: ixp4xx, u300: Select ARCH_REQUIRE_GPIOLIB,
	not GENERIC_GPIO
In-Reply-To: <20110905162226.GI2802@decadent.org.uk>
References: <1315192383.3092.260.camel@deadeye>
	<CACRpkdaACXxzhQ4m3+4tzTGrXubFF6jPkO9uG0kqVzvm+ORYwQ@mail.gmail.com>
	<20110905162226.GI2802@decadent.org.uk>
Message-ID: <CACRpkdZFj_OFkgDzyTVVCX9xkPPitSXm2FcpwWWaewsegzJYRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 5, 2011 at 6:22 PM, Ben Hutchings <ben@decadent.org.uk> wrote:
> On Mon, Sep 05, 2011 at 02:41:30PM +0200, Linus Walleij wrote:
>> On Mon, Sep 5, 2011 at 5:12 AM, Ben Hutchings <ben@decadent.org.uk> wrote:
>>
>> > @@ -830,7 +830,7 @@ config ARCH_U300
>> > ? ? ? ?select GENERIC_CLOCKEVENTS
>> > ? ? ? ?select CLKDEV_LOOKUP
>> > ? ? ? ?select HAVE_MACH_CLKDEV
>> > - ? ? ? select GENERIC_GPIO
>> > + ? ? ? select ARCH_REQUIRE_GPIOLIB
>> > ? ? ? ?help
>> > ? ? ? ? ?Support for ST-Ericsson U300 series mobile platforms.
>>
>> Please don't do that, it really is no gpiolib implementation.
>>
>> In the archives you can find patches I already submitted switching
>> the U300 GPIO over to use gpiolib.
> [...]
>
> OK. ?But it doesn't seem to work without gpiolib either:
>
> ?CC [M] ?drivers/input/touchscreen/ads7846.o
> drivers/input/touchscreen/ads7846.c: In function 'ads7846_setup_pendown':
> drivers/input/touchscreen/ads7846.c:970:3: error: implicit declaration of function 'gpio_request_one'

Yes.

I don't know a good way out of this really :-(

I'll start looking for the bad ways out, like hacking
the GPIO driver to do GPIOLIB in a not-so-elegant
way.

Yours,
Linus Walleij
