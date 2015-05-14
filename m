From: pebolle@tiscali.nl (Paul Bolle)
Date: Thu, 14 May 2015 11:16:54 +0200
Subject: [RFC][PATCH 2/2] drm/mediatek: Add DRM Driver for Mediatek SoC
 MT8173.
In-Reply-To: <1431530626-31493-3-git-send-email-ck.hu@mediatek.com>
References: <1431530626-31493-1-git-send-email-ck.hu@mediatek.com>
 <1431530626-31493-3-git-send-email-ck.hu@mediatek.com>
Message-ID: <1431595014.2650.50.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A naive question and a nit follow. That's probably not what you'd like
to see for an RFC, but the patch got tangled up in my mail filter
anyhow.

On Wed, 2015-05-13 at 23:23 +0800, CK Hu wrote:
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/Kconfig

> +config DRM_MEDIATEK_FBDEV
> +	bool "Enable legacy fbdev support for Mediatek DRM"
> +	depends on DRM_MEDIATEK
> +	select FB_SYS_FILLRECT
> +	select FB_SYS_COPYAREA
> +	select FB_SYS_IMAGEBLIT
> +	select DRM_KMS_FB_HELPER
> +	help
> +	  Choose this option if you have a need for the legacy
> +	  fbdev support.  Note that this support also provides
> +	  the Linux console on top of the Mediatek DRM mode
> +	  setting driver.

Naive question, as I know next to nothing about drivers/gpu/drm.
DRM_MEDIATEK_FBDEV isn't used anywhere, as far as I can see. So all that
setting this Kconfig symbol does is selecting four other Kconfig
symbols. Is selecting those four symbols enough to get fbdev support?
Taking the Cargo Cult approach of looking at similar symbols
(DRM_I915_FBDEV, DRM_MSM_FBDEV, DRM_STI_FBDEV, and DRM_TEGRA_FBDEV) I
noticed that they all do a bit more than just selecting other symbols.

> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mediatek_drm_drv.c

> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

This states the license of this driver is GPL v2. (Identical comments
seem to be part of all files added in this patch.)

> +MODULE_LICENSE("GPL");

And, according to include/linux/module.h, this states the license is GPL
v2 or later. So I think that either the comment at the top of these
files or the ident used in the MODULE_LICENSE() macro needs to be
changed.

Thanks,


Paul Bolle
