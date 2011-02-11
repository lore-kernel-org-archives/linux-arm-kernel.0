From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 11 Feb 2011 21:07:33 +0000
Subject: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
In-Reply-To: <alpine.LFD.2.00.1102111543010.14920@xanadu.home>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
	<0557426516de482c1769a50fa0b5f17a@mail.gmail.com>
	<20110208164747.GD6188@n2100.arm.linux.org.uk>
	<AANLkTimGa-Y6ddHknGe9Gar7+mWPuA_T2+6VL6ecfgxD@mail.gmail.com>
	<20110210130430.GB3652@n2100.arm.linux.org.uk>
	<1297343555.9306.9.camel@e102109-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1102111543010.14920@xanadu.home>
Message-ID: <20110211210733.GC31529@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 11, 2011 at 03:45:51PM -0500, Nicolas Pitre wrote:
> The patch below is making the code more straight forward regardless of 
> any swp emulation issues.

I don't know where you get that idea from.  What it does is make a kernel
built with a standard set of options have differing behaviour on v7 and
pre-v7 architectures.

On v7 architectures, the vectors page and user pages all become read only
to SVC mode.  On pre-v7 architectures on the same kernel, they are read-
write to SVC mode.

What we have now is that these pages are only read-only when CPU domains
are turned off - for everything.  So we know that if CPU domains are
enabled, it's read/write, otherwise it's read only.  That's more
straight forward than what this patch creates IMHO.
