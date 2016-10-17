From: a.hajda@samsung.com (Andrzej Hajda)
Date: Mon, 17 Oct 2016 13:33:59 +0200
Subject: [PATCH] crygpu/drm/exynos/exynos_hdmi - Unmap region obtained by
 of_iomap
In-Reply-To: <1476702562-24422-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <CGME20161017111000eucas1p13f38f6daa20992f6aa3c9dfc8d2ab495@eucas1p1.samsung.com>
 <1476702562-24422-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <0147af61-e96e-ba43-55b9-6a58a1539666@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On 17.10.2016 13:09, Arvind Yadav wrote:
> Free memory mapping, if hdmi_probe is not successful.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Subject prefix is incorrect.

> ---
>  drivers/gpu/drm/exynos/exynos_hdmi.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
> index 2275efe..9b7857b 100644
> --- a/drivers/gpu/drm/exynos/exynos_hdmi.c
> +++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
> @@ -1901,6 +1901,8 @@ err_disable_pm_runtime:
>  err_hdmiphy:
>  	if (hdata->hdmiphy_port)
>  		put_device(&hdata->hdmiphy_port->dev);
> +	if (hdata->regs_hdmiphy)
> +		iounmap(hdata->regs_hdmiphy);

Thats OK, you can add also unmap to hdmi_remove.

Regards
Andrzej

>  err_ddc:
>  	put_device(&hdata->ddc_adpt->dev);
>  
