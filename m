From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 21 May 2014 18:11:55 +0200
Subject: [PATCH v2 00/10] Renesas ipmmu-vmsa: Miscellaneous cleanups and
 fixes
In-Reply-To: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1400150451-13469-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1419363.GGUKXiAPyI@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

Ping ?

On Thursday 15 May 2014 12:40:41 Laurent Pinchart wrote:
> Hello,
> 
> This patch set cleans up and fixes small issues in the ipmmu-vmsa driver.
> The patches are based on top of "[PATCH v3] iommu: Add driver for Renesas
> VMSA-compatible IPMMU" that adds the ipmmu-vmsa driver.
> 
> The most interesting part of this series is the rewrite of the page table
> management code. The IOMMU core guarantees that the map and unmap operations
> will always be called only with page sizes advertised by the driver. We can
> use that assumption to remove loops of PGD and PMD entries, simplifying the
> code.
> 
> Joerg, is there still time to get this merged in v3.16 ? The patches have
> all been posted previously and the only comment I've received was about a
> missing #define in patch 04/10.
> 
> Cc: Joerg Roedel <joro@8bytes.org>
> 
> Changes since v1:
> 
> - Add missing IPMMU_PTRS_PER_PUD definition in patch 04/10
> 
> Laurent Pinchart (10):
>   iommu/ipmmu-vmsa: Refactor micro-TLB lookup
>   iommu/ipmmu-vmsa: Cleanup failures of ARM mapping creation or
>     attachment
>   iommu/ipmmu-vmsa: Fix the supported page sizes
>   iommu/ipmmu-vmsa: Define driver-specific page directory sizes
>   iommu/ipmmu-vmsa: Set the PTE contiguous hint bit when possible
>   iommu/ipmmu-vmsa: PMD is never folded, PUD always is
>   iommu/ipmmu-vmsa: Rewrite page table management
>   iommu/ipmmu-vmsa: Support 2MB mappings
>   iommu/ipmmu-vmsa: Remove stage 2 PTE bits definitions
>   iommu/ipmmu-vmsa: Support clearing mappings
> 
> drivers/iommu/ipmmu-vmsa.c | 535 +++++++++++++++++++++++++++---------------
> 1 file changed, 361
> insertions(+), 174 deletions(-)

-- 
Regards,

Laurent Pinchart
