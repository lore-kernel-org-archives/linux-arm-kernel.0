From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 25 Oct 2016 08:42:26 +0800
Subject: [PATCH] drm/sun4i: Add a few formats
In-Reply-To: <20161024144014.occkqw2v5c2ghx4w@lukather>
References: <20161018084614.2443-1-maxime.ripard@free-electrons.com>
 <CAGb2v65uZFQnRme9LrRykze=a4d_7=HS=Gvu6E_eBG5tSw8nTw@mail.gmail.com>
 <20161024144014.occkqw2v5c2ghx4w@lukather>
Message-ID: <CAGb2v65=6YGaaC3QimPHyP=FKJofygReozmnKLV8CGXvjWGtvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2016 at 10:40 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Fri, Oct 21, 2016 at 11:15:32AM +0800, Chen-Yu Tsai wrote:
>> On Tue, Oct 18, 2016 at 4:46 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > The planes can do more than what was previously exposed. Add support for
>> > them.
>> >
>> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> > ---
>> >  drivers/gpu/drm/sun4i/sun4i_backend.c | 20 ++++++++++++++++++++
>> >  drivers/gpu/drm/sun4i/sun4i_layer.c   |  6 ++++++
>> >  2 files changed, 26 insertions(+)
>> >
>> > diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
>> > index afb7ddf660ef..b184a476a480 100644
>> > --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
>> > +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
>> > @@ -96,6 +96,22 @@ static int sun4i_backend_drm_format_to_layer(struct drm_plane *plane,
>> >                 *mode = SUN4I_BACKEND_LAY_FBFMT_ARGB8888;
>> >                 break;
>> >
>> > +       case DRM_FORMAT_ARGB4444:
>> > +               *mode = SUN4I_BACKEND_LAY_FBFMT_ARGB4444;
>> > +               break;
>> > +
>> > +       case DRM_FORMAT_ARGB1555:
>> > +               *mode = SUN4I_BACKEND_LAY_FBFMT_ARGB1555;
>> > +               break;
>> > +
>> > +       case DRM_FORMAT_RGBA5551:
>> > +               *mode = SUN4I_BACKEND_LAY_FBFMT_RGBA5551;
>> > +               break;
>> > +
>> > +       case DRM_FORMAT_RGBA4444:
>> > +               *mode = SUN4I_BACKEND_LAY_FBFMT_RGBA4444;
>>
>> The A20 manual only lists ARGB4444, not RGBA4444. There might be
>> some discrepancy here. We can deal with them
>
> Hmm, yes, that's weird. But I guess this would be part of porting it
> to the A20.
>
>> Also there are some more formats missing from the list, could you
>> add them as well?
>
> Which one do you refer to?

RGB556 and RGB655.

>
>> > +               break;
>> > +
>> >         case DRM_FORMAT_XRGB8888:
>> >                 *mode = SUN4I_BACKEND_LAY_FBFMT_XRGB8888;
>> >                 break;
>> > @@ -104,6 +120,10 @@ static int sun4i_backend_drm_format_to_layer(struct drm_plane *plane,
>> >                 *mode = SUN4I_BACKEND_LAY_FBFMT_RGB888;
>> >                 break;
>> >
>> > +       case DRM_FORMAT_RGB565:
>> > +               *mode = SUN4I_BACKEND_LAY_FBFMT_RGB565;
>> > +               break;
>> > +
>> >         default:
>> >                 return -EINVAL;
>> >         }
>> > diff --git a/drivers/gpu/drm/sun4i/sun4i_layer.c b/drivers/gpu/drm/sun4i/sun4i_layer.c
>> > index f0035bf5efea..5d53c977bca5 100644
>> > --- a/drivers/gpu/drm/sun4i/sun4i_layer.c
>> > +++ b/drivers/gpu/drm/sun4i/sun4i_layer.c
>> > @@ -73,12 +73,18 @@ static const struct drm_plane_funcs sun4i_backend_layer_funcs = {
>> >  static const uint32_t sun4i_backend_layer_formats_primary[] = {
>> >         DRM_FORMAT_ARGB8888,
>> >         DRM_FORMAT_RGB888,
>> > +       DRM_FORMAT_RGB565,
>> >         DRM_FORMAT_XRGB8888,
>> >  };
>> >
>> >  static const uint32_t sun4i_backend_layer_formats_overlay[] = {
>> >         DRM_FORMAT_ARGB8888,
>> > +       DRM_FORMAT_ARGB4444,
>> > +       DRM_FORMAT_ARGB1555,
>> > +       DRM_FORMAT_RGBA5551,
>> > +       DRM_FORMAT_RGBA4444,
>> >         DRM_FORMAT_RGB888,
>> > +       DRM_FORMAT_RGB565,
>> >         DRM_FORMAT_XRGB8888,
>>
>> Could you explain in the commit log why these 2 aren't the same?
>
> Yep, I will.

Cool! Thanks.

ChenYu

>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
