From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 21 Aug 2011 21:54:41 +0100
Subject: [PATCH 1/3] ARM: debug: use kconfig choice for selecting
	DEBUG_LL UART
In-Reply-To: <alpine.LFD.2.00.1108211557440.20358@xanadu.home>
References: <20110819113740.GF12527@S2100-06.ap.freescale.net>
	<20110819123238.GD8918@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1108191101560.20358@xanadu.home>
	<20110821091452.GH12028@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211258490.20358@xanadu.home>
	<20110821182604.GI28546@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211435320.20358@xanadu.home>
	<20110821191835.GA19678@n2100.arm.linux.org.uk>
	<20110821192242.GB19678@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211557440.20358@xanadu.home>
Message-ID: <20110821205441.GC19678@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 21, 2011 at 04:07:37PM -0400, Nicolas Pitre wrote:
> On Sun, 21 Aug 2011, Russell King - ARM Linux wrote:
> 
> > And further to this, I'll point out that the debugging functions are
> > *explicitly* designed to avoid corrupting any more than just r0-r3
> > and lr.  That's not just the IO functions but also the hex and string
> > printing functions.
> > 
> > And the head*.S code is explicitly written to expect r0-r3 to be
> > corrupted - which basically means that no long-term values are held in
> > those registers.
> 
> Well, not exactly.  I actually have a patch to that effect I made a 
> while ago so all the early code could be unaffected by inserted function 
> call, but held on to it because nothing yet justified its need.  Here it 
> is for reference:

And so this buggers up the ability to insert calls to the debugging code
by placing values into r0-r3.  So that patch will get a nak too.
