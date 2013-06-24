From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 24 Jun 2013 09:21:28 +0200
Subject: [RFC 0/3] How to pass IOMMU map attr via DMA API?
In-Reply-To: <20130624081759.76e66d42bbf7c2c54ed1975c@nvidia.com>
References: <1371707384-30037-1-git-send-email-hdoyu@nvidia.com>
 <51C3FE27.5070702@samsung.com> <20130621160344.GM11309@8bytes.org>
 <20130624081759.76e66d42bbf7c2c54ed1975c@nvidia.com>
Message-ID: <20130624072128.GP11309@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 24, 2013 at 08:17:59AM +0300, Hiroshi Doyu wrote:
> Ok, thanks. One more question, IOMMU H/W sometimes supports more
> platform specific attributes than READ/WRITE. For example, in OMAP,
> 
>   #define IOMMU_FLAG	(IOVMF_ENDIAN_LITTLE | IOVMF_ELSZ_8)
> 
> Is there any way to deal with those platform specific attrs from DMA
> mapping API POV?

Depends on the kind of flag and whether you want to make it changeable
from the DMA-API. The AMD IOMMU for example has a flag in the
page-tables to force PCI DMA coherency. This is always set by the
driver.

For other parameters that should be changeable and don't fit into the
dma_direction parameter in some way the use of dma_attr would make
sense.


	Joerg
