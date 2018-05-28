From: rdunlap@infradead.org (Randy Dunlap)
Date: Mon, 28 May 2018 09:24:55 -0700
Subject: [PATCH 08/12] drm/bridge: tc358764: Add DSI to LVDS bridge driver
In-Reply-To: <1527500833-16005-9-git-send-email-m.purski@samsung.com>
References: <1527500833-16005-1-git-send-email-m.purski@samsung.com>
 <CGME20180528094728eucas1p128e8a44fa6c3bcb29d056a8191c039af@eucas1p1.samsung.com>
 <1527500833-16005-9-git-send-email-m.purski@samsung.com>
Message-ID: <153d1f8c-a0b4-b189-34b5-42a81d15f66b@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2018 02:47 AM, Maciej Purski wrote:
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index fa2c799..58e19af 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -110,6 +110,13 @@ config DRM_THINE_THC63LVD1024
>  	---help---
>  	  Thine THC63LVD1024 LVDS/parallel converter driver.
>  
> +config DRM_TOSHIBA_TC358764
> +	tristate "TC358764 DSI/LVDS bridge"
> +	depends on DRM && DRM_PANEL
> +	depends on OF
> +	select DRM_MIPI_DSI
> +	select VIDEOMODE_HELPERS
> +

Kconfig symbols with "prompt strings" should also have help text.

I expected checkpatch to catch that, but I tested it and there was no warning
from checkpatch about help text.  OTOH, there was a warning that there are
2 lines in this patch that end with whitespace, so that should be fixed.

Did you use checkpatch (scripts/checkpatch.pl)?

>  config DRM_TOSHIBA_TC358767
>  	tristate "Toshiba TC358767 eDP bridge"
>  	depends on OF

thanks,
-- 
~Randy
