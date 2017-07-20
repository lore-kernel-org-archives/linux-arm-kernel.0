From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Jul 2017 15:55:55 +0200
Subject: [PATCH 10/18] drm/sun4i: tcon: Move out the tcon0 common setup
In-Reply-To: <CAGb2v65TfUKyWg=vxWP-YhM3Be1i=N1OmNTO16aFk2VTCg4VXg@mail.gmail.com>
References: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
 <45529eeddc5d5eab9bcfa74982343eeb36fe11f6.1499955058.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v65TfUKyWg=vxWP-YhM3Be1i=N1OmNTO16aFk2VTCg4VXg@mail.gmail.com>
Message-ID: <20170720135555.u2xuubrt4tpjy6us@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 11:41:36AM +0800, Chen-Yu Tsai wrote:
> On Thu, Jul 13, 2017 at 10:13 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Some channel0 setup has to be done, no matter what the output interface is
> > (RGB, CPU, LVDS). Move that code into a common function in order to avoid
> > duplication.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 26 ++++++++++++++++----------
> >  1 file changed, 16 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > index a3bbf9994cfa..f051862d635e 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > @@ -125,15 +125,26 @@ static int sun4i_tcon_get_clk_delay(struct drm_display_mode *mode,
> >         return delay;
> >  }
> >
> > -static void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
> > -                                struct drm_display_mode *mode)
> > +static void sun4i_tcon0_mode_set_common(struct sun4i_tcon *tcon,
> > +                                       struct drm_display_mode *mode)
> > +{
> > +       /* Configure the dot clock */
> > +       clk_set_rate_protect(tcon->dclk, mode->crtc_clock * 1000);
> 
> I'd prefer not changing APIs in a code move. It also means we could
> apply this sooner than later. Otherwise,

You're right, I've changed it.

> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170720/6a806c0a/attachment.sig>
