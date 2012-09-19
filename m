From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 19 Sep 2012 21:01:57 +0000 (UTC)
Subject: [PATCH v2 1/9] ARM: OMAP: iommu: fix including iommu.h without
 IOMMU_API selected
In-Reply-To: <1347479152-588-2-git-send-email-omar.luna@linaro.org>
References: <1347479152-588-1-git-send-email-omar.luna@linaro.org>
 <1347479152-588-2-git-send-email-omar.luna@linaro.org>
Message-ID: <alpine.DEB.2.00.1209192101450.5264@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Sep 2012, Omar Ramirez Luna wrote:

> If included without IOMMU_API being selected it will break
> compilation:
> 
> arch/arm/plat-omap/include/plat/iommu.h:
> 	In function 'dev_to_omap_iommu':
> arch/arm/plat-omap/include/plat/iommu.h:148:
> 	error: 'struct dev_archdata' has no member named 'iommu'
> 
> This will be seen when hwmod includes iommu.h to get the
> structure for attributes. Also needed for tidspbridge
> incremental migration to use iommu code.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Omar Ramirez Luna <omar.luna@linaro.org>

Thanks, queued for 3.7.

- Paul
