From: daeinki@gmail.com (Inki Dae)
Date: Wed, 19 Oct 2016 23:18:31 +0900
Subject: [PATCH V2] gpu/drm/exynos/exynos_hdmi - Unmap region obtained by
 of_iomap
In-Reply-To: <1476871456-1098-1-git-send-email-arvind.yadav.cs@gmail.com>
References: <1476871456-1098-1-git-send-email-arvind.yadav.cs@gmail.com>
Message-ID: <CAAQKjZPtedAyC9yUB5uT6XTrc_2RJsaivwk-5Ep1dmdMnd3zZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will pick it up soon.

Thanks,
Inki Dae

2016-10-19 19:04 GMT+09:00 Arvind Yadav <arvind.yadav.cs@gmail.com>:
> Free memory mapping, if hdmi_probe is not successful.
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/gpu/drm/exynos/exynos_hdmi.c |    5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
> index 2275efe..ba28dec 100644
> --- a/drivers/gpu/drm/exynos/exynos_hdmi.c
> +++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
> @@ -1901,6 +1901,8 @@ err_disable_pm_runtime:
>  err_hdmiphy:
>         if (hdata->hdmiphy_port)
>                 put_device(&hdata->hdmiphy_port->dev);
> +       if (hdata->regs_hdmiphy)
> +               iounmap(hdata->regs_hdmiphy);
>  err_ddc:
>         put_device(&hdata->ddc_adpt->dev);
>
> @@ -1923,6 +1925,9 @@ static int hdmi_remove(struct platform_device *pdev)
>         if (hdata->hdmiphy_port)
>                 put_device(&hdata->hdmiphy_port->dev);
>
> +       if (hdata->regs_hdmiphy)
> +               iounmap(hdata->regs_hdmiphy);
> +
>         put_device(&hdata->ddc_adpt->dev);
>
>         return 0;
> --
> 1.7.9.5
>
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
