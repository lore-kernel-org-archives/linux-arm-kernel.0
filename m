From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 20 Jun 2013 11:59:29 +0200
Subject: [RFC 0/3] How to pass IOMMU map attr via DMA API?
In-Reply-To: <20130620093152.GE2842@mudshark.cambridge.arm.com>
References: <1371707384-30037-1-git-send-email-hdoyu@nvidia.com><20130620093152.GE2842@mudshark.cambridge.arm.com>
Message-ID: <20130620.125929.2250094502232662356.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Will Deacon <will.deacon@arm.com> wrote @ Thu, 20 Jun 2013 11:31:52 +0200:

> > Hiroshi Doyu (3):
> >   common: DMA-mapping: add DMA_ATTR_READ_ONLY attribute
> >   ARM: dma-mapping: Pass DMA attrs as IOMMU prot
> >   iommu/tegra: smmu: Support read-only mapping
> 
> These patches don't seem to have made it to the linux-arm-kernel list
> (either in my inbox or the list archive). Could you try and resend them please?

I'm sorry but linux-arm-kernel list someitmes requires me moderators
approval. I don't know why. I'll find a way to work around.

Here are links for the original post:

http://lists.linuxfoundation.org/pipermail/iommu/2013-June/005860.html
http://lists.linuxfoundation.org/pipermail/iommu/2013-June/005861.html
http://lists.linuxfoundation.org/pipermail/iommu/2013-June/005862.html
http://lists.linuxfoundation.org/pipermail/iommu/2013-June/005863.html

> Also: how do they interact with my patch here?:
> 
>   http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/175124.html

This conversion looks reasonable enough, but some platform may need
more attrs to pass IOMMU like OMAP.

  #define IOMMU_FLAG	(IOVMF_ENDIAN_LITTLE | IOVMF_ELSZ_8)

How can we deal with those cases?
