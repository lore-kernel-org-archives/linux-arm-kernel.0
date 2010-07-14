From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 14 Jul 2010 21:34:03 +0200
Subject: [RFC 3/3] mm: iommu: The Virtual Contiguous Memory Manager
In-Reply-To: <4C3BF7C1.9040904@codeaurora.org>
References: <1277877350-2147-1-git-send-email-zpfeffer@codeaurora.org>
	<1277877350-2147-3-git-send-email-zpfeffer@codeaurora.org>
	<20100701101746.3810cc3b.randy.dunlap@oracle.com>
	<20100701180241.GA3594@basil.fritz.box>
	<AANLkTinABCSdN6hnXVOvVZ12f1QBMR_UAi62qW8GmlkL@mail.gmail.com>
	<4C2D908E.9030309@codeaurora.org>
	<20100710143635.GA10080@8bytes.org>
	<4C3BF7C1.9040904@codeaurora.org>
Message-ID: <20100714193403.GC23755@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 12, 2010 at 10:21:05PM -0700, Zach Pfeffer wrote:
> Joerg Roedel wrote:

> > The DMA-API already does this with the help of IOMMUs if they are
> > present. What is the benefit of your approach over that?
> 
> The grist to the DMA-API mill is the opaque scatterlist. Each
> scatterlist element brings together a physical address and a bus
> address that may be different. The set of scatterlist elements
> constitute both the set of physical buffers and the mappings to those
> buffers. My approach separates these two things into a struct physmem
> which contains the set of physical buffers and a struct reservation
> which contains the set of bus addresses (or device addresses). Each
> element in the struct physmem may be of various lengths (without
> resorting to chaining). A map call maps the one set to the other.

Okay, thats a different concept, where is the benefit?

	Joerg
