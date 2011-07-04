From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 4 Jul 2011 23:24:42 +0100
Subject: what about mach-shark?
In-Reply-To: <alpine.LFD.2.00.1107041812410.14596@xanadu.home>
References: <alpine.LFD.2.00.1107041545480.14596@xanadu.home>
	<20110704220521.GI8286@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1107041812410.14596@xanadu.home>
Message-ID: <20110704222442.GJ8286@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 06:20:25PM -0400, Nicolas Pitre wrote:
> OK.  In that case, UNCACHEABLE_ADDR is not truly "uncacheable", which 
> might inhibit clock switching in cpu_sa110_do_idle, no?

Possibly, and this may be a bug which was never noticed - the same
aflicts RiscPC too which has no ill effects noticed.  That's been
well hammered over the years with that code as it stands.

It's probably less risky to leave it be rather than trying to fix it.
