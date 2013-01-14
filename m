From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 14 Jan 2013 10:46:12 +0000
Subject: [PATCH 0/4] gpio: introduce descriptor-based interface
In-Reply-To: <50F3DC2B.6000603@nvidia.com>
References: <1357629535-26033-1-git-send-email-acourbot@nvidia.com>
 <201301101008.45091.arnd@arndb.de> <50F3DC2B.6000603@nvidia.com>
Message-ID: <201301141046.12976.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 January 2013, Alex Courbot wrote:
> On 01/10/2013 07:08 PM, Arnd Bergmann wrote:
> > I found two that provide the generic gpio interfaces when gpiolib
> > is disabled, but use gpiolib otherwise for the same hardware,
> > arch/m68k/include/asm/mcfgpio.h and arch/blackfin/include/asm/gpio.h.
> > I would assume that we can simply remove the non-gpiolib shortcut
> > here at cost of a small overhead.
> 
> I performed a search on my side too (checking configurations options 
> which select GENERIC_GPIO but not ARCH_REQUIRE_GPIOLIB) and found the 
> same list. This takes some time btw - many platforms use this combo to 
> make GPIO support optional. Can I ask how you figured out these two archs?

I basically grepped for GENERIC_GPIO and looked at
the individual implementations.

> > Then there are a bunch that use gpiolib but have a nontrivial
> > implementation of gpio_get_value and other functions. I'm not sure
> > if these are a problematic with your code.
> 
> AFAICT these all implement an inline path that bypasses GPIOlib when the 
> GPIO number is known at compile time, for faster bitbanging I presume. 
> It should be totally harmless to keep them. Unfortunately, I don't think 
> it would be possible to have a similar trick using handlers.

Right, makes sense.

	Arnd
