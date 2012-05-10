From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 May 2012 12:02:42 +0100
Subject: Making ARM multiplatform kernels DT-only?
In-Reply-To: <20120510105515.GC30103@trinity.fluff.org>
References: <201205031350.35476.arnd@arndb.de>
 <20120503141853.GC897@n2100.arm.linux.org.uk>
 <20120510105515.GC30103@trinity.fluff.org>
Message-ID: <20120510110242.GE3190@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 10, 2012 at 11:55:15AM +0100, Ben Dooks wrote:
> On Thu, May 03, 2012 at 03:18:53PM +0100, Russell King - ARM Linux wrote:
> > I think what you're proposing is a totally artificial restriction.
> > There's no problem with a kernel supporting DT and non-DT together.
> > We've proven that many many times.  I prove it _every_ night that my
> > build and boot system runs - the OMAP LDP boots a multiplatform kernel
> > just fine without DT.
> 
> We could have had the same for Samsung's entire range if a bit of work
> had been applied to do things like PAGE_OFFSET and replaceable IRQ
> controllers.

We never did dynamic PAGE_OFFSET because we _had_ taken the decision with
the inclusion of XIP support that we weren't going to have self-modifying
code in the kernel - and loading the offset for every page table walk
would have been very expensive.

The self-modifying code viewpoint seems to have changed as a result of
Nicolas moving jobs, from an employer who wanted XIP to one who wants a
single kernel image, which in itself isn't surprising.
