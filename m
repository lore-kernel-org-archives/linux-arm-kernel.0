From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 12 May 2014 17:07:23 +0200
Subject: [PATCH] phy: exynos-mipi-video: fix check on array index
In-Reply-To: <1399899388-13101-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1399899388-13101-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <5370E3AB.7090306@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/05/14 14:56, Antoine T?nart wrote:
> The phys array is of size EXYNOS_MIPI_PHYS_NUM. Trying to access the
> index EXYNOS_MIPI_PHYS_NUM should return an error.
> 
> Fixes: 069d2e26e9d6 "phy: Add driver for Exynos MIPI CSIS/DSIM DPHYs"
> 
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>

Thanks for the fix,

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

> ---
>  drivers/phy/phy-exynos-mipi-video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/phy-exynos-mipi-video.c b/drivers/phy/phy-exynos-mipi-video.c
> index 7f139326a642..ff026689358c 100644
> --- a/drivers/phy/phy-exynos-mipi-video.c
> +++ b/drivers/phy/phy-exynos-mipi-video.c
> @@ -101,7 +101,7 @@ static struct phy *exynos_mipi_video_phy_xlate(struct device *dev,
>  {
>  	struct exynos_mipi_video_phy *state = dev_get_drvdata(dev);
>  
> -	if (WARN_ON(args->args[0] > EXYNOS_MIPI_PHYS_NUM))
> +	if (WARN_ON(args->args[0] >= EXYNOS_MIPI_PHYS_NUM))
>  		return ERR_PTR(-ENODEV);
>  
>  	return state->phys[args->args[0]].phy;
