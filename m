From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 10 May 2012 11:55:15 +0100
Subject: Making ARM multiplatform kernels DT-only?
In-Reply-To: <20120503141853.GC897@n2100.arm.linux.org.uk>
References: <201205031350.35476.arnd@arndb.de>
 <20120503141853.GC897@n2100.arm.linux.org.uk>
Message-ID: <20120510105515.GC30103@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2012 at 03:18:53PM +0100, Russell King - ARM Linux wrote:
> On Thu, May 03, 2012 at 01:50:35PM +0000, Arnd Bergmann wrote:
> > My feeling is that we should just mandate DT booting for multiplatform
> > kernels, because it significantly reduces the combinatorial space
> > at compile time, avoids a lot of legacy board files that we cannot
> > test anyway, reduces the total kernel size and gives an incentive
> > for people to move forward to DT with their existing boards.
> 
> On this point, I strongly object, especially as I'm one who uses the
> existing non-DT multiplatform support extensively.  It's really not
> a problem for what you're trying to achieve.

I object firstly on principle that you don't need the DT support to
allow this, it could have been done years ago if anyone had taken the
time to do it.
 
> I think what you're proposing is a totally artificial restriction.
> There's no problem with a kernel supporting DT and non-DT together.
> We've proven that many many times.  I prove it _every_ night that my
> build and boot system runs - the OMAP LDP boots a multiplatform kernel
> just fine without DT.

We could have had the same for Samsung's entire range if a bit of work
had been applied to do things like PAGE_OFFSET and replaceable IRQ
controllers.

> In any case, this is the least of the worries when you're wanting to
> build multiple SoCs into the same kernel image.  See my previous reply
> concerning that.

-- 
Ben Dooks, ben at fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.
