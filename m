From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 21 Jun 2012 09:06:00 +0200
Subject: [PATCH 2/5] DRM i.MX: Add parallel display support
In-Reply-To: <20120621060730.GA23285@S2101-09.ap.freescale.net>
References: <1339681407-28721-1-git-send-email-s.hauer@pengutronix.de>
 <1339681407-28721-3-git-send-email-s.hauer@pengutronix.de>
 <20120621053554.GC3971@S2101-09.ap.freescale.net>
 <20120621060730.GA23285@S2101-09.ap.freescale.net>
Message-ID: <20120621070600.GY28394@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 21, 2012 at 02:07:32PM +0800, Shawn Guo wrote:
> On Thu, Jun 21, 2012 at 01:35:56PM +0800, Shawn Guo wrote:
> > On Thu, Jun 14, 2012 at 03:43:24PM +0200, Sascha Hauer wrote:
> > > +static const struct of_device_id imx_pd_dt_ids[] = {
> > > +	{ .compatible = "fsl,imx-parallel-display", .data = NULL, },
> > 
> > Can we use particular soc name to define the compatible string?
> 
> Just realized that it's actually not representing any hardware block.
> If that's the case, I feel we should try to get it away from device
> tree.

It actually represents a hardware block, or what else should a display
be? You are right in the way that it does not correspond to some
register block, but still it's hardware.
The information about the connected display must definitely live in the
devicetree, I can't think off any other place.

(We could argue that the displays should be subnodes of the IPU. I have
chosen not to do so because other display connections such as the LVDS
unit are outside of the IPU, but still need a display description.)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
