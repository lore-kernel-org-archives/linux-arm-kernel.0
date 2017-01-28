From: helgaas@kernel.org (Bjorn Helgaas)
Date: Sat, 28 Jan 2017 15:06:11 -0600
Subject: [PATCH V7 09/11] arm64: dma-mapping: Remove the notifier trick
 to handle early setting of dma_ops
In-Reply-To: <1485188293-20263-10-git-send-email-sricharan@codeaurora.org>
References: <1485188293-20263-1-git-send-email-sricharan@codeaurora.org>
 <1485188293-20263-10-git-send-email-sricharan@codeaurora.org>
Message-ID: <20170128210611.GF20550@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2017 at 09:48:11PM +0530, Sricharan R wrote:
> With arch_setup_dma_ops now being called late during device's probe after
> the device's iommu is probed, the notifier trick required to handle the
> early setup of dma_ops before the iommu group gets created is not
> required. So removing the notifier's here.

s/notifier's/notifiers/

Personally I'd capitalize "IOMMU" in the English text above, too.

> Acked-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Sricharan R <sricharan@codeaurora.org>
> [rm: clean up even more]
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  arch/arm64/mm/dma-mapping.c | 132 ++++----------------------------------------
>  1 file changed, 12 insertions(+), 120 deletions(-)

Nice :)
