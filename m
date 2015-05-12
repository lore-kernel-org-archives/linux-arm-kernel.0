From: will.deacon@arm.com (Will Deacon)
Date: Tue, 12 May 2015 13:30:57 +0100
Subject: [PATCH 4/4] arm64: gicv3: its: Increase FORCE_MAX_ZONEORDER for
 Cavium ThunderX
In-Reply-To: <20150511091438.GW4251@rric.localhost>
References: <1430686172-18222-1-git-send-email-rric@kernel.org>
 <1430686172-18222-5-git-send-email-rric@kernel.org>
 <20150505105329.GC1550@arm.com>
 <20150511091438.GW4251@rric.localhost>
Message-ID: <20150512123056.GA2062@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 11, 2015 at 10:14:38AM +0100, Robert Richter wrote:
> On 05.05.15 11:53:29, Will Deacon wrote:
> > On Sun, May 03, 2015 at 09:49:32PM +0100, Robert Richter wrote:
> > > From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> > > 
> > > In case of ARCH_THUNDER, there is a need to allocate the GICv3 ITS table
> > > which is bigger than the allowed max order. So we are forcing it only in
> > > case of 4KB page size.
> > 
> > Does this problem disappear if the ITS driver uses dma_alloc_coherent
> > instead? That would also allow us to remove the __flush_dcache_area abuse
> > from the driver.
> 
> __get_free_pages() is also used internally in dma_alloc_coherent().
> 
> There is another case if the device brings dma mem with it. I am not
> sure if it would be possible to assign some phys memory via devicetree
> to the interrupt controller and then assign that range for its table
> allocation.
> 
> Another option would be to allocate a hugepage. This would require
> setting up hugepages during boottime. I need to figure out whether
> that could work.
> 
> What about on the remaining 3 patches?

Marc would be the best guy to review those, but he's on holiday for a couple
of weeks at the moment.

Will
