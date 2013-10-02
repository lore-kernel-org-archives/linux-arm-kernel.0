From: olof@lixom.net (Olof Johansson)
Date: Wed, 2 Oct 2013 14:20:42 -0700
Subject: [PATCH 3/5] drm/bridge: Add PTN3460 bridge driver
In-Reply-To: <1380670860-17621-4-git-send-email-seanpaul@chromium.org>
References: <1380670860-17621-1-git-send-email-seanpaul@chromium.org>
 <1380670860-17621-4-git-send-email-seanpaul@chromium.org>
Message-ID: <CAOesGMjWi3Bk+OtfWjkgHqLk+Zb7cHRjS9S0AfpcPU3UqB+UTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On Tue, Oct 1, 2013 at 4:40 PM, Sean Paul <seanpaul@chromium.org> wrote:
> This patch adds a drm_bridge driver for the PTN3460 DisplayPort to LVDS
> bridge chip.
>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> ---

[...]

> +Example:
> +       ptn3460-bridge at 20 {

Nit: Name is usually generic device name, i.e. "lvds-bridge" or
something like that.

> +               compatible = "nxp,ptn3460";
> +               reg = <0x20>;
> +               powerdown-gpio = <&gpy2 5 1 0 0>;
> +               reset-gpio = <&gpx1 5 1 0 0>;
> +               edid-emulation = <5>;
> +       };

[...]


> diff --git a/include/drm/bridge/ptn3460.h b/include/drm/bridge/ptn3460.h
> new file mode 100644
> index 0000000..157ffa1
> --- /dev/null
> +++ b/include/drm/bridge/ptn3460.h
> @@ -0,0 +1,36 @@
> +/*
> + * Copyright (C) 2013 Google, Inc.
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#ifndef _DRM_BRIDGE_PTN3460_H_
> +#define _DRM_BRIDGE_PTN3460_H_
> +
> +struct drm_device;
> +struct drm_encoder;
> +struct i2c_client;
> +struct device_node;
> +
> +#ifdef CONFIG_DRM_PTN3460
> +
> +int ptn3460_init(struct drm_device *dev, struct drm_encoder *encoder,
> +               struct i2c_client *client, struct device_node *node);
> +#else
> +
> +int ptn3460_init(struct drm_device *dev, struct drm_encoder *encoder,
> +               struct i2c_client *client, struct device_node *node)

This should be static inline int ptn3460_init(...)

> +{
> +       return 0;
> +}


-0Olof
