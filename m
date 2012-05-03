From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 May 2012 15:18:53 +0100
Subject: Making ARM multiplatform kernels DT-only?
In-Reply-To: <201205031350.35476.arnd@arndb.de>
References: <201205031350.35476.arnd@arndb.de>
Message-ID: <20120503141853.GC897@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2012 at 01:50:35PM +0000, Arnd Bergmann wrote:
> My feeling is that we should just mandate DT booting for multiplatform
> kernels, because it significantly reduces the combinatorial space
> at compile time, avoids a lot of legacy board files that we cannot
> test anyway, reduces the total kernel size and gives an incentive
> for people to move forward to DT with their existing boards.

On this point, I strongly object, especially as I'm one who uses the
existing non-DT multiplatform support extensively.  It's really not
a problem for what you're trying to achieve.

I think what you're proposing is a totally artificial restriction.
There's no problem with a kernel supporting DT and non-DT together.
We've proven that many many times.  I prove it _every_ night that my
build and boot system runs - the OMAP LDP boots a multiplatform kernel
just fine without DT.

In any case, this is the least of the worries when you're wanting to
build multiple SoCs into the same kernel image.  See my previous reply
concerning that.
