From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Jun 2013 11:12:22 +0100
Subject: [RFC 0/3] How to pass IOMMU map attr via DMA API?
In-Reply-To: <20130620.125929.2250094502232662356.hdoyu@nvidia.com>
References: <1371707384-30037-1-git-send-email-hdoyu@nvidia.com>
 <20130620093152.GE2842@mudshark.cambridge.arm.com>
 <20130620.125929.2250094502232662356.hdoyu@nvidia.com>
Message-ID: <20130620101222.GF2842@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 20, 2013 at 10:59:29AM +0100, Hiroshi Doyu wrote:
> Hi Will,

Hi Hiroshi,

> Will Deacon <will.deacon@arm.com> wrote @ Thu, 20 Jun 2013 11:31:52 +0200:
> 
> > > Hiroshi Doyu (3):
> > >   common: DMA-mapping: add DMA_ATTR_READ_ONLY attribute
> > >   ARM: dma-mapping: Pass DMA attrs as IOMMU prot
> > >   iommu/tegra: smmu: Support read-only mapping
> > 
> > These patches don't seem to have made it to the linux-arm-kernel list
> > (either in my inbox or the list archive). Could you try and resend them please?
> 
> I'm sorry but linux-arm-kernel list someitmes requires me moderators
> approval. I don't know why. I'll find a way to work around.

Strange. It would definitely be good to get that fixed!

> Here are links for the original post:
> 
> http://lists.linuxfoundation.org/pipermail/iommu/2013-June/005860.html
> http://lists.linuxfoundation.org/pipermail/iommu/2013-June/005861.html
> http://lists.linuxfoundation.org/pipermail/iommu/2013-June/005862.html
> http://lists.linuxfoundation.org/pipermail/iommu/2013-June/005863.html

Thanks, but I can't reply inline to those :)

> > Also: how do they interact with my patch here?:
> > 
> >   http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/175124.html
> 
> This conversion looks reasonable enough, but some platform may need
> more attrs to pass IOMMU like OMAP.
> 
>   #define IOMMU_FLAG	(IOVMF_ENDIAN_LITTLE | IOVMF_ELSZ_8)
> 
> How can we deal with those cases?

Well, if we have weird and wonderful flags like this, which are
IOMMU-specific, then I'd suggest short-circuiting the flags altogether and
putting them inside somewhere like dev_archdata.iommu.

Will
