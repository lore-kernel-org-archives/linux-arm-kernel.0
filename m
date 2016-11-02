From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 2 Nov 2016 19:55:15 +0100
Subject: [PATCH] drm/sun4i: Add a few formats
In-Reply-To: <CAGb2v65SqkU-7W4+JnnnF+RzJO_0-TRq+DykJRf9og1wGc4azQ@mail.gmail.com>
References: <20161018084614.2443-1-maxime.ripard@free-electrons.com>
 <CAGb2v65uZFQnRme9LrRykze=a4d_7=HS=Gvu6E_eBG5tSw8nTw@mail.gmail.com>
 <20161024144014.occkqw2v5c2ghx4w@lukather>
 <CAGb2v65=6YGaaC3QimPHyP=FKJofygReozmnKLV8CGXvjWGtvQ@mail.gmail.com>
 <20161027143505.rblgbz5uqjynrtjk@lukather>
 <CAGb2v65SqkU-7W4+JnnnF+RzJO_0-TRq+DykJRf9og1wGc4azQ@mail.gmail.com>
Message-ID: <20161102185515.g42fjhoqxtlnqigc@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 29, 2016 at 06:25:46PM +0800, Chen-Yu Tsai wrote:
> On Thu, Oct 27, 2016 at 10:35 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Tue, Oct 25, 2016 at 08:42:26AM +0800, Chen-Yu Tsai wrote:
> >> On Mon, Oct 24, 2016 at 10:40 PM, Maxime Ripard
> >> <maxime.ripard@free-electrons.com> wrote:
> >> > Hi,
> >> >
> >> > On Fri, Oct 21, 2016 at 11:15:32AM +0800, Chen-Yu Tsai wrote:
> >> >> On Tue, Oct 18, 2016 at 4:46 PM, Maxime Ripard
> >> >> <maxime.ripard@free-electrons.com> wrote:
> >> >> > The planes can do more than what was previously exposed. Add support for
> >> >> > them.
> >> >> >
> >> >> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >> >> > ---
> >> >> >  drivers/gpu/drm/sun4i/sun4i_backend.c | 20 ++++++++++++++++++++
> >> >> >  drivers/gpu/drm/sun4i/sun4i_layer.c   |  6 ++++++
> >> >> >  2 files changed, 26 insertions(+)
> >> >> >
> >> >> > diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
> >> >> > index afb7ddf660ef..b184a476a480 100644
> >> >> > --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> >> >> > +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> >> >> > @@ -96,6 +96,22 @@ static int sun4i_backend_drm_format_to_layer(struct drm_plane *plane,
> >> >> >                 *mode = SUN4I_BACKEND_LAY_FBFMT_ARGB8888;
> >> >> >                 break;
> >> >> >
> >> >> > +       case DRM_FORMAT_ARGB4444:
> >> >> > +               *mode = SUN4I_BACKEND_LAY_FBFMT_ARGB4444;
> >> >> > +               break;
> >> >> > +
> >> >> > +       case DRM_FORMAT_ARGB1555:
> >> >> > +               *mode = SUN4I_BACKEND_LAY_FBFMT_ARGB1555;
> >> >> > +               break;
> >> >> > +
> >> >> > +       case DRM_FORMAT_RGBA5551:
> >> >> > +               *mode = SUN4I_BACKEND_LAY_FBFMT_RGBA5551;
> >> >> > +               break;
> >> >> > +
> >> >> > +       case DRM_FORMAT_RGBA4444:
> >> >> > +               *mode = SUN4I_BACKEND_LAY_FBFMT_RGBA4444;
> >> >>
> >> >> The A20 manual only lists ARGB4444, not RGBA4444. There might be
> >> >> some discrepancy here. We can deal with them
> >> >
> >> > Hmm, yes, that's weird. But I guess this would be part of porting it
> >> > to the A20.
> >> >
> >> >> Also there are some more formats missing from the list, could you
> >> >> add them as well?
> >> >
> >> > Which one do you refer to?
> >>
> >> RGB556 and RGB655.
> >
> > These formats are not supported by Linux yet though.
> 
> I see. Sorry for the noise.
> 
> Acked-by: Chen-Yu Tsai <wens@csie.org>

Applied with a more verbose commit log.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161102/5e496141/attachment.sig>
