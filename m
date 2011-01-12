From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 12 Jan 2011 14:04:12 -0500 (EST)
Subject: [PATCHv8 00/12] Contiguous Memory Allocator
In-Reply-To: <001c01cbb289$864391f0$92cab5d0$%szyprowski@samsung.com>
References: <cover.1292443200.git.m.nazarewicz@samsung.com>
	<AANLkTim8_=0+-zM5z4j0gBaw3PF3zgpXQNetEn-CfUGb@mail.gmail.com>
	<20101223100642.GD3636@n2100.arm.linux.org.uk>
	<00ea01cba290$4d67f500$e837df00$%szyprowski@samsung.com>
	<20101223121917.GG3636@n2100.arm.linux.org.uk>
	<00ec01cba2a2$af20b8b0$0d622a10$%szyprowski@samsung.com>
	<20101223134432.GJ3636@n2100.arm.linux.org.uk>
	<001c01cbb289$864391f0$92cab5d0$%szyprowski@samsung.com>
Message-ID: <alpine.LFD.2.00.1101121357580.25498@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Jan 2011, Marek Szyprowski wrote:

> I understand that modifying L1 page tables is definitely not a proper way of
> handling this. It simply costs too much. But what if we consider that the DMA
> memory can be only allocated from a specific range of the system memory?
> Assuming that this range of memory is known during the boot time, it CAN be
> mapped with two-level of tables in MMU. First level mapping will stay the
> same all the time for all processes, but it would be possible to unmap the
> pages required for DMA from the second level mapping what will be visible
> from all the processes at once.

How much memory are we talking about?  What is the typical figure?

> Is there any reason why such solution won't work?

It could work indeed.

One similar solution that is already in place is to use highmem for that 
reclaimable DMA memory.  It is easy to ensure affected highmem pages are 
not mapped in kernel space.  And you can decide at boot time how many 
highmem pages you want even if the system has less that 1GB of RAM.


Nicolas
