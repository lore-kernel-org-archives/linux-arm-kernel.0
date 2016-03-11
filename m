From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 11 Mar 2016 03:15:22 -0800
Subject: [PATCH v5 3/9] dma-mapping: add dma_{map,unmap}_resource
In-Reply-To: <CAPcyv4gO4EZnBuVKXT8+gsMhbHJzuK7sfr0uRcjVdJP-nUUz4A@mail.gmail.com>
References: <1457404974-1800-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1457404974-1800-4-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <20160308073847.GA15520@infradead.org>
 <20160310160522.GB1111@bigcity.dyn.berto.se>
 <CAPcyv4gO4EZnBuVKXT8+gsMhbHJzuK7sfr0uRcjVdJP-nUUz4A@mail.gmail.com>
Message-ID: <20160311111522.GA3450@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2016 at 10:47:10PM -0800, Dan Williams wrote:
> I think it is confusing to use the dma_ prefix for this peer-to-peer
> mmio functionality.  dma_addr_t is a device's view of host memory.
> Something like bus_addr_t bus_map_resource().  Doesn't this routine
> also need the source device in addition to the target device?  The
> resource address is from the perspective of the host cpu, it may be a
> different address space in the view of two devices relative to each
> other.

Is it supposed to be per-mmio?  It's in dma-mapping ops, and has dma
in the name, so I suspected it's for some form of peer dma.  But given
that our dma APIs reuqire a struct page backing I have no idea how this
even supposed to work, and this little documentation blurb still doesn't
clear that up.

So for now I'd like to NAK this patch until the use case can be
explained clearly, and actually works.
