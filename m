From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 13 Jul 2010 09:20:12 +0100
Subject: [RFC 3/3] mm: iommu: The Virtual Contiguous Memory Manager
In-Reply-To: <20100713145852C.fujita.tomonori@lab.ntt.co.jp>
References: <4C2D965F.5000206@codeaurora.org>
	<20100710145639.GC10080@8bytes.org>
	<4C3BFDD3.8040209@codeaurora.org>
	<20100713145852C.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <20100713092012.7c1fe53e@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Why video4linux can't use the DMA API? Doing DMA with vmalloc'ed
> buffers is a thing that we should avoid (there are some exceptions
> like xfs though).

Vmalloc is about the only API for creating virtually linear memory areas.
The video stuff really needs that to avoid lots of horrible special cases
when doing buffer processing and the like.

Pretty much each driver using it has a pair of functions 'rvmalloc' and
'rvfree' so given a proper "vmalloc_for_dma()" type interface can easily
be switched

Alan
