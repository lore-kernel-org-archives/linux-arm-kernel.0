From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Sep 2011 10:37:38 +0100
Subject: [PATCH 1/3] ARM: debug: use kconfig choice for selecting
	DEBUG_LL UART
In-Reply-To: <20110906092816.GC3548@atomide.com>
References: <20110819113740.GF12527@S2100-06.ap.freescale.net>
	<20110819123238.GD8918@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1108191101560.20358@xanadu.home>
	<20110821091452.GH12028@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211258490.20358@xanadu.home>
	<20110821182604.GI28546@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211435320.20358@xanadu.home>
	<20110821191835.GA19678@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211522280.20358@xanadu.home>
	<20110906092816.GC3548@atomide.com>
Message-ID: <20110906093738.GJ6619@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2011 at 12:28:17PM +0300, Tony Lindgren wrote:
> Probably the best long term solution is to set up the debug uart based
> on DT data and initialize it in the uncompress code. Anybody debugging
> lower level stuff can certainly patch in the ucompress debug_ll code.

How do you do that before the MMU has been setup?  Are you going to
write a DT data parser in pure assembly to extract this information?
