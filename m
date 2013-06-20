From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Jun 2013 10:31:52 +0100
Subject: [RFC 0/3] How to pass IOMMU map attr via DMA API?
In-Reply-To: <1371707384-30037-1-git-send-email-hdoyu@nvidia.com>
References: <1371707384-30037-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <20130620093152.GE2842@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hiroshi,

On Thu, Jun 20, 2013 at 06:49:41AM +0100, Hiroshi Doyu wrote:
> In Tegra SoC, IOMMU can set some mapping attribute for each page, for
> exmaple, READable, and WRITEable. We'd like to use this feature
> *newly* for robustness, where read-only pages can be protected from
> being overwritten by wrong operation. We have been using IOMMU via DMA
> mapping API(ARM). DMA mapping API currently doesn't use "prot"
> parameter when calling IOMMU API. So this series tries to pass "struct
> dma_attrs *attrs" via "int prot" in IOMMU API. I'm not so sure if this
> implementation is right or not because:
> 
> - Casting (struct dma_attrs *) to (int) in DMA API doesn't look nice.
> - IOMMU layer needs to cast (int) back to (struct dma_attrs *) again,
>   which can be considered as violation of layers.
> 
> If you have any implementations/suggestions, it would be really helpful.
> 
> This series isn't applied cleanly but this is posted to request for
> comments.
> 
> Hiroshi Doyu (3):
>   common: DMA-mapping: add DMA_ATTR_READ_ONLY attribute
>   ARM: dma-mapping: Pass DMA attrs as IOMMU prot
>   iommu/tegra: smmu: Support read-only mapping

These patches don't seem to have made it to the linux-arm-kernel list
(either in my inbox or the list archive). Could you try and resend them please?

Also: how do they interact with my patch here?:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2013-June/175124.html

Will
