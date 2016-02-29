From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 29 Feb 2016 16:47:51 +0000
Subject: [PATCH 04/12] arm64/dma-mapping: Extend DMA ops workaround to
 PCI devices
In-Reply-To: <ffcca878210c916962c562d3d1341aae93d593d0.1456514380.git.robin.murphy@arm.com>
References: <cover.1456514380.git.robin.murphy@arm.com>
 <ffcca878210c916962c562d3d1341aae93d593d0.1456514380.git.robin.murphy@arm.com>
Message-ID: <20160229164750.GA15650@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 01:46:13PM +0000, Robin Murphy wrote:
> PCI devices now suffer the same hiccup as platform devices, in that they
> get their DMA ops configured before they have been added to their bus,
> and thus before we know whether they have successfully registered with
> an IOMMU or not. Until the necessary driver core changes to reorder
> calls during device creation have been worked out, extend our delayed
> notifier trick onto the PCI bus so as to avoid broken DMA ops for IOMMUs
> there.
> 
> CC: Catalin Marinas <catalin.marinas@arm.com>
> CC: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
