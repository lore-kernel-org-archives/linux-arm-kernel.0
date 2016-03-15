From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 15 Mar 2016 01:22:54 -0700
Subject: [PATCH v5 3/9] dma-mapping: add dma_{map,unmap}_resource
In-Reply-To: <20160311125846.GF1111@bigcity.dyn.berto.se>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1457404974-1800-4-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <20160308073847.GA15520@infradead.org>
 <20160310160522.GB1111@bigcity.dyn.berto.se>
 <CAPcyv4gO4EZnBuVKXT8+gsMhbHJzuK7sfr0uRcjVdJP-nUUz4A@mail.gmail.com>
 <20160311111522.GA3450@infradead.org>
 <20160311125846.GF1111@bigcity.dyn.berto.se>
Message-ID: <20160315082254.GE9136@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 11, 2016 at 01:58:46PM +0100, Niklas S?derlund wrote:
> Without an IOMMU this is easy since the phys_addr_t and dma_addr_t are 
> the same and no special care is needed. However if you have a IOMMU you 
> need to map the DMA slave phys_addr_t to a dma_addr_t using something 
> like this. Is it not very similar to dma_map_single() where one maps 
> processor virtual memory (instead if MMIO) so that it can be used with 
> DMA slaves?

It's similar, but I don't think this actually works as a general case
as there are quite a few places that expect to be able to have a
struct page for a physical address.  We'd at least need a very careful
audit for that case.
