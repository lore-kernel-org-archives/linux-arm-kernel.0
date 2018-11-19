From: jagan@amarulasolutions.com (Jagan Teki)
Date: Mon, 19 Nov 2018 16:30:37 +0530
Subject: [PATCH v2 03/12] drm/sun4i: sun6i_mipi_dsi: Setup burst mode
 timings
In-Reply-To: <20181119083036.riydru5xefao3xte@flea>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-4-jagan@amarulasolutions.com>
 <20181119083036.riydru5xefao3xte@flea>
Message-ID: <CAMty3ZBDBDqtH5_m4g-kkKKx+JqcC-r9mc-H+_WWgkLubMWPew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2018 at 2:00 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, Nov 16, 2018 at 10:09:07PM +0530, Jagan Teki wrote:
> > Burst mode display timings are different from convectional
> > video mode so update the horizontal and vertical timings.
> >
> > Reference code taken from BSP (from linux-sunxi/
> > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> >
> > dsi_hsa  = 0;
> > dsi_hbp  = 0;
> > dsi_hact = x*dsi_pixel_bits[format]/8;
> > dsi_hblk = dsi_hact;
> > dsi_hfp  = 0;
> > dsi_vblk = 0;
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>
> How is that matching the code you have in the rest of your patch?

+       if (device->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+               timings.hblk = (mode->hdisplay * Bpp);
+       else
+               sun6i_dsi_get_timings(dsi, mode, &timings);

It's again your request to "keep the couple of function to make more readable"
