From: contact@paulk.fr (Paul Kocialkowski)
Date: Mon, 07 May 2018 20:50:23 +0200
Subject: [PATCH v3 1/3] drm/panel: Add RGB666 variant of Innolux AT070TN90
In-Reply-To: <20180507070855.dh47obvpmze577x5@flea>
References: <20180506214901.23429-1-contact@paulk.fr>
 <20180507070855.dh47obvpmze577x5@flea>
Message-ID: <8050492b544e5783d16eb74050313bfdddc0fc0d.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Le lundi 07 mai 2018 ? 09:08 +0200, Maxime Ripard a ?crit :
> Hi,
> 
> On Sun, May 06, 2018 at 11:48:59PM +0200, Paul Kocialkowski wrote:
> > This adds timings for the RGB666 variant of the Innolux AT070TN90
> > panel,
> > as found on the Ainol AW1 tablet.
> > 
> > The panel also supports RGB888 output. When RGB666 mode is used
> > instead,
> > the two extra lanes per component are grounded.
> > 
> > In the future, it might become necessary to introduce a dedicated
> > device-tree property to specify the bus format and maybe specify it
> > in
> > the mode description instead of panel description so that the
> > appropriate mode can be selected for each bus format.
> > 
> > Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> 
> A change log would be nice. Also, you mentionned in your first version
> that the screen was an AT070TN92, and now you mention that it is an
> AT070TN90, which one is it?

Yes, I should probably have explained why I changed the model here.
I checked on the device yesterday and found that the ribbon cable
indicates AT070TN90. I am not sure why I was initially assuming that the
panel was an AT070TN92. 

> Maxime
> 
> > ---
> >  drivers/gpu/drm/panel/panel-simple.c | 26
> > ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c
> > b/drivers/gpu/drm/panel/panel-simple.c
> > index cbf1ab404ee7..351742df8ee1 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -1086,6 +1086,29 @@ static const struct panel_desc
> > innolux_at070tn92 = {
> >  	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
> >  };
> >  
> > +static const struct drm_display_mode innolux_at070tn90_mode = {
> > +	.clock = 40000,
> > +	.hdisplay = 800,
> > +	.hsync_start = 800 + 112,
> > +	.hsync_end = 800 + 112 + 1,
> > +	.htotal = 800 + 112 + 1 + 87,
> > +	.vdisplay = 480,
> > +	.vsync_start = 480 + 141,
> > +	.vsync_end = 480 + 141 + 1,
> > +	.vtotal = 480 + 141 + 1 + 38,
> > +	.vrefresh = 60,
> > +};
> > +
> > +static const struct panel_desc innolux_at070tn90 = {
> > +	.modes = &innolux_at070tn90_mode,
> > +	.num_modes = 1,
> > +	.size = {
> > +		.width = 154,
> > +		.height = 86,
> > +	},
> > +	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
> > +};
> > +
> >  static const struct display_timing innolux_g101ice_l01_timing = {
> >  	.pixelclock = { 60400000, 71100000, 74700000 },
> >  	.hactive = { 1280, 1280, 1280 },
> > @@ -2154,6 +2177,9 @@ static const struct of_device_id
> > platform_of_match[] = {
> >  	}, {
> >  		.compatible = "innolux,at070tn92",
> >  		.data = &innolux_at070tn92,
> > +	}, {
> > +		.compatible = "innolux,at070tn90",
> > +		.data = &innolux_at070tn90,
> 
> This should be ordered alphabetically.

Thanks for the review!

Cheers,

Paul

-- 
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180507/9dfbd569/attachment.sig>
