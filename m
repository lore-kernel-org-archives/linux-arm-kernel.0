From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 06 Sep 2018 11:00:14 +0200
Subject: [PATCH v2 1/4] dt-bindings: media: Add i.MX Pixel Pipeline binding
In-Reply-To: <1527575951.28748.1536167436305@email.1und1.de>
References: <20180905100018.27556-1-p.zabel@pengutronix.de>
 <20180905100018.27556-2-p.zabel@pengutronix.de>
 <1527575951.28748.1536167436305@email.1und1.de>
Message-ID: <1536224414.5357.3.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

thank you for your comments.

On Wed, 2018-09-05 at 19:10 +0200, Stefan Wahren wrote:
> Hi Philipp,
> 
> > Philipp Zabel <p.zabel@pengutronix.de> hat am 5. September 2018 um 12:00 geschrieben:
> > 
> > 
> > Add DT binding documentation for the Pixel Pipeline (PXP) found on
> > various NXP i.MX SoCs.
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/media/fsl-pxp.txt     | 26 +++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/fsl-pxp.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/media/fsl-pxp.txt b/Documentation/devicetree/bindings/media/fsl-pxp.txt
> > new file mode 100644
> > index 000000000000..2477e7f87381
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/fsl-pxp.txt
> > @@ -0,0 +1,26 @@
> > +Freescale Pixel Pipeline
> > +========================
> > +
> > +The Pixel Pipeline (PXP) is a memory-to-memory graphics processing engine
> > +that supports scaling, colorspace conversion, alpha blending, rotation, and
> > +pixel conversion via lookup table. Different versions are present on various
> > +i.MX SoCs from i.MX23 to i.MX7.
> > +
> > +Required properties:
> > +- compatible: should be "fsl,<soc>-pxp", where SoC can be one of imx23, imx28,
> > +  imx6dl, imx6sl, imx6ul, imx6sx, imx6ull, or imx7d.
> 
> please correct me if i'm wrong, but the driver in patch #3 only
> support imx6ull 

That is correct.

I assume it should work on i.MX7D mostly unchanged, by just adding a
compatible. The others probably require some register layout changes.

> so this binding is misleading.

I disagree. The binding document specifies how PXP hardware should be
described in the device tree. It should be seen completely separate from
any driver implementation.

There is no reason to leave out SoCs that are known to contain the PXP
from this description just because some driver doesn't implement support
for them. Similarly, there is no reason to remove the second interrupt
just because the current Linux driver doesn't use it.

> As a user i would expect that binding and driver are in sync.

This expectation is at odds with the purpose of DT bindings, which is to
describe the hardware, not to document driver features.

(Which driver, anyway? Drivers for other operating systems or
bootloaders could have a different set of supported SoCs and features).

regards
Philipp
