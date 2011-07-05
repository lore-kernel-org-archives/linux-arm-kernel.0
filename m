From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 04 Jul 2011 21:51:47 -0400 (EDT)
Subject: what about mach-shark?
In-Reply-To: <20110704222442.GJ8286@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.00.1107041545480.14596@xanadu.home>
	<20110704220521.GI8286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107041812410.14596@xanadu.home>
	<20110704222442.GJ8286@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1107042146440.14596@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 4 Jul 2011, Russell King - ARM Linux wrote:

> On Mon, Jul 04, 2011 at 06:20:25PM -0400, Nicolas Pitre wrote:
> > OK.  In that case, UNCACHEABLE_ADDR is not truly "uncacheable", which 
> > might inhibit clock switching in cpu_sa110_do_idle, no?
> 
> Possibly, and this may be a bug which was never noticed - the same
> aflicts RiscPC too which has no ill effects noticed.  That's been
> well hammered over the years with that code as it stands.

The only effect might be less than optimal power consumption when idle.  
But I guess that RiscPC and Shark are not battery powered machines 
and therefore no one cared much.

> It's probably less risky to leave it be rather than trying to fix it.

Problem is that this is getting in the way of some cleanups I'm doing.  
So this is going to be fixed as a side effect of one of my patches.  
Hopefully someone with the hardware will be able to test it.


Nicolas
