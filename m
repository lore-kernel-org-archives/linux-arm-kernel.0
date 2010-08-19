From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Thu, 19 Aug 2010 20:31:22 +1000
Subject: ARM: 2.6.3[45] PCI regression (IXP4xx and PXA?)
In-Reply-To: <20100814181306U.fujita.tomonori@lab.ntt.co.jp>
References: <20100811072532.GA21511@n2100.arm.linux.org.uk>
	<20100813152224H.fujita.tomonori@lab.ntt.co.jp>
	<20100813215413.GA21607@n2100.arm.linux.org.uk>
	<20100814181306U.fujita.tomonori@lab.ntt.co.jp>
Message-ID: <1282213882.22370.360.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2010-08-14 at 18:30 +0900, FUJITA Tomonori wrote:
> 
> A long solution would be having two dma_mask for a device and a
> bus. We also need something to represent a DMA-capable range instead
> of the dma mask.

I'd rather have the arch (aka the bus) be able to filter the mask,
better than having to deal with multiple masks in the generic code.
Besides, in embedded-land, you never know how many busses are stacked
before you reach the device, ie, you'd end up having to AND quite a few
masks before getting there in some cases.

Sounds better to establish that once, at set_coherent_dma_mask() time.

Cheers,
Ben.
