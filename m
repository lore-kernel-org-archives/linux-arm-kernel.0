From: a.hajda@samsung.com (Andrzej Hajda)
Date: Mon, 19 Jun 2017 12:11:23 +0200
Subject: [PATCH] drm: exynos: hdmi: make of_device_ids const.
In-Reply-To: <6012220ff3c7dad339686f411ff372e7897e60c4.1497863911.git.arvind.yadav.cs@gmail.com>
References: <CGME20170619092447epcas2p39a32ae59d05f1bd14cd43b8bcd6f2463@epcas2p3.samsung.com>
 <6012220ff3c7dad339686f411ff372e7897e60c4.1497863911.git.arvind.yadav.cs@gmail.com>
Message-ID: <84a58fd2-989d-a982-66e9-c97e9d61c2f4@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19.06.2017 11:24, Arvind Yadav wrote:
> of_device_ids are not supposed to change at runtime. All functions
> working with of_device_ids provided by <linux/of.h> work with const
> of_device_ids. So mark the non-const structs as const.
>
> File size before:
>    text	   data	    bss	    dec	    hex	filename
>   12294	   1192	      0	  13486	   34ae	drivers/gpu/drm/exynos/exynos_hdmi.o
>
> File size after constify hdmi_match_types.
>    text	   data	    bss	    dec	    hex	filename
>   13318	    176	      0	  13494	   34b6	drivers/gpu/drm/exynos/exynos_hdmi.o
>
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

 --
Regards
Andrzej

> ---
>  drivers/gpu/drm/exynos/exynos_hdmi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
> index 1ff6ab6..624c48d 100644
> --- a/drivers/gpu/drm/exynos/exynos_hdmi.c
> +++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
> @@ -1683,7 +1683,7 @@ static int hdmi_resources_init(struct hdmi_context *hdata)
>  	return hdmi_bridge_init(hdata);
>  }
>  
> -static struct of_device_id hdmi_match_types[] = {
> +static const struct of_device_id hdmi_match_types[] = {
>  	{
>  		.compatible = "samsung,exynos4210-hdmi",
>  		.data = &exynos4210_hdmi_driver_data,
