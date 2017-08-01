From: s-anna@ti.com (Suman Anna)
Date: Tue, 1 Aug 2017 12:38:10 -0500
Subject: [PATCH 2/2] iommu/omap: Use DMA-API for performing cache flushes
In-Reply-To: <1501274954-20973-3-git-send-email-j-albarran@ti.com>
References: <1501274954-20973-1-git-send-email-j-albarran@ti.com>
 <1501274954-20973-3-git-send-email-j-albarran@ti.com>
Message-ID: <9e59b00e-a6d9-b0a8-8da6-6724d93c3e58@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28/2017 03:49 PM, Josue Albarran wrote:
> The OMAP IOMMU driver was using ARM assembly code directly for
> flushing the MMU page table entries from the caches. This caused
> MMU faults on OMAP4 (Cortex-A9 based SoCs) as L2 caches were not
> handled due to the presence of a PL310 L2 Cache Controller. These
> faults were however not seen on OMAP5/DRA7 SoCs (Cortex-A15 based
> SoCs).
> 
> The OMAP IOMMU driver is adapted to use the DMA Streaming API
> instead now to flush the page table/directory table entries from
> the CPU caches. This ensures that the devices always see the
> updated page table entries. The outer caches are now addressed
> automatically with the usage of the DMA API.
> 
> Signed-off-by: Josue Albarran <j-albarran@ti.com>

Thanks for fixing this,
Acked-by: Suman Anna <s-anna@ti.com>

[snip]
