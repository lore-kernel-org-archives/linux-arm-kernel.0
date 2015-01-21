From: will.deacon@arm.com (Will Deacon)
Date: Wed, 21 Jan 2015 14:44:20 +0000
Subject: [PATCH v2] iommu/ipmmu-vmsa: Use the ARM LPAE page table allocator
In-Reply-To: <1421771404-22774-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <20150119140106.GM6343@8bytes.org>
 <1421771404-22774-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <20150121144419.GJ4549@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 04:30:04PM +0000, Laurent Pinchart wrote:
> Replace the custom page table allocation implementation with the
> standard allocator.
> 
> The driver loses the ability to map 64kB chunkgs using the PTE
> contiguous hint, hence the removal of the SZ_64K page size from the
> IOMMU page sizes bitmap.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  drivers/iommu/Kconfig      |   1 +
>  drivers/iommu/ipmmu-vmsa.c | 554 +++++----------------------------------------
>  2 files changed, 61 insertions(+), 494 deletions(-)
> 
> This patch depends on Will Deacon's "[PATCH v2 0/5] Generic IOMMU page table
> framework" series.
> 
> Joerg, if you want to merge Will's patches in v3.20 with one user, this is a
> good candidate.
> 
> Changes since v1:
> 
> - Rebased on top of latest page table framework and iommu next branch.

Laurent, this is really good stuff, thanks!

Shall I queue this on top of the iommu/pgtbl patches, or do you have other
ipmmu patches queued?

Will
