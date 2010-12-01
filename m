From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 01 Dec 2010 17:17:26 -0500 (EST)
Subject: State of SMP / dual-core for MV78200?
In-Reply-To: <4CF657CB.70901@kernelconcepts.de>
References: <4CF657CB.70901@kernelconcepts.de>
Message-ID: <alpine.LFD.2.00.1012011712160.10437@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 1 Dec 2010, Nils Faerber wrote:

> Hello!
> I have a Marvell Discover MV78200 at hand and am wondering about the
> multi core support in ARM Linux for it. I know that the Marvell based
> kernel suports dual-system, i.e. booting two kernel instances on the two
> cores. I also see that the upstream kernel still has the hooks for this
> in the board support files (for distributing the resources between the
> cores). Does anyone here know about the status about this dual-system
> support?
> And wouldn't SMP also work on such CPUs, i.e. having one kernel instance
> with two cores? For the application in question SMP would make more
> sense (high data I/O traffic).

The MV78200 is not cache coherent, and therefore SMP is impossible on 
that processor.  The best you can do is to partition the RAM and 
peripherals between the two cores and run two independent Linux systems 
side by side, one on each core.  And then of course you'll need some 
mechanism for those Linux instances to communicate with each other for 
that setup to be useful.


Nicolas
