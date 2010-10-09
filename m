From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 9 Oct 2010 13:11:26 +0200
Subject: [PATCH] ARM: allow, but warn, when issuing ioremap() on RAM
In-Reply-To: <AANLkTimtdV8THgnQL1RxaqLzCUwO27AZSMPi=UtgpML7@mail.gmail.com>
References: <1286444662-16843-1-git-send-email-felipe.contreras@gmail.com>
	<20101009092127.GB20975@n2100.arm.linux.org.uk>
	<AANLkTimtdV8THgnQL1RxaqLzCUwO27AZSMPi=UtgpML7@mail.gmail.com>
Message-ID: <201010091311.26335.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 09 October 2010 12:28:19 Felipe Contreras wrote:
> Also, what do you think is the right attitude? Do you think all
> driver writers should follow each and every patch on the mailing list
> or always try release candidates? Even if they all did (some do),
> there's no generic solution, so they all are scratching their heads
> about how to solve this. It might be crystal clear for you how such
> generic solution could be implemented, or perhaps how some of these
> drivers can be fixed individually, if so, why don't you come with a
> proposal to mitigate the pain of fixing such drivers.

Please put this into perspective, it's not like this was ever a
normal thing to do, and drivers doing an ioremap on kernel memory
would typically not make it through a review. I've looked through
the ARM specific drivers that do ioremap and practically all of
them just map their MMIO registers as they should.

The few drivers that may be hit by this are typically in drivers/staging
exactly because issues like this have not been fixed yet.

We should probably just fix the non-staging drivers that are hit by
this now and declare the issue done.

When you say that "many drivers broken", can you list the ones you know
about? It would probably help resolve this the right way.

	Arnd
