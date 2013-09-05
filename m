From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Sep 2013 17:09:05 +0100
Subject: [PATCH v5 11/13] xen: introduce xen_alloc/free_coherent_pages
In-Reply-To: <1377801154-29215-11-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1308291917290.6397@kaball.uk.xensource.com>
 <1377801154-29215-11-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <20130905160905.GI11887@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 29, 2013 at 07:32:32PM +0100, Stefano Stabellini wrote:
> xen_swiotlb_alloc_coherent needs to allocate a coherent buffer for cpu
> and devices. On native x86 and ARMv8 is sufficient to call
> __get_free_pages in order to get a coherent buffer, while on ARM we need
> to call arm_dma_ops.alloc.

Don't bet on this for ARMv8. It's not mandated for the architecture, so
at some point some SoC will require non-cacheable buffers for coherency.

-- 
Catalin
