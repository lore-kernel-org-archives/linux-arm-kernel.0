From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 4 Jul 2011 16:45:29 +0200
Subject: [Linaro-mm-sig] [PATCH 08/10] mm: cma: Contiguous Memory
	Allocator added
In-Reply-To: <20110704052539.GK12667@in.ibm.com>
References: <1307699698-29369-1-git-send-email-m.szyprowski@samsung.com>
	<201106160006.07742.arnd@arndb.de>
	<20110704052539.GK12667@in.ibm.com>
Message-ID: <201107041645.29385.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 04 July 2011, Ankita Garg wrote:
> > It still sounds to me that this can be done using the NUMA properties
> > that Linux already understands, and teaching more subsystems about it,
> > but maybe the memory hotplug developers have already come up with
> > another scheme. The way that memory hotplug and CMA choose their
> > memory regions certainly needs to take both into account. As far as
> > I can see there are both conflicting and synergistic effects when
> > you combine the two.
> > 
> 
> Recently, we proposed a generic 'memory regions' framework to exploit
> the memory power management capabilities on the embedded boards. Think
> of some of the above CMA requirements could be met by this fraemwork.
> One of the main goals of regions is to make the VM aware of the hardware
> memory boundaries, like bank. For managing memory power consumption,
> memory regions are created aligned to the hardware granularity at which
> the power can be managed (ie, the memory power consumption operations
> like on/off can be performed). If attributed are associated with each of
> these regions, some of these regions could be marked as CMA-only,
> ensuring that only movable and per-bank memory is allocated. More
> details on the design can be found here:
> 
> http://lkml.org/lkml/2011/5/27/177
> http://lkml.org/lkml/2011/6/29/202
> http://lwn.net/Articles/446493/

Thanks for the pointers, that is exactly what I was looking for.

	Arnd
