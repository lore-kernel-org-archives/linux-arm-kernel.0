From: john@metanate.com (John Keeping)
Date: Sun, 15 May 2016 12:16:39 +0100
Subject: [PATCH] iommu/rockchip: fix zap cache during device attach
In-Reply-To: <11003810.ccjcAXkzhi@phil>
References: <20160510155046.24515-1-john@metanate.com>
 <11003810.ccjcAXkzhi@phil>
Message-ID: <20160515111638.GA9715@river>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 14, 2016 at 10:19:43PM +0200, Heiko Stuebner wrote:
> Am Dienstag, 10. Mai 2016, 16:50:46 schrieb John Keeping:
> > rk_iommu_command() takes a struct rk_iommu and iterates over the slave
> > MMUs, so this is doubly wrong in that we're passing in the wrong pointer
> > and talking to MMUs that we shouldn't be.
> > 
> > Fixes: cd6438c5f844 ("iommu/rockchip: Reconstruct to support multi
> > slaves") Signed-off-by: John Keeping <john@metanate.com>
> 
> on a rk3288-veyron
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 
> I was wondering for a short time why this didn't spew warnings until I 
> realized that the iommu->bases[i] is of course a void* .

Yes, although sparse catches it because iommu->bases[i] is __iomem so it
shows up as a namespace warning.
