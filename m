From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 7 Nov 2014 11:11:28 +0000
Subject: [PATCH v7 3/8] arm64: introduce is_device_dma_coherent
In-Reply-To: <20141107110524.GA21875@localhost>
References: <alpine.DEB.2.02.1410261621200.22875@kaball.uk.xensource.com>
 <1414422568-19103-3-git-send-email-stefano.stabellini@eu.citrix.com>
 <alpine.DEB.2.02.1411031045340.22875@kaball.uk.xensource.com>
 <20141103105716.GC23162@arm.com>
 <alpine.DEB.2.02.1411031101400.22875@kaball.uk.xensource.com>
 <20141105165646.GN32700@e104818-lin.cambridge.arm.com>
 <alpine.DEB.2.02.1411051757140.22875@kaball.uk.xensource.com>
 <20141106103337.GA19702@e104818-lin.cambridge.arm.com>
 <alpine.DEB.2.02.1411061155200.22875@kaball.uk.xensource.com>
 <20141107110524.GA21875@localhost>
Message-ID: <20141107111126.GB21875@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 07, 2014 at 11:05:25AM +0000, Catalin Marinas wrote:
> BTW, drivers/xen/swiotlb-xen.c needs something like:
> 
>         dma_addr_t dev_addr = xen_phys_to_bus(phys_to_dma(phys));
> 
> phys != bus address.

Wrong place, what I meant is when calling:

        xen_dma_unmap_page(hwdev, phys_to_dma(paddr), size, dir, attrs);

-- 
Catalin
