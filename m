From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Dec 2009 15:03:00 +0000
Subject: [PATCH v2 8/8] OMAP1 clock: convert mach-omap1/clock.h to
	mach-omap1/clock_data.c
In-Reply-To: <alpine.DEB.2.00.0912030520360.13408@utopia.booyaka.com>
References: <20091203095830.1203.76290.stgit@localhost.localdomain>
	<20091203100707.1203.98247.stgit@localhost.localdomain>
	<20091203102700.GA30423@flint.arm.linux.org.uk>
	<alpine.DEB.2.00.0912030331360.13408@utopia.booyaka.com>
	<20091203104354.GB20379@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.0912030355050.13408@utopia.booyaka.com>
	<alpine.DEB.2.00.0912030424050.13408@utopia.booyaka.com>
	<20091203121157.GC20379@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.0912030520360.13408@utopia.booyaka.com>
Message-ID: <20091203150300.GB26651@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2009 at 05:33:44AM -0700, Paul Walmsley wrote:
> My preference was to keep data separated from code in the source files; I 
> think it is slightly more readable.

It's less readable because instead of having similar stuff together, it's
at opposite ends of the file.

> The other consideration is that there are some patches in the works here 
> to move all of the struct clk function pointers into the struct clkops.  

Oh for gods sake, why do people take things to the extreme?

I looked into doing exactly that and decided it was a *bad* *idea* because
it stupidly multiplies the number of ops structures.  Instead of having a
few well-defined and well-understood ops structures, you end up with one
ops structure per special case.

Then you're going to be back into adding all that sodding crap that you
had back before I cleaned up the enable/disable shite.

No, please don't do this, this would definitely be a total backwards step.

Please take a moment to think about the changes you're doing.
