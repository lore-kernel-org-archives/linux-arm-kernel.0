From: robert@schwebel.de (Robert Schwebel)
Date: Sat, 11 Jan 2014 12:31:19 +0100
Subject: [PATCH RFC 26/46] drivers/base: provide an infrastructure for
 componentised subsystems
In-Reply-To: <20140110232336.GI15937@n2100.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1Vypo6-0007FF-Lb@rmk-PC.arm.linux.org.uk>
 <20140103031055.GB28751@kroah.com>
 <20140110145444.GE15937@n2100.arm.linux.org.uk>
 <20140110150702.GA22533@kroah.com>
 <20140110151123.GG15937@n2100.arm.linux.org.uk>
 <20140110153530.GA770@kroah.com>
 <20140110183021.GZ2400@pengutronix.de>
 <20140110204259.GC10235@kroah.com>
 <20140110232336.GI15937@n2100.arm.linux.org.uk>
Message-ID: <20140111113119.GC2400@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 10, 2014 at 11:23:37PM +0000, Russell King - ARM Linux wrote:
> We do this in DT by providing a "superdevice" node which specifies
> the components, eg:
> 
> 	imx-drm {
> 		compatible = "fsl,drm";
> 		crtcs = <&ipu1>;
> 		connectors = <&hdmi>;
> 	};

Saschas comment from 20140109074030.GN6750 at pengutronix.de isn't
addressed yet:

Sascha Hauer wrote:
> Can we have an example with a different number of
> encoders/connectors/crtcs, like:
> 
> exynos-drm {
>         compatible = "exynos,drm";
>         crtcs = <&fimd1>;
>         encoders = <&dp1>, <&hdmi1>, <&lvds1>;
>         connectors = <&ptn3460>, <&hdmi1>;
> };
> 
> Otherwise I get the impression that there is some topology of the
> components or at least relationship between the components encoded
> into the binding.

If I remember correctly, Sascha+Philipp+Lucas still had issues with the
bindings, but I'm not sure if they have been already addressed.

It's no good timing to finalize this during the weekend, where most
people are not in the office :)

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
