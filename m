From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 24 May 2012 08:31:27 +0200
Subject: 
In-Reply-To: <4FBB9D71.5040906@metafoo.de>
References: <1337344032-25431-1-git-send-email-s.hauer@pengutronix.de>
 <4FBB9D71.5040906@metafoo.de>
Message-ID: <20120524063127.GX30400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2012 at 04:06:41PM +0200, Lars-Peter Clausen wrote:
> On 05/18/2012 02:27 PM, Sascha Hauer wrote:
> > Hi All,
> > 
> > The following adds a drm/kms driver for the Freescale i.MX LCDC
> > controller. Most notable change to the last SDRM based version is that
> > the SDRM layer has been removed and the driver now is purely i.MX
> > specific. I hope that this is more acceptable now.
> > 
> > Another change is that the probe is now devicetree based. For now I
> > took the easy way out and only put an edid blob into the devicetree.
> > I haven't documented the binding yet, I would add that when the rest
> > is considered ok.
> > 
> > Comments very welcome.
> > 
> 
> Hi,
> 
> I really liked the sdrm layer. At least some bits of it. I've been working
> on a "simple" DRM driver as well. The hardware has no fancy acceleration
> features, just a simple buffer and some scanout logic. I'm basically using
> the same gem buffer structure and the buffer is also allocated using
> dma_alloc_writecombine, which means we can probably share all of the GEM
> handling code and probably also most of the fbdev code. I also started with
> the Exynos GEM code as a template, but reworked it later to be more like the
> UDL code, which made it a bit more compact. I think it would be a good idea
> to put at least the GEM handling in some common code as I expect that we'll
> see more similar "simple" DRM drivers pop up.

Ok, I'll try to put the GEM stuff into helper functions. Would you care
to review/test it? I have something else to do right now but I hope I'll
be there next week.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
