From: ben@decadent.org.uk (Ben Hutchings)
Date: Mon, 5 Sep 2011 17:22:26 +0100
Subject: [PATCH] arm: ixp4xx, u300: Select ARCH_REQUIRE_GPIOLIB, not
	GENERIC_GPIO
In-Reply-To: <CACRpkdaACXxzhQ4m3+4tzTGrXubFF6jPkO9uG0kqVzvm+ORYwQ@mail.gmail.com>
References: <1315192383.3092.260.camel@deadeye>
	<CACRpkdaACXxzhQ4m3+4tzTGrXubFF6jPkO9uG0kqVzvm+ORYwQ@mail.gmail.com>
Message-ID: <20110905162226.GI2802@decadent.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2011 at 02:41:30PM +0200, Linus Walleij wrote:
> On Mon, Sep 5, 2011 at 5:12 AM, Ben Hutchings <ben@decadent.org.uk> wrote:
> 
> > @@ -830,7 +830,7 @@ config ARCH_U300
> > ? ? ? ?select GENERIC_CLOCKEVENTS
> > ? ? ? ?select CLKDEV_LOOKUP
> > ? ? ? ?select HAVE_MACH_CLKDEV
> > - ? ? ? select GENERIC_GPIO
> > + ? ? ? select ARCH_REQUIRE_GPIOLIB
> > ? ? ? ?help
> > ? ? ? ? ?Support for ST-Ericsson U300 series mobile platforms.
> 
> Please don't do that, it really is no gpiolib implementation.
> 
> In the archives you can find patches I already submitted switching
> the U300 GPIO over to use gpiolib.
[...]
 
OK.  But it doesn't seem to work without gpiolib either:

 CC [M]  drivers/input/touchscreen/ads7846.o                                                                                                                                                                                                                                                                             
drivers/input/touchscreen/ads7846.c: In function 'ads7846_setup_pendown':                                                                                                                              
drivers/input/touchscreen/ads7846.c:970:3: error: implicit declaration of function 'gpio_request_one' 

Ben.

-- 
Ben Hutchings
We get into the habit of living before acquiring the habit of thinking.
                                                              - Albert Camus
