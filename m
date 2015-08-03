From: joro@8bytes.org (Joerg Roedel)
Date: Mon, 3 Aug 2015 16:27:16 +0200
Subject: [PATCH v2 17/25] intel-iommu: switch from ioremap_cache to
 memremap
In-Reply-To: <20150725023933.8664.85856.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150725023933.8664.85856.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <20150803142716.GC20968@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 10:39:33PM -0400, Dan Williams wrote:
> In preparation for deprecating ioremap_cache() convert its usage in
> intel-iommu to memremap.  This also eliminates the mishandling of the
> __iomem annotation in the implementation.
> 
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Joerg Roedel <joro@8bytes.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/iommu/intel-iommu.c         |   10 ++++++----
>  drivers/iommu/intel_irq_remapping.c |    4 ++--
>  2 files changed, 8 insertions(+), 6 deletions(-)

Acked-by: Joerg Roedel <jroedel@suse.de>
