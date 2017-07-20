From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Jul 2017 15:08:01 +0200
Subject: [PATCH 03/18] drm/sun4i: Realign Makefile padding and reorder it
In-Reply-To: <CAGb2v67HmUpSaoJWS6jKg3JvsPmqMtv30EGdWE50YEPm2cyjcg@mail.gmail.com>
References: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
 <fd70853df9e7ee66a20df9d42921f1f6608a2bc9.1499955058.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v67HmUpSaoJWS6jKg3JvsPmqMtv30EGdWE50YEPm2cyjcg@mail.gmail.com>
Message-ID: <20170720130801.iyhlzu4zhbyso24y@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 14, 2017 at 11:13:53AM +0800, Chen-Yu Tsai wrote:
> On Thu, Jul 13, 2017 at 10:12 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Some options were not padded as they should, and the order in the Makefile
> > was chaotic. Fix that.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/gpu/drm/sun4i/Makefile | 26 +++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/Makefile b/drivers/gpu/drm/sun4i/Makefile
> > index e29fd3a2ba9c..42871ee7acf6 100644
> > --- a/drivers/gpu/drm/sun4i/Makefile
> > +++ b/drivers/gpu/drm/sun4i/Makefile
> > @@ -1,23 +1,23 @@
> > -sun4i-drm-y += sun4i_drv.o
> > -sun4i-drm-y += sun4i_framebuffer.o
> > +sun4i-backend-y                        += sun4i_backend.o sun4i_layer.o
> >
> > -sun4i-drm-hdmi-y += sun4i_hdmi_enc.o
> > -sun4i-drm-hdmi-y += sun4i_hdmi_ddc_clk.o
> > -sun4i-drm-hdmi-y += sun4i_hdmi_tmds_clk.o
> > +sun4i-drm-y                    += sun4i_drv.o
> > +sun4i-drm-y                    += sun4i_framebuffer.o
> 
> I don't think this applies on top of Jonathan's HDMI I2C patch
> you already have queued up.
> 
> Also you might want to leave a comment describe what the
> ordering should be. Otherwise it will still be messed up
> down the road.

Good point, I'll do that, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170720/d022960e/attachment.sig>
