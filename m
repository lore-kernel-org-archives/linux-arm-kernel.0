From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Fri, 28 Mar 2014 18:11:01 -0700
Subject: [PATCH] staging: imx-drm: add LVDS666 support for parallel display
In-Reply-To: <1396047954-27175-1-git-send-email-kernel@esmil.dk>
References: <1396047954-27175-1-git-send-email-kernel@esmil.dk>
Message-ID: <53361DA5.4070806@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/28/2014 4:05 PM, Emil Renner Berthing wrote:
> diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
> index 156bbea..9945609 100644
> --- a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
> +++ b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
>  
> +	/* lvds666 */
> +	ipu_dc_map_clear(priv, IPU_DC_MAP_LVDS666);
> +	ipu_dc_map_config(priv, IPU_DC_MAP_LVDS666, 0, 5, 0xfc); /* blue */
> +	ipu_dc_map_config(priv, IPU_DC_MAP_LVDS666, 1, 15, 0xfc); /* green */
> +	ipu_dc_map_config(priv, IPU_DC_MAP_LVDS666, 2, 21, 0xfc); /* red */
> +

Should the 15 above be 13. ie 5+8=13, 13+8=21
Also, imx_3.0.35_4.1.0 uses 13.

Troy
