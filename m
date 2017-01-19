From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 Jan 2017 16:20:31 +0000
Subject: [PATCH V5 07/12] arm64: dma-mapping: Remove the notifier trick
 to handle early setting of dma_ops
In-Reply-To: <1484838356-24962-8-git-send-email-sricharan@codeaurora.org>
References: <1484838356-24962-1-git-send-email-sricharan@codeaurora.org>
 <1484838356-24962-8-git-send-email-sricharan@codeaurora.org>
Message-ID: <20170119162030.GJ31594@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 19, 2017 at 08:35:51PM +0530, Sricharan R wrote:
> With arch_setup_dma_ops now being called late during device's probe after
> the device's iommu is probed, the notifier trick required to handle the
> early setup of dma_ops before the iommu group gets created is not
> required. So removing the notifier's here.
> 
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> [rm: clean up even more]
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  * No change
> 
>  arch/arm64/mm/dma-mapping.c | 132 ++++----------------------------------------
>  1 file changed, 12 insertions(+), 120 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
