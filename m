From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 26 Jan 2016 01:45:19 +0100
Subject: [PATCH v6] drm/rockchip: hdmi: add Innosilicon HDMI support
In-Reply-To: <1453686430-21470-1-git-send-email-ykk@rock-chips.com>
References: <1453686197-20975-1-git-send-email-ykk@rock-chips.com>
 <1453686430-21470-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1453769119.17181.37.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ma, 2016-01-25 at 09:47 +0800, Yakir Yang wrote:
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig

> +config ROCKCHIP_INNO_HDMI
> +	tristate "Rockchip specific extensions for Innosilicon HDMI"
> +        depends on DRM_ROCKCHIP
> +        help
> +	  This selects support for Rockchip SoC specific extensions
> +	  for the Innosilicon HDMI driver. If you want to enable
> +	  HDMI on RK3036 based SoC, you should selet this option.

(Really trivial: start indentation with tabs only, please. And
s/selet/select/.)

> --- /dev/null
> +++ b/drivers/gpu/drm/rockchip/inno_hdmi.c

> + * This software is licensed under the terms of the GNU General
> Public
> + * License version 2, as published by the Free Software Foundation,
> and
> + * may be copied, distributed, and modified under those terms.

This states this file is licensed GPL v2 only.

> +MODULE_LICENSE("GPL");

And, according to include/linux/module.h, this means "GNU Public License
v2 or later".

So I think there's a (subtle) mismatch between the license ident used
for this driver and the comment above.

Thanks,


Paul Bolle
