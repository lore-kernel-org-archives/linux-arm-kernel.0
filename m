From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 28 Apr 2011 12:27:21 +0200
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <201104212129.17013.arnd@arndb.de>
References: <201104212129.17013.arnd@arndb.de>
Message-ID: <20110428102720.GA13402@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 21, 2011 at 09:29:16PM +0200, Arnd Bergmann wrote:
> 4. Implement an architecture independent version of dma_map_ops
>    based on the iommu.h API. As Joerg mentioned, this has been
>    missing for some time, and it would be better to do it once
>    than for each IOMMU separately. This is probably a lot of work.

Yes, thats missing for a long time. It will also need some changes to
the IOMMU-API but that should be doable. The best would be to extend the
IOMMU-API so that it also supports GART-like IOMMUs. This way every
dma_ops implementation on all the architectures providing such an IOMMU
could be covered with the architecture independent dma_ops
implementation. This would only leave the low-level hardware access in
the IOMMU drivers.
I think this also requires to change the current semantics of the
existing IOMMU-API implementations. I will prepare a write-up of my
ideas for discussion.

Regards,

	Joerg
