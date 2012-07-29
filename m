From: FlorianSchandinat@gmx.de (Florian Tobias Schandinat)
Date: Sun, 29 Jul 2012 21:15:10 +0000
Subject: [PATCH] video: exynos mipi dsi: Fix mipi dsi regulators handling
 issue
In-Reply-To: <500CB61A.6000106@samsung.com>
References: <500CB61A.6000106@samsung.com>
Message-ID: <5015A7DE.6050101@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2012 02:25 AM, Donghwa Lee wrote:
> When FB_BLANK_UNLANK event occured, exynos mipi dsi regulators have to turn on.
> 
> Signed-off-by: Donghwa Lee <dh09.lee@samsung.com>
> Signed-off-by: Inki Dae <inki.dae@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
>  drivers/video/exynos/exynos_mipi_dsi.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/exynos/exynos_mipi_dsi.c b/drivers/video/exynos/exynos_mipi_dsi.c
> index 6c1f5c3..9390640 100644
> --- a/drivers/video/exynos/exynos_mipi_dsi.c
> +++ b/drivers/video/exynos/exynos_mipi_dsi.c
> @@ -154,7 +154,7 @@ static int exynos_mipi_dsi_blank_mode(struct mipi_dsim_device *dsim, int power)
>  		if (client_drv && client_drv->power_on)
>  			client_drv->power_on(client_dev, 1);
>  
> -		exynos_mipi_regulator_disable(dsim);
> +		exynos_mipi_regulator_enable(dsim);
>  
>  		/* enable MIPI-DSI PHY. */
>  		if (dsim->pd->phy_enable)
