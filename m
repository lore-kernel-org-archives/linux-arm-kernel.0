From: Jianwei.Wang@freescale.com (Wang J.W.)
Date: Mon, 13 Jul 2015 03:58:15 +0000
Subject: [PATCH v7 1/4] drm/layerscape: Add Freescale DCU DRM driver
In-Reply-To: <1436620543.2679.13.camel@tiscali.nl>
References: <1436527063-44762-1-git-send-email-jianwei.wang@freescale.com>
 <1436620543.2679.13.camel@tiscali.nl>
Message-ID: <DM2PR0301MB1229EC83D407F46E171339F09F9C0@DM2PR0301MB1229.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

Thank you for your review.

> -----Original Message-----
> From: Paul Bolle [mailto:pebolle at tiscali.nl]
> Sent: Saturday, July 11, 2015 9:16 PM
> To: Wang Jianwei-B52261
> Cc: dri-devel at lists.freedesktop.org; linux-kernel at vger.kernel.org; linux-
> arm-kernel at lists.infradead.org; devicetree at vger.kernel.org;
> airlied at linux.ie; daniel.vetter at ffwll.ch; mark.yao at rock-chips.com; Wood
> Scott-B07421; thierry.reding at gmail.com; Wang Huan-B18965; Xiubo Li
> Subject: Re: [PATCH v7 1/4] drm/layerscape: Add Freescale DCU DRM driver
> 
> A question and a nit follow.
> 
> On vr, 2015-07-10 at 19:17 +0800, Jianwei Wang wrote:
> > --- /dev/null
> > +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c
> 
> > +MODULE_ALIAS("platform:fsl-dcu-drm");
> 
> Question: this appears to be only useful if there's a corresponding struct
> platform_device. That is, a platform_device with a "fsl-dcu-drm"
> .name. It will fire off a "MODALIAS=platform:fsl-dcu-drm" uevent when it's
> created.
> 
> I couldn't find this corresponding platform_device. Does it exist? Or is
> this alias needed for some other reason?
> 
> > --- /dev/null
> > +++ b/drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.h
> 
> > +#define DRIVER_NAME			"fsl-dcu-drm"
> 
> Nit: I don't think DRIVER_NAME is actually used anywhere.	
> 

Yes, you are right. Both are useless, I'll remove them.
I copied source code from other DRM driver at first, and forgot to remove them.
Thanks for your kindly remind.


BR.
Jianwei

> Thanks,
> 
> 
> Paul Bolle
