From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 9 Sep 2016 16:34:13 +0200
Subject: [PATCH 3/6] drm/panel: simple: Add A10 EVB 5 inch panel support
In-Reply-To: <CAGb2v66GsA8uNaaZfnnHFgBLA-LChCnO3vLhdtfzHNU0nHXH4Q@mail.gmail.com>
References: <20160831081817.5191-1-maxime.ripard@free-electrons.com>
 <20160831081817.5191-4-maxime.ripard@free-electrons.com>
 <CAGb2v66GsA8uNaaZfnnHFgBLA-LChCnO3vLhdtfzHNU0nHXH4Q@mail.gmail.com>
Message-ID: <20160909143413.GA8881@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Sep 05, 2016 at 10:00:01PM +0800, Chen-Yu Tsai wrote:
> On Wed, Aug 31, 2016 at 4:18 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > The A10-EVB from Allwinner comes with an unidentified panel, with the only
> > mark on the PCB being A10-SUB-EVB-5LCD.
> >
> > Add timings to simple panel to handle it.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/gpu/drm/panel/panel-simple.c | 26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
> > index 85143d1b9b31..be371b053aab 100644
> > --- a/drivers/gpu/drm/panel/panel-simple.c
> > +++ b/drivers/gpu/drm/panel/panel-simple.c
> > @@ -386,6 +386,29 @@ static void panel_simple_shutdown(struct device *dev)
> >         panel_simple_disable(&panel->base);
> >  }
> >
> > +static const struct drm_display_mode allwinner_a10_sub_evb_5lcd_mode = {
> > +       .clock = 33000,
> > +       .hdisplay = 800,
> > +       .hsync_start = 800 + 209,
> > +       .hsync_end = 800 + 209 + 1,
> > +       .htotal = 800 + 209 + 1 + 45,
> > +       .vdisplay = 480,
> > +       .vsync_start = 480 + 22,
> > +       .vsync_end = 480 + 22 + 1,
> > +       .vtotal = 480 + 22 + 1 + 22,
> > +       .vrefresh = 60,
> 
> I assume the numbers came from the fex file? Allwinner LCD timing numbers
> aren't very precise. This seems to yield a refresh rate of 58.x Hz.
> The dot clock can go below MHz resolution, so it should be possible
> to set it to a more proper clock rate here.

Indeed.

Upon closer inspection, it seems (from the ribbon) that the display is
an hannstar, but there's no screen reference anywhere.

By looking into it using the available references, the date of
production found on that panel, and so on, it seems like it is an
HSD050IDW1-A, whose timings do not seem to far off. But it's pure
speculation at this point.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160909/d72d8656/attachment-0001.sig>
