From: joro@8bytes.org (Joerg Roedel)
Date: Sat, 10 Jul 2010 16:36:35 +0200
Subject: [RFC 3/3] mm: iommu: The Virtual Contiguous Memory Manager
In-Reply-To: <4C2D908E.9030309@codeaurora.org>
References: <1277877350-2147-1-git-send-email-zpfeffer@codeaurora.org>
	<1277877350-2147-3-git-send-email-zpfeffer@codeaurora.org>
	<20100701101746.3810cc3b.randy.dunlap@oracle.com>
	<20100701180241.GA3594@basil.fritz.box>
	<AANLkTinABCSdN6hnXVOvVZ12f1QBMR_UAi62qW8GmlkL@mail.gmail.com>
	<4C2D908E.9030309@codeaurora.org>
Message-ID: <20100710143635.GA10080@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 02, 2010 at 12:09:02AM -0700, Zach Pfeffer wrote:
> Hari Kanigeri wrote:
> >> He demonstrated the usage of his code in one of the emails he sent out
> >> initially. Did you go over that, and what (or how many) step would you
> >> use with the current code to do the same thing?
> > 
> > -- So is this patch set adding layers and abstractions to help the User ?
> > 
> > If the idea is to share some memory across multiple devices, I guess
> > you can achieve the same by calling the map function provided by iommu
> > module and sharing the mapped address to the 10's or 100's of devices
> > to access the buffers. You would only need a dedicated virtual pool
> > per IOMMU device to manage its virtual memory allocations.
> 
> Yeah, you can do that. My idea is to get away from explicit addressing
> and encapsulate the "device address to physical address" link into a
> mapping.

The DMA-API already does this with the help of IOMMUs if they are
present. What is the benefit of your approach over that?

	Joerg
