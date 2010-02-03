From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 3 Feb 2010 15:31:31 +0000
Subject: 32-bit Thumb-2 breakpoints
In-Reply-To: <20100203144022.GG22275@n2100.arm.linux.org.uk>
References: <20100203005038.GA16356@caradoc.them.org>
	<1265197942.1970.34.camel@pc1117.cambridge.arm.com>
	<20100203132824.GA27048@n2100.arm.linux.org.uk>
	<20100203135914.GF4277@wear.picochip.com>
	<20100203144022.GG22275@n2100.arm.linux.org.uk>
Message-ID: <20100203151449.GI4277@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2010 at 02:40:22PM +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 03, 2010 at 01:59:14PM +0000, Jamie Iles wrote:
> > Well it looks like the hardware breakpoint layer is on top of the perf_events
> > subsystem and the breakpoint becomes a perf event. In this case the breakpoint
> > should be scheduled in and out by perf on context switches if targetting a
> > specific PID or could be left in the whole time if desired.
> 
> Unfortunately, we're drifting from the original topic...
> 
> This starts worrying me more.  Is execution stopped (as in actually
> stopped, not just switched away from leaving the thread runnable) in
> the target thread when one of these 'perf' breakpoints is hit?  If
> not, it's completely unsuitable for debuggers to use, and raises the
> question of why it's being interfaced with the ptrace code.
Will should be able to give a better anwer but my understanding is that at in
the core hw_breakpoint and perf code, the event is simply logged and the pc
recorded. The ptrace integration allows the processed to have SIGTRAP raised.

Jamie
> Yes, x86 seems to use this method, but it doesn't send signals in the
> counter overflow function, so things must be working differently there.
