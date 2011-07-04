From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 4 Jul 2011 11:21:12 +0200 (CEST)
Subject: [PATCH] arm: fix regression in ixp4xx clocksource
In-Reply-To: <alpine.LFD.2.02.1106020100200.3078@ionos>
References: <20110530084307.GA28953@riccoc20.at.omicron.at>
	<20110601225826.GR3660@n2100.arm.linux.org.uk>
	<alpine.LFD.2.02.1106020100200.3078@ionos>
Message-ID: <alpine.LFD.2.02.1107041120190.2917@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Jun 2011, Thomas Gleixner wrote:
> > I'm really not happy about using the MMIO clocksource stuff with random
> > other read functions like this - it defeats the entire purpose of the
> > MMIO clocksource stuff.  Maybe we should just undo the change for IXP4xx
> > and treat it as "special" for the time being.
> > 
> > Thomas - do you have any other views?
> 
> I have no objections to have special cased read functions as long as
> all the other copied code is gone. We have the same problem with the
> generic irq chip and I did not come up with a good decision function
> where to draw the line. As for everything we come up with in the
> consolidation space we need to apply common sense and keep an eye on
> the real abusers.
> 
> Though in the mmio clocksource case we might ask the question whether
> read[l|w]() is really necessary in the generic implemetation or
> not. [too tired to answer that now ]

Thinking more about it we should add BE accessor functions to the mmio
clocksource as this might be useful for other architectures as well.

Thanks,

	tglx
