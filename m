From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 20 Nov 2018 16:45:32 +0100
Subject: [PATCH v2 03/12] drm/sun4i: sun6i_mipi_dsi: Setup burst mode
 timings
In-Reply-To: <CAMty3ZBDBDqtH5_m4g-kkKKx+JqcC-r9mc-H+_WWgkLubMWPew@mail.gmail.com>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-4-jagan@amarulasolutions.com>
 <20181119083036.riydru5xefao3xte@flea>
 <CAMty3ZBDBDqtH5_m4g-kkKKx+JqcC-r9mc-H+_WWgkLubMWPew@mail.gmail.com>
Message-ID: <20181120154532.mykbbrc3homwf2fi@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2018 at 04:30:37PM +0530, Jagan Teki wrote:
> On Mon, Nov 19, 2018 at 2:00 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Fri, Nov 16, 2018 at 10:09:07PM +0530, Jagan Teki wrote:
> > > Burst mode display timings are different from convectional
> > > video mode so update the horizontal and vertical timings.
> > >
> > > Reference code taken from BSP (from linux-sunxi/
> > > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > >
> > > dsi_hsa  = 0;
> > > dsi_hbp  = 0;
> > > dsi_hact = x*dsi_pixel_bits[format]/8;
> > > dsi_hblk = dsi_hact;
> > > dsi_hfp  = 0;
> > > dsi_vblk = 0;
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >
> > How is that matching the code you have in the rest of your patch?
> 
> +       if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
> +               timings.hblk = (mode->hdisplay * Bpp);
> +       else
> +               sun6i_dsi_get_timings(dsi, mode, &timings);
> 
> It's again your request to "keep the couple of function to make more
> readable"

That function in particular doesn't make it much more readable, but
more importantly, your commit log doesn't match what you code does.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181120/5d8cb82f/attachment-0001.sig>
