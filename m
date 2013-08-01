From: david.vrabel@citrix.com (David Vrabel)
Date: Thu, 1 Aug 2013 13:19:46 +0100
Subject: [PATCH v2 RFC 7/8] swiotlb-xen: support autotranslate guests
In-Reply-To: <1375300452-12545-7-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1307312048511.4893@kaball.uk.xensource.com>
 <1375300452-12545-7-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <51FA5262.6090604@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/07/13 20:54, Stefano Stabellini wrote:
> Support autotranslate guests in swiotlb-xen by keeping track of the
> phys-to-bus and bus-to-phys mappings of the swiotlb buffer
> (xen_io_tlb_start-xen_io_tlb_end).
> 
> Use a simple direct access on a pre-allocated array for phys-to-bus
> queries. Use a red-black tree for bus-to-phys queries.

It would be nice if the dma_map_page() etc. returned a unique handle in
addition to the dma_addr_t so the lookup on unmap could be cheaper, but
in the absence of this.

Reviewed-by: David Vrabel <david.vrabel@citrix.com>

David
