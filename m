From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 5 Sep 2011 14:41:30 +0200
Subject: [PATCH] arm: ixp4xx, u300: Select ARCH_REQUIRE_GPIOLIB,
	not GENERIC_GPIO
In-Reply-To: <1315192383.3092.260.camel@deadeye>
References: <1315192383.3092.260.camel@deadeye>
Message-ID: <CACRpkdaACXxzhQ4m3+4tzTGrXubFF6jPkO9uG0kqVzvm+ORYwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 5, 2011 at 5:12 AM, Ben Hutchings <ben@decadent.org.uk> wrote:

> @@ -830,7 +830,7 @@ config ARCH_U300
> ? ? ? ?select GENERIC_CLOCKEVENTS
> ? ? ? ?select CLKDEV_LOOKUP
> ? ? ? ?select HAVE_MACH_CLKDEV
> - ? ? ? select GENERIC_GPIO
> + ? ? ? select ARCH_REQUIRE_GPIOLIB
> ? ? ? ?help
> ? ? ? ? ?Support for ST-Ericsson U300 series mobile platforms.

Please don't do that, it really is no gpiolib implementation.

In the archives you can find patches I already submitted switching
the U300 GPIO over to use gpiolib.

However it fell to the ground due to the shortage of a mechanism
in gpiolib to configure pin bias. I could try to hack around it but
it would still be a hack :-(

I sent several patches trying to adress that issue, none have been
accepted.

So instead I venture into inventing the pin control subsystem which
is intended to handle complex controllers like these. It is at
version 7 right now.

Thanks,
Linus Walleij
