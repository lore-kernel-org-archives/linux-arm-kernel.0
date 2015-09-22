From: will.deacon@arm.com (Will Deacon)
Date: Tue, 22 Sep 2015 17:26:34 +0100
Subject: [PATCH v2] iommu/io-pgtable-arm: Don't use dma_to_phys()
In-Reply-To: <56018074.2010104@arm.com>
References: <59f4ebbf06e75a6176a366495211afd16d0048a3.1442507940.git.robin.murphy@arm.com>
 <1442566550.8145.156.camel@mhfsdcap03> <55FBEFBA.6000606@arm.com>
 <1442928308.17514.3.camel@mhfsdcap03> <56018074.2010104@arm.com>
Message-ID: <20150922162633.GL7356@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 22, 2015 at 05:23:16PM +0100, Robin Murphy wrote:
> On 22/09/15 14:25, Yong Wu wrote:
> [...]
> > About here:
> >> @@ -629,6 +626,11 @@ arm_lpae_alloc_pgtable(struct io_pgtable_cfg
> > *cfg)
> >>        if (cfg->oas > ARM_LPAE_MAX_ADDR_BITS)
> >>                return NULL;
> >>   
> >> +     if (cfg->iommu_dev->dma_pfn_offset) {
> > 
> > Do we need change to :
> > 	if (!selftest_running && cfg->iommu_dev->dma_pfn_offset) {
> > 
> > cfg->iommu_dev will be null while self test.
> 
> Urgh, you're absolutely right. Must have been one of those days when I
> had loads of noisy debug in there and turned the self-tests off :(
> 
> Will; since the branch hasn't gone anywhere yet, are you OK to take the below?

Yeah, no problem. I'll fold it in when I get a chance.

Will
