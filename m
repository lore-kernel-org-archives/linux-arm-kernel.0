From: tony@atomide.com (Tony Lindgren)
Date: Tue, 6 Sep 2011 12:28:17 +0300
Subject: [PATCH 1/3] ARM: debug: use kconfig choice for selecting
	DEBUG_LL UART
In-Reply-To: <alpine.LFD.2.00.1108211522280.20358@xanadu.home>
References: <20110819110822.GB8918@e102144-lin.cambridge.arm.com>
	<20110819113740.GF12527@S2100-06.ap.freescale.net>
	<20110819123238.GD8918@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1108191101560.20358@xanadu.home>
	<20110821091452.GH12028@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211258490.20358@xanadu.home>
	<20110821182604.GI28546@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211435320.20358@xanadu.home>
	<20110821191835.GA19678@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211522280.20358@xanadu.home>
Message-ID: <20110906092816.GC3548@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nicolas Pitre <nico@fluxnic.net> [110821 22:21]:
> On Sun, 21 Aug 2011, Russell King - ARM Linux wrote:
> > 
> > The decompressor has nothing to do with this.
> 
> Sure it does, since it relies on early serial output capabilities, just 
> like earlyprintk, or possibly even the senduart code.  Solving this once 
> for them all, *appropriately*, would certainly be nice.  I would be glad 
> to see this need addressed without making further ugly abuses like the 
> OMAP people did with their OMAP_UART_INFO and the 
> arch/arm/plat-omap/include/plat/uncompress.h abomination.

Well the way the debug_ll code is currenty set up just won't scale.
The basic problem is that the debug_ll code should be machine specific,
not arch specific..

Probably the best long term solution is to set up the debug uart based
on DT data and initialize it in the uncompress code. Anybody debugging
lower level stuff can certainly patch in the ucompress debug_ll code.

Regards,

Tony
