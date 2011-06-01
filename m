From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 2 Jun 2011 01:09:59 +0200 (CEST)
Subject: [PATCH] arm: fix regression in ixp4xx clocksource
In-Reply-To: <20110601225826.GR3660@n2100.arm.linux.org.uk>
References: <20110530084307.GA28953@riccoc20.at.omicron.at>
	<20110601225826.GR3660@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.02.1106020100200.3078@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Wed, 1 Jun 2011, Russell King - ARM Linux wrote:

> On Mon, May 30, 2011 at 10:43:07AM +0200, Richard Cochran wrote:
> > Commit 234b6ceddb4fc2a4bc5b9a7670f070f6e69e0868
> > 
> >    clocksource: convert ARM 32-bit up counting clocksources
> > 
> > broke the build for ixp4xx and made big endian operation impossible.
> > This commit restores the original behaviour.
> 
> I'm really not happy about using the MMIO clocksource stuff with random
> other read functions like this - it defeats the entire purpose of the
> MMIO clocksource stuff.  Maybe we should just undo the change for IXP4xx
> and treat it as "special" for the time being.
> 
> Thomas - do you have any other views?

I have no objections to have special cased read functions as long as
all the other copied code is gone. We have the same problem with the
generic irq chip and I did not come up with a good decision function
where to draw the line. As for everything we come up with in the
consolidation space we need to apply common sense and keep an eye on
the real abusers.

Though in the mmio clocksource case we might ask the question whether
read[l|w]() is really necessary in the generic implemetation or
not. [too tired to answer that now ]
 
Thanks,

	tglx
