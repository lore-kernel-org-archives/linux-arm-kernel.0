From: joro@8bytes.org (Joerg Roedel)
Date: Tue, 25 Sep 2018 11:14:17 +0200
Subject: [PATCH] iommu/rockchip: Free irqs in shutdown handler
In-Reply-To: <20180827105624.5593-1-heiko@sntech.de>
References: <20180827105624.5593-1-heiko@sntech.de>
Message-ID: <20180925091417.asyvub7v75jtjdfk@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 27, 2018 at 12:56:24PM +0200, Heiko Stuebner wrote:
> In the iommu's shutdown handler we disable runtime-pm which could
> result in the irq-handler running unclocked and since commit
>     3fc7c5c0cff3 ("iommu/rockchip: Handle errors returned from PM framework")
> we warn about that fact.
> 
> This can cause warnings on shutdown on some Rockchip machines, so
> free the irqs in the shutdown handler before we disable runtime-pm.
> 
> Reported-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Fixes: 3fc7c5c0cff3 ("iommu/rockchip: Handle errors returned from PM framework")
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/iommu/rockchip-iommu.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied for v4.19, thanks Heiko.
