From: inki.dae@samsung.com (Inki Dae)
Date: Fri, 26 May 2017 10:07:26 +0900
Subject: [PATCH v2] drm/exynos: dsi: Remove bridge node reference in
 removal
In-Reply-To: <1495760521-330-1-git-send-email-hoegeun.kwon@samsung.com>
References: <CGME20170526010217epcas1p3bfb8d9f733bcdafb4209d917fdf28dd8@epcas1p3.samsung.com>
 <1495760521-330-1-git-send-email-hoegeun.kwon@samsung.com>
Message-ID: <59277FCE.9010502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



2017? 05? 26? 10:02? Hoegeun Kwon ?(?) ? ?:
> Since bridge node is referenced during in the probe, it should be
> released on removal.
> 
> Suggested-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> ---
> Hi Inki,
> 
> This patch seems to have been forgotten... :)

Yeah, forgot this. Merged.

Thanks,
Inki Dae

> 
> Changes for V2:
> 
> - Checked for rebase 4.12-rc2
> 
> Best regards,
> Hoegeun
> 
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> index 698a824..a11b795 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> @@ -1805,6 +1805,10 @@ static int exynos_dsi_probe(struct platform_device *pdev)
>  
>  static int exynos_dsi_remove(struct platform_device *pdev)
>  {
> +	struct exynos_dsi *dsi = platform_get_drvdata(pdev);
> +
> +	of_node_put(dsi->bridge_node);
> +
>  	pm_runtime_disable(&pdev->dev);
>  
>  	component_del(&pdev->dev, &exynos_dsi_component_ops);
> 
