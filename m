From: marex@denx.de (Marek Vasut)
Date: Mon, 9 Dec 2013 11:55:47 +0100
Subject: [PATCH 1/3] drm: Add LCD display clock polarity flags
In-Reply-To: <20131203114450.GG13726@S2101-09.ap.freescale.net>
References: <1385998768-23512-1-git-send-email-marex@denx.de>
 <20131203114450.GG13726@S2101-09.ap.freescale.net>
Message-ID: <201312091155.47947.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, December 03, 2013 at 12:44:52 PM, Shawn Guo wrote:
> On Mon, Dec 02, 2013 at 04:39:26PM +0100, Marek Vasut wrote:
> > Add DRM flags for the LCD display clock polarity so the pixelclk-active
> > DT property can be properly handled by drivers using the DRM API.
> > 
> > Signed-off-by: Marek Vasut <marex@denx.de>
> > Cc: Dave Airlie <airlied@gmail.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Shawn Guo <shawn.guo@linaro.org>
> > ---
> > 
> >  drivers/gpu/drm/drm_modes.c | 5 +++++
> >  include/uapi/drm/drm_mode.h | 3 +++
> >  2 files changed, 8 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> > index 85071a1..d1f3bfc 100644
> > --- a/drivers/gpu/drm/drm_modes.c
> > +++ b/drivers/gpu/drm/drm_modes.c
> > @@ -537,6 +537,11 @@ int drm_display_mode_from_videomode(const struct
> > videomode *vm,
> > 
> >  		dmode->flags |= DRM_MODE_FLAG_DBLSCAN;
> >  	
> >  	if (vm->flags & DISPLAY_FLAGS_DOUBLECLK)
> >  	
> >  		dmode->flags |= DRM_MODE_FLAG_DBLCLK;
> > 
> > +	if (vm->flags & DISPLAY_FLAGS_PIXDATA_POSEDGE)
> > +		dmode->flags |= DRM_MODE_FLAG_PIXELCLK_PPOL;
> > +	else if (vm->flags & DISPLAY_FLAGS_PIXDATA_NEGEDGE)
> > +		dmode->flags |= DRM_MODE_FLAG_PIXELCLK_NPOL;
> > +
> > 
> >  	drm_mode_set_name(dmode);
> >  	
> >  	return 0;
> > 
> > diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> > index f104c26..a6169ca 100644
> > --- a/include/uapi/drm/drm_mode.h
> > +++ b/include/uapi/drm/drm_mode.h
> > @@ -73,6 +73,9 @@
> > 
> >  #define  DRM_MODE_FLAG_3D_TOP_AND_BOTTOM	(7<<14)
> >  #define  DRM_MODE_FLAG_3D_SIDE_BY_SIDE_HALF	(8<<14)
> > 
> > +/* CRTC LCD clock polarity flags. */
> > +#define DRM_MODE_FLAG_PIXELCLK_PPOL		(1<<19)
> > +#define DRM_MODE_FLAG_PIXELCLK_NPOL		(1<<20)
> 
> Marek,
> 
> It looks that Denis (copied) is working on the same problem, so you may
> want to be aware of his effort [1][2].

He also just sent a new patchset, so I would focus on his work instead. It makes 
more sense as he is not breaking the userland stuff.

Thank you Shawn, Russell!

Best regards,
Marek Vasut
