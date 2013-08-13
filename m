From: s.hauer@pengutronix.de (s.hauer at pengutronix.de)
Date: Tue, 13 Aug 2013 09:46:21 +0200
Subject: =?utf-8?B?562U5aSNOiBbUEFUQw==?=
 =?utf-8?Q?H?= v3 2/2] i2c: imx: Add Vybrid VF610 I2C controller
 support
In-Reply-To: <52096E77.4040003@wwwdotorg.org>
References: <1375418648-22760-1-git-send-email-b35083@freescale.com>
 <1375418648-22760-2-git-send-email-b35083@freescale.com>
 <20130810140827.GC18085@e106331-lin.cambridge.arm.com>
 <B56CDBE15CE27145A4B77D2D24263E851FE7AC@039-SN1MPN1-004.039d.mgd.msft.net>
 <20130812164354.GF27165@e106331-lin.cambridge.arm.com>
 <52096E77.4040003@wwwdotorg.org>
Message-ID: <20130813074620.GR26614@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 12, 2013 at 05:23:35PM -0600, Stephen Warren wrote:
> On 08/12/2013 10:43 AM, Mark Rutland wrote:
> >> The binding string for i2c-imx driver in Documentation/devicetree/bindings/i2c/i2c-imx.txt use a wildcard format
> >> of "- compatible : Should be "fsl,<chip>-i2c" " for device using this driver. Neither fsl,imx1-i2c nor fsl,imx21-i2c
> >> is described in the binding document. So I just leave the vf610 i2c compatible with this. 
> > 
> > I'm not a big fan on wildcards in bindings, as it leaves people free to
> > put anything in and claim it's a documented binding, and makes it far
> > harder for an os to actually implement drivers for said binding, as
> > there's no canonical reference for the set of valid variations.
> > 
> > Obviously there is some precedent, but I'm not sure it's something we
> > want to stick with, and we can prevent it my updating the documentation
> > now.
> > 
> > Does anyone else have an opinion?
> 
> I suppose technically we should list out every exact string in the
> binding, but it's a little annoying to have to update the binding doc
> every time a new chip comes out (and I expect that'll happen more and
> more!) just to add a new compatible value since all the differences are
> known internally to the driver and don't impact the binding...

We would only have to update the the docs when an incompatible SoC comes
out. For this particular driver this would be all marked with a star:

* i.MX1
* i.MX21
  i.MX25
  i.MX27
  i.MX31
  i.MX35
  i.MX51
  i.MX53
  i.MX6
* Vybrid

That's not too many updates to the binding docs since 2001.
(The SPI core changed with nearly every SoC version though)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
