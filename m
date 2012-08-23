From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 23 Aug 2012 13:31:09 +0000
Subject: [PATCH 4/4] [RFC] ARM: treewide: manually change more mach-*/*.h
 includes
In-Reply-To: <50362417.9070600@atmel.com>
References: <201208221253.07278.arnd@arndb.de>
 <201208231135.11688.arnd@arndb.de> <50362417.9070600@atmel.com>
Message-ID: <201208231331.09612.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 August 2012, Nicolas Ferre wrote:
> > How about I move all the pure platform data definition files now and
> > rebase the other patches on top of that. Here is a list of suggested
> > file names in include/linux/platform_data/:
> > 
> > mach-at91/at_hdmac.h          -> dma-atmel.h
> 
> Fine with me. Maybe atmel-dma.h can better match what we already have in
> this directory, but I do not know what is the policy in this directory...

There does not seem to be a clear policy in that directory yet, so I
chose to put the subsystem name first. There have been a few subsystems
recently which adopted this naming scheme for their drivers, so it
seemed to be a good choice if we want to start a naming scheme that
sticks.
 
> > ** list of mach/* inclusions that I could not match with
> > ** exactly one ARM platform:
> 
> In fact, for "*atmel*" type of files, they usually match both AVR32
> and ARM/AT91 devices: so, we have to be careful about them...

Yes, I'm aware of that. My list did not include the mach/atmel-mci.h
or the mach/board.h files, which suffer from this problem and cannot
easily be merged.

	Arnd
