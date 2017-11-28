From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 28 Nov 2017 21:40:19 +0100
Subject: [PATCH 09/17] drm/sun4i: Add scaler library for DE2
In-Reply-To: <20171127205750.19277-10-jernej.skrabec@siol.net>
References: <20171127205750.19277-1-jernej.skrabec@siol.net>
 <20171127205750.19277-10-jernej.skrabec@siol.net>
Message-ID: <20171128204019.tzyfn45gnwxe5uao@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 27, 2017 at 09:57:42PM +0100, Jernej Skrabec wrote:
> Scaler library currently supports scaling only RGB planes on VI planes.
> 
> Coefficients and algorithm which ones to select are taken from BSP driver.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/Makefile       |   2 +-
>  drivers/gpu/drm/sun4i/sun8i_scaler.c | 667 +++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/sun4i/sun8i_scaler.h |  78 ++++
>  3 files changed, 746 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/sun4i/sun8i_scaler.c
>  create mode 100644 drivers/gpu/drm/sun4i/sun8i_scaler.h
> 
> diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
> index 0c2f8c7facae..70df480792f9 100644
> --- a/drivers/gpu/drm/sun4i/Makefile
> +++ b/drivers/gpu/drm/sun4i/Makefile
> @@ -9,7 +9,7 @@ sun4i-drm-hdmi-y		+= sun4i_hdmi_enc.o
>  sun4i-drm-hdmi-y		+= sun4i_hdmi_i2c.o
>  sun4i-drm-hdmi-y		+= sun4i_hdmi_tmds_clk.o
>  
> -sun8i-mixer-y			+= sun8i_mixer.o sun8i_layer.o
> +sun8i-mixer-y			+= sun8i_mixer.o sun8i_layer.o sun8i_scaler.o
>  
>  sun4i-tcon-y			+= sun4i_crtc.o
>  sun4i-tcon-y			+= sun4i_dotclock.o
> diff --git a/drivers/gpu/drm/sun4i/sun8i_scaler.c b/drivers/gpu/drm/sun4i/sun8i_scaler.c
> new file mode 100644
> index 000000000000..23525beceaa2
> --- /dev/null
> +++ b/drivers/gpu/drm/sun4i/sun8i_scaler.c
> @@ -0,0 +1,667 @@
> +/*
> + * Copyright (C) 2017 Jernej Skrabec <jernej.skrabec@siol.net>
> + *
> + * Coefficients are taken from BSP driver, which is:
> + * Copyright (C) 2014-2015 Allwinner

Saying from which BSP you got them would be great for future reference

It looks good otherwise. I kind of hate those big array of
undocumented data, but there's nothing you can do about it either, so
we'll have to deal with it :)

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171128/b0cd538b/attachment.sig>
