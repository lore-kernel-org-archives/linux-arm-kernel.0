From: cl@linux.com (Christoph Lameter)
Date: Wed, 6 Jul 2011 11:19:00 -0500 (CDT)
Subject: [PATCH 6/8] drivers: add Contiguous Memory Allocator
In-Reply-To: <op.vx7ghajd3l0zgt@mnazarewicz-glaptop>
References: <1309851710-3828-1-git-send-email-m.szyprowski@samsung.com>
	<201107061609.29996.arnd@arndb.de>
	<20110706142345.GC8286@n2100.arm.linux.org.uk>
	<201107061651.49824.arnd@arndb.de>
	<20110706154857.GG8286@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1107061100290.17624@router.home>
	<op.vx7ghajd3l0zgt@mnazarewicz-glaptop>
Message-ID: <alpine.DEB.2.00.1107061114150.19547@router.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Jul 2011, Michal Nazarewicz wrote:

> On Wed, 06 Jul 2011 18:05:00 +0200, Christoph Lameter <cl@linux.com> wrote:
> > ZONE_DMA is a zone for memory of legacy (crippled) devices that cannot DMA
> > into all of memory (and so is ZONE_DMA32).  Memory from ZONE_NORMAL
> > can be used for DMA as well and a fully capable device would be expected
> > to handle any memory in the system for DMA transfers.
> >
> > "guaranteed" dmaable memory? DMA abilities are device specific. Well maybe
> > you can call ZONE_DMA memory to be guaranteed if you guarantee
> > that any device must at mininum be able to perform DMA into ZONE_DMA
> > memory. But there may not be much of that memory around so you would
> > want to limit the use of that scarce resource.
>
> As pointed in Marek's other mail, this reasoning is not helping in any
> way.  In case of video codec on various Samsung devices (and from some
> other threads this is not limited to Samsung), the codec needs separate
> buffers in separate memory banks.

What I described is the basic memory architecture of Linux. I am not that
familiar with ARM and the issue discussed here. Only got involved because
ZONE_DMA was mentioned. The nature of ZONE_DMA is often misunderstood.

The allocation of the memory banks for the Samsung devices has to fit
somehow into one of these zones. Its probably best to put the memory banks
into ZONE_NORMAL and not have any dependency on ZONE_DMA at all.
