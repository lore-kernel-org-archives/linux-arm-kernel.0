From: tony@atomide.com (Tony Lindgren)
Date: Tue, 6 Sep 2011 03:27:03 -0700
Subject: [PATCH 1/3] ARM: debug: use kconfig choice for selecting
	DEBUG_LL UART
In-Reply-To: <20110906093738.GJ6619@n2100.arm.linux.org.uk>
References: <20110819123238.GD8918@e102144-lin.cambridge.arm.com>
	<alpine.LFD.2.00.1108191101560.20358@xanadu.home>
	<20110821091452.GH12028@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211258490.20358@xanadu.home>
	<20110821182604.GI28546@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211435320.20358@xanadu.home>
	<20110821191835.GA19678@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1108211522280.20358@xanadu.home>
	<20110906092816.GC3548@atomide.com>
	<20110906093738.GJ6619@n2100.arm.linux.org.uk>
Message-ID: <20110906102703.GA1895@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110906 02:04]:
> On Tue, Sep 06, 2011 at 12:28:17PM +0300, Tony Lindgren wrote:
> > Probably the best long term solution is to set up the debug uart based
> > on DT data and initialize it in the uncompress code. Anybody debugging
> > lower level stuff can certainly patch in the ucompress debug_ll code.
> 
> How do you do that before the MMU has been setup?  Are you going to
> write a DT data parser in pure assembly to extract this information?

Don't we already have that with ATAGs to DT support in the DT append
patches? At least it calls fdt_setprop so calling fdt_getprop should
also work. The patch I'm talking about is:

http://permalink.gmane.org/gmane.linux.drivers.devicetree/5938 

Tony
