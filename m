From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 15 Mar 2018 15:12:10 +0100
Subject: [PATCH] iommu/rockchip: Perform a reset on shutdown
In-Reply-To: <20180220202504.19275-1-marc.zyngier@arm.com>
References: <20180220202504.19275-1-marc.zyngier@arm.com>
Message-ID: <20180315141210.yb6c6tbzietiuty3@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 20, 2018 at 08:25:04PM +0000, Marc Zyngier wrote:
> Trying to do a kexec whilst the iommus are still on is proving to be
> a challenging exercise. It is terribly unsafe, as we're reusing the
> memory allocated for the page tables, leading to a likely crash.
> 
> Let's implement a shutdown method that will at least try to stop
> DMA from going crazy behind our back. Note that we need to be
> extra cautious when doing so, as the IOMMU may not be clocked
> if controlled by a another master, as typical on Rockchip system.
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Applied, thanks.
