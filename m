From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 13 Mar 2018 10:34:43 +0100
Subject: [PATCH 2/3] drm/meson: Use drm_dev_put() instead of
 drm_dev_unref()
In-Reply-To: <d4ce46077d3ada7149c4555acfdda8ade4a6cf50.1520885192.git.christophe.jaillet@wanadoo.fr>
References: <cover.1520885192.git.christophe.jaillet@wanadoo.fr>
 <d4ce46077d3ada7149c4555acfdda8ade4a6cf50.1520885192.git.christophe.jaillet@wanadoo.fr>
Message-ID: <0f801ea3-79e0-9942-2c18-6294e2c769cb@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2018 21:15, Christophe JAILLET wrote:
> According to 'drivers/gpu/drm/drm_drv.c', 'drm_dev_unref()' is just a
> compatibility alias for 'drm_dev_put()'. So use the latter instead.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/gpu/drm/meson/meson_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index 02b0886debc0..6ee3dd7fa450 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -284,7 +284,7 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>  	return 0;
>  
>  free_drm:
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  
>  	return ret;
>  }
> @@ -303,7 +303,7 @@ static void meson_drv_unbind(struct device *dev)
>  	drm_kms_helper_poll_fini(drm);
>  	drm_fbdev_cma_fini(priv->fbdev);
>  	drm_mode_config_cleanup(drm);
> -	drm_dev_unref(drm);
> +	drm_dev_put(drm);
>  
>  }
>  
> 

It's not useless, there is a clear statement :
 * This is a compatibility alias for drm_dev_put() and should not be used by new
 * code.

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks,
Neil
