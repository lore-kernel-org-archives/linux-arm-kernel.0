From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Fri, 30 Sep 2016 15:53:23 +0200
Subject: [PATCH] drm: tilcdc: add a da850-specific compatible string
In-Reply-To: <1475240456-22936-1-git-send-email-bgolaszewski@baylibre.com>
References: <1475240456-22936-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <CAMpxmJV=vu8q00fowRyBR+LeQWzK01JPADWucGKeY0X4NrA3pQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2016-09-30 15:00 GMT+02:00 Bartosz Golaszewski <bgolaszewski@baylibre.com>:
> Due to some potential tweaks for the da850 LCDC (for example: the
> required memory bandwith settings) we need a separate compatible
> for the IP present on the da850 boards.
>
> Suggested-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/gpu/drm/tilcdc/tilcdc_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_drv.c b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> index a694977..231f2c7 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_drv.c
> @@ -723,6 +723,7 @@ static int tilcdc_pdev_remove(struct platform_device *pdev)
>
>  static struct of_device_id tilcdc_of_match[] = {
>                 { .compatible = "ti,am33xx-tilcdc", },
> +               { .compatible = "ti,da850-tilcdc", },
>                 { },
>  };
>  MODULE_DEVICE_TABLE(of, tilcdc_of_match);
> --
> 2.9.3
>

Superseded by v2.
