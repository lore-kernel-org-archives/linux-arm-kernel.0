From: sylvain.rochet@finsecur.com (Sylvain Rochet)
Date: Tue, 10 Feb 2015 15:43:51 +0100
Subject: [PATCH 1/2] drm: atmel-hlcdc: Add PM suspend/resume support
In-Reply-To: <20150210150557.235fa139@bbrezillon>
References: <1423575646-3273-1-git-send-email-sylvain.rochet@finsecur.com>
 <1423575646-3273-2-git-send-email-sylvain.rochet@finsecur.com>
 <20150210150557.235fa139@bbrezillon>
Message-ID: <20150210144351.GA14171@gradator.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Boris,

On Tue, Feb 10, 2015 at 03:05:57PM +0100, Boris Brezillon wrote:
> On Tue, 10 Feb 2015 14:40:45 +0100
> Sylvain Rochet <sylvain.rochet@finsecur.com> wrote:
> > +
> > +static SIMPLE_DEV_PM_OPS(atmel_hlcdc_dc_drm_pm_ops,
> > +		atmel_hlcdc_dc_drm_suspend, atmel_hlcdc_dc_drm_resume);
> > +
> 
> Do we really need to register both SIMPLE_DEV_PM_OPS and drm_driver
> suspend/resume functions.
> I thought the suspend/resume callbacks were called by DRM core code
> as part of the PM class specific operations.
> However, exynos driver seems to do the same, so this might well be
> required.

Looks like we need, if I comment out SIMPLE_DEV_PM_OPS ops registration 
we don't suspend or resume anymore. I guess drm_driver suspend/resume 
functions are only used for PM runtime support, which we don't support 
yet, at least we added the basic requirements to add PM runtime support 
at some point in the future.

Anyway, even without PM runtime support we need to suspend and resume 
this device, other DRM drivers do this as well.

Sylvain
