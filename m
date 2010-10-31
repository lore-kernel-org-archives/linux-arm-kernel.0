From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 31 Oct 2010 20:52:10 +0000
Subject: ep93xx/ts72xx: Kernel 2.6.36 problems introduced with commit
	5bc23d32d
In-Reply-To: <20101031190833.GA15069@ibawizard.net>
References: <20101031182157.GY15069@ibawizard.net>
	<20101031183140.GA30636@n2100.arm.linux.org.uk>
	<20101031190034.GZ15069@ibawizard.net>
	<20101031190833.GA15069@ibawizard.net>
Message-ID: <20101031205210.GB30636@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 31, 2010 at 08:08:33PM +0100, Petr ?tetiar wrote:
> Petr ?tetiar <ynezz@true.cz> [2010-10-31 20:00:34]:
> 
> > 	root at ts72xx:~# ifup ra0
> > 	WPA: Configuring Interface
> > 	[   30.900000] arm_vmregion_alloc() size: 33000
> > 	[   30.910000] arm_vmregion_alloc() found: start: 4291297280 end: 4291506176 size: 33000
> > 	[   30.920000] arm_vmregion_alloc() size: 33000
> > 	[   30.930000] arm_vmregion_alloc() found: start: 4291821568 end: 4292030464 size: 33000
> > 	[   30.940000] arm_vmregion_alloc() size: 33000
> > 	[   30.950000] arm_vmregion_alloc() found: start: 4292345856 end: 4292554752 size: 33000
> > 	[   30.960000] arm_vmregion_alloc() size: 33000
> > 	[   30.970000] arm_vmregion_alloc() no space!
> > 	[   30.970000] <-- ERROR in Alloc TX TxContext[3] HTTX_BUFFER !!

It's being a little too over-cautious.  In arch/arm/mm/dma-mapping.c
__dma_alloc_remap, remove the + 1 from "bit = fls(size - 1) + 1;".
