From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Jan 2011 16:54:10 +0000
Subject: [PATCH] ARM: sched_clock: improve mult/shift accuracy with
	high frequency clocks
In-Reply-To: <alpine.LFD.2.00.1101100851300.6883@xanadu.home>
References: <alpine.LFD.2.00.1012202014500.10437@xanadu.home>
	<20101221105149.GO28157@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1012291703300.10437@xanadu.home>
	<20110103003718.GF17727@n2100.arm.linux.org.uk>
	<1294084049.2571.30.camel@work-vm>
	<20110109105200.GC31708@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101092224320.3455@xanadu.home>
	<20110110105120.GA12552@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1101100851300.6883@xanadu.home>
Message-ID: <20110111165410.GK11039@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 10, 2011 at 08:53:14AM -0500, Nicolas Pitre wrote:
> On Mon, 10 Jan 2011, Russell King - ARM Linux wrote:
> 
> > With a 32-bit or smaller cyclecounter, as 32-bit x 32-bit can never
> > overflow a 64-bit destination, so if anything zero should be passed in
> > this case.
> 
> That's the alternative suggestion I made as well.

I've just committed a patch which makes it zero.
