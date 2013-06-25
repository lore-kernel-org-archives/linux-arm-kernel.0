From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Jun 2013 13:34:14 +0100
Subject: [PATCH 3/9] ARM: dma-mapping: convert DMA direction into IOMMU
 protection attributes
In-Reply-To: <20130625.145226.1632119404634300971.hdoyu@nvidia.com>
References: <1370889285-22799-4-git-send-email-will.deacon@arm.com>
 <20130625131215.d3cea2a5668a3d41dbbeb064@nvidia.com>
 <20130625113714.GF31838@mudshark.cambridge.arm.com>
 <20130625.145226.1632119404634300971.hdoyu@nvidia.com>
Message-ID: <20130625123414.GG31838@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 25, 2013 at 12:52:26PM +0100, Hiroshi Doyu wrote:
> Will Deacon <will.deacon@arm.com> wrote @ Tue, 25 Jun 2013 13:37:14 +0200:
> ...
> > > Do we need similar changes for map_sg case as well? They still passes '0' as prot.
> > 
> > Yes, we could use the same trick there (probably worth moving the logic into
> > a helper function for translating dma_data_direction into IOMMU_* values).
> > 
> > There are also iommu_map calls when allocating DMA buffers, but I think 0 is
> > the right thing to pass there (i.e. no permission until pages have been
> > explicitly mapped). Although, to be honest, I don't see why we need to map
> > the buffer at all when we allocate it.
> 
> Yes, I thought too. I have a patch for that as below. If you like,
> I'll rebase and send for merge with the one which changes
> dma-mapping.c.

Yes, please send the series and I'll take a look. Marek's already picked up
my original patch, so it's better if you can base against a stable branch
from him.

Will
