From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 19 Jul 2016 10:05:18 +0200
Subject: [PATCH 1/2] drm/sun4i: Remove redundant call to
 drm_connector_unregister_all()
In-Reply-To: <CAOw6vbKAKnkYknXzCsvQCRqrha==MNNX_XdouDet_bdmW8gk-g@mail.gmail.com>
References: <1468427947-28037-1-git-send-email-chris@chris-wilson.co.uk>
 <CAOw6vbKAKnkYknXzCsvQCRqrha==MNNX_XdouDet_bdmW8gk-g@mail.gmail.com>
Message-ID: <20160719080518.GL17101@phenom.ffwll.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 13, 2016 at 11:23:29AM -0700, Sean Paul wrote:
> On Wed, Jul 13, 2016 at 9:39 AM, Chris Wilson <chris@chris-wilson.co.uk> wrote:
> > drm_connector_unregister_all() is automatically called by
> > drm_dev_unregister() and so the manual call can be dropped.
> >
> > Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Chen-Yu Tsai <wens@csie.org>
> > Cc: dri-devel at lists.freedesktop.org
> > Cc: linux-arm-kernel at lists.infradead.org
> 
> 
> 
> Reviewed-by: Sean Paul <seanpaul@chromium.org>

Done a backmerge and applied these two, thanks.
-Daniel

> 
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_drv.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> > index 4dc543e1db10..7092daaf6c43 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> > @@ -185,7 +185,6 @@ static void sun4i_drv_unbind(struct device *dev)
> >  {
> >         struct drm_device *drm = dev_get_drvdata(dev);
> >
> > -       drm_connector_unregister_all(drm);
> >         drm_dev_unregister(drm);
> >         drm_kms_helper_poll_fini(drm);
> >         sun4i_framebuffer_free(drm);
> > --
> > 2.8.1
> >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel at lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
