From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Wed, 17 Feb 2010 23:15:41 +1100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <201002171123.30389.oliver@neukum.org>
References: <20100208065519.GE1290@ucw.cz>
	<201002171109.32107.oliver@neukum.org>
	<1266401881.16346.278.camel@pasglop>
	<201002171123.30389.oliver@neukum.org>
Message-ID: <1266408941.16346.283.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-02-17 at 11:23 +0100, Oliver Neukum wrote:
> 
> The request a low-level driver does is all or nothing. Either DMA
> issues have to be handled by that driver alone, or a finer-grained
> description of the DMA requirements is needed. A fix using the latter
> approach is being worked on. 

Well, that's what I'm trying to understand.

IE. It's a pretty strong rule ... don't do CPU accesses between dma_map
and unmap. So it's all in driver land at that stage. I'm not sure how
the DMA requirements get into the picture here. IE. That rule is
globally true. It's not going to hurt just non-coherent archs, it's
going to hurt anybody using swiotlb too... So I don't see you need more
info about the DMA requirements, but maybe I did miss something :-)

Cheers,
Ben.
