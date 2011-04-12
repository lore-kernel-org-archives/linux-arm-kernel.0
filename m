From: gerg@snapgear.com (Greg Ungerer)
Date: Wed, 13 Apr 2011 04:02:22 +1000
Subject: about uclinux for armnommu dma allocate issue
In-Reply-To: <BANLkTikkzWZcfeic8qUeLKLr5+ef14eA4g@mail.gmail.com>
References: <BANLkTikkzWZcfeic8qUeLKLr5+ef14eA4g@mail.gmail.com>
Message-ID: <4DA493AE.3040007@snapgear.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wan,

On 11/04/11 00:04, Wan ZongShun wrote:
> I am programming ohci driver for my arm7 based on 2.6.38.
>
> td_alloc ->  dma_pool_alloc ->  dma_alloc_coherent().
>
> In previous uclinux version, there is the consistent.c located in
> arch/armnommu/mm to implement
> this dma_alloc_coherent, but now this latest version, I did not see
> this 'dma_alloc_coherent' function
> for armnommu, so I can use this function directly like this arm mmu?

Yes. There is no separate one for the nommu case. It just
uses the standard one in arch/arm/mm/dma-mapping.c.


> In addtion, the 'kmalloc' is the same to previous uclinux armnommu
> version? I can use it directly?

Oh, yes. There is no changes in how that works.

Regards
Greg
