From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 21 Oct 2013 11:27:30 +0200
Subject: ARM topic: Is DT on ARM the solution, or is there something
 better?
In-Reply-To: <20131021084854.GV25034@n2100.arm.linux.org.uk>
References: <52644A9E.3060007@wwwdotorg.org>
 <20131020231134.GR25034@n2100.arm.linux.org.uk>
 <20131021083242.GB30088@pengutronix.de>
 <20131021084854.GV25034@n2100.arm.linux.org.uk>
Message-ID: <20131021092730.GF30088@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 21, 2013 at 09:48:54AM +0100, Russell King - ARM Linux wrote:
> On Mon, Oct 21, 2013 at 10:32:42AM +0200, Sascha Hauer wrote:
> > On Mon, Oct 21, 2013 at 12:11:34AM +0100, Russell King - ARM Linux wrote:
> > 
> > In fact it was the other way round. We modeled the IPU devicetree
> > binding after the hardware and bended the driver around it. The DRM
> > single-card model is the limiting fator here, not the devicetree.
> 
> There are several points which I think you failed to understand:
> 
> 1. DRM vs device tree is an incompatibility.

I do understand that.

> 2. Trying to bend DRM to DT with independent driver solutions such as
>    the abomination that is imx-drm creates its own set of problems.

I also see this.

> 
> If a subsystem doesn't work well with DT, then the choices are either:
> 
> (a) don't use DT with the subsystem

The underlying problem has nothing to do with DT. Multi component
hardware does exist and won't vanish when we stop using DT.

> (b) fix the subsystem

I'd love to do that. Step one to this seems to be to increase the
awareness that there's something wrong with DRM.

> 
> The choices do not include:
> 
> (c) creating an abomination that is fragile, and is trivially easy to
> oops the kernel.
> 
> This comes back to the root problem I'm trying to highlight: we are not
> trying to strive for DT forsaking everything else.  If moving to DT
> means we give up with proper code design, then we've quite literally
> lost the plot.

The imx-drm driver has problems, but I don't see how they can be solved
by not using DT.

I think imx-drm shouldn't be used as a vehicle to show that DT is a
failure.

If you have a better vision how imx-drm can be implemented without
getting crazy I'd love to hear about it. Please also think about the two
IPUs the i.MX6 has, the single one on i.MX5, parallel displays, HDMI
displays, LVDS displays, VGA encoder on i.MX53, external I2C slave
encoders,...

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
