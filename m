From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Oct 2017 16:34:35 +0200
Subject: [PATCH 02/23] drm/sun4i: Realign Makefile padding and reorder it
In-Reply-To: <CAGb2v649B-M7ya=XmH0+hHgYUHDMxWjAH1vuq+iKOOqgU13eCg@mail.gmail.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
 <9410b284ec97453fa692537dffaaa4fb4833347c.1508231063.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v649B-M7ya=XmH0+hHgYUHDMxWjAH1vuq+iKOOqgU13eCg@mail.gmail.com>
Message-ID: <20171017143435.5vj4obbxcnodgcu7@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 05:14:47PM +0800, Chen-Yu Tsai wrote:
> On Tue, Oct 17, 2017 at 5:06 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Some options were not padded as they should, and the order in the Makefile
> > was chaotic. Fix that.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/gpu/drm/sun4i/Makefile | 28 ++++++++++++++--------------
> >  1 file changed, 14 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
> > index 43c753cafc88..af18b70ba5ed 100644
> > --- a/drivers/gpu/drm/sun4i/Makefile
> > +++ b/drivers/gpu/drm/sun4i/Makefile
> > @@ -1,24 +1,24 @@
> > -sun4i-drm-y += sun4i_drv.o
> > -sun4i-drm-y += sun4i_framebuffer.o
> > +sun4i-backend-y                        += sun4i_backend.o sun4i_layer.o
> >
> > -sun4i-drm-hdmi-y += sun4i_hdmi_enc.o
> > -sun4i-drm-hdmi-y += sun4i_hdmi_i2c.o
> > -sun4i-drm-hdmi-y += sun4i_hdmi_ddc_clk.o
> > -sun4i-drm-hdmi-y += sun4i_hdmi_tmds_clk.o
> > +sun4i-drm-y                    += sun4i_drv.o
> > +sun4i-drm-y                    += sun4i_framebuffer.o
> >
> > -sun4i-tcon-y += sun4i_tcon.o
> > -sun4i-tcon-y += sun4i_rgb.o
> > -sun4i-tcon-y += sun4i_dotclock.o
> > -sun4i-tcon-y += sun4i_crtc.o
> > +sun4i-drm-hdmi-y               += sun4i_hdmi_enc.o
> > +sun4i-drm-hdmi-y               += sun4i_hdmi_i2c.o
> > +sun4i-drm-hdmi-y               += sun4i_hdmi_ddc_clk.o
> > +sun4i-drm-hdmi-y               += sun4i_hdmi_tmds_clk.o
> >
> > -sun4i-backend-y += sun4i_backend.o sun4i_layer.o
> > +sun4i-tcon-y                   += sun4i_tcon.o
> > +sun4i-tcon-y                   += sun4i_rgb.o
> > +sun4i-tcon-y                   += sun4i_dotclock.o
> > +sun4i-tcon-y                   += sun4i_crtc.o
> 
> I don't know if you wanted to sort the file names as well.
> This would be a good time to do it.

Fixed while applying, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171017/16f3dfc8/attachment.sig>
