From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 27 Sep 2017 16:56:46 +0200
Subject: [PATCH] iommu/io-pgtable-arm-v7s: Need dma-sync while there is
 no QUIRK_NO_DMA
In-Reply-To: <1506331727-25018-1-git-send-email-yong.wu@mediatek.com>
References: <1506331727-25018-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <20170927145645.rsxgsmoti7x3xpri@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 25, 2017 at 05:28:47PM +0800, Yong Wu wrote:
> Fix the commit 81b3c2521844 ("iommu/io-pgtable: Introduce explicit
> coherency"). If there is no IO_PGTABLE_QUIRK_NO_DMA, we should call
> dma_sync_single_for_device for cache synchronization.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Applied to iommu/fixes, thanks.
