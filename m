From: pebolle@tiscali.nl (Paul Bolle)
Date: Sat, 11 Jul 2015 15:15:43 +0200
Subject: [PATCH v7 1/4] drm/layerscape: Add Freescale DCU DRM driver
In-Reply-To: <1436527063-44762-1-git-send-email-jianwei.wang@freescale.com>
References: <1436527063-44762-1-git-send-email-jianwei.wang@freescale.com>
Message-ID: <1436620543.2679.13.camel@tiscali.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A question and a nit follow.

On vr, 2015-07-10 at 19:17 +0800, Jianwei Wang wrote:
> --- /dev/null
> +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c

> +MODULE_ALIAS("platform:fsl-dcu-drm");

Question: this appears to be only useful if there's a corresponding
struct platform_device. That is, a platform_device with a "fsl-dcu-drm"
.name. It will fire off a "MODALIAS=platform:fsl-dcu-drm" uevent when
it's created.

I couldn't find this corresponding platform_device. Does it exist? Or is
this alias needed for some other reason?

> --- /dev/null
> +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h

> +#define DRIVER_NAME			"fsl-dcu-drm"

Nit: I don't think DRIVER_NAME is actually used anywhere.

Thanks,


Paul Bolle
