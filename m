From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 10:42:15 +0100
Subject: [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <1303939866.2513.180.camel@pasglop>
References: <201104212129.17013.arnd@arndb.de>
	<1303939866.2513.180.camel@pasglop>
Message-ID: <20110428094215.GW17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2011 at 07:31:06AM +1000, Benjamin Herrenschmidt wrote:
> The question remains, if we ever want to do more complex demand-paged
> operations, should we also expose a lower level set of functions to get
> struct page out of a dma_alloc_coherent() allocation and to get the
> pgprot for the user dma mapping ?

I don't think so - that places the requirement that dma_alloc_coherent()
must be backed by memory with a set of struct page, which may not always
be the case.

Think about dma_alloc_coherent() with dma_declare_coherent_memory() used
with memory which is not part of system RAM.
