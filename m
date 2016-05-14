From: heiko@sntech.de (Heiko Stuebner)
Date: Sat, 14 May 2016 22:19:43 +0200
Subject: [PATCH] iommu/rockchip: fix zap cache during device attach
In-Reply-To: <20160510155046.24515-1-john@metanate.com>
References: <20160510155046.24515-1-john@metanate.com>
Message-ID: <11003810.ccjcAXkzhi@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 10. Mai 2016, 16:50:46 schrieb John Keeping:
> rk_iommu_command() takes a struct rk_iommu and iterates over the slave
> MMUs, so this is doubly wrong in that we're passing in the wrong pointer
> and talking to MMUs that we shouldn't be.
> 
> Fixes: cd6438c5f844 ("iommu/rockchip: Reconstruct to support multi
> slaves") Signed-off-by: John Keeping <john@metanate.com>

on a rk3288-veyron
Tested-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>

I was wondering for a short time why this didn't spew warnings until I 
realized that the iommu->bases[i] is of course a void* .


Heiko
