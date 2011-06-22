From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Jun 2011 17:23:45 +0200
Subject: i.MX consolidation patches
In-Reply-To: <20110622151407.GU23234@n2100.arm.linux.org.uk>
References: <1305823648-2428-1-git-send-email-s.hauer@pengutronix.de>
	<201106221710.39687.arnd@arndb.de>
	<20110622151407.GU23234@n2100.arm.linux.org.uk>
Message-ID: <201106221723.45813.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 June 2011, Russell King - ARM Linux wrote:
> I don't think you're _thinking_.  If you issue 'make uImage', how is the
> kernel configuration stuff to know that it should not enable multiple
> platforms which would make building a uImage technically impossible
> (and lead to the created uImage being non-bootable on some of those
> platforms.)
> 
> The answer is: you can't.
> 
> The best we can do is if the configuration encounters this problem, then
> fail to build a uImage.  If that concerns you, then don't ask the kernel
> to build an inherently fragile boot loader format in the first place.

Ok, I see.

I still need to learn about a lot of ways in which ARM differs from
other architectures I've worked with. I was thinking of
CONFIG_DEFAULT_UIMAGE on powerpc, which causes the uimage to be built
as a default make target.

Since ARM doesn't have that option, this obviously isn't a problem
for randconfig builds.
Sorry for the noise.

	Arnd
