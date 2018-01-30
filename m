From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Tue, 30 Jan 2018 21:14:14 +0900
Subject: [PATCH 1/4] dt-bindings: dwc3: add binding documentation for
 UniPhier dwc3 glue driver
In-Reply-To: <20180130000653.rvxqttpwz2mf2yrm@rob-hp-laptop>
References: <1516712454-2915-2-git-send-email-hayashi.kunihiko@socionext.com>
 <20180130000653.rvxqttpwz2mf2yrm@rob-hp-laptop>
Message-ID: <20180130211413.D3F5.4A936039@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

Thank you for your comments.

On Mon, 29 Jan 2018 18:06:53 -0600 <robh@kernel.org> wrote:

> On Tue, Jan 23, 2018 at 10:00:51PM +0900, Kunihiko Hayashi wrote:
> > Add devicetree binding documentation for dwc3 glue driver implemented
> > on Socionext UniPhier SoCs.
> > 
> > Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> > ---
> >  .../devicetree/bindings/usb/dwc3-uniphier.txt      | 58 ++++++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/usb/dwc3-uniphier.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/dwc3-uniphier.txt b/Documentation/devicetree/bindings/usb/dwc3-uniphier.txt
> > new file mode 100644
> > index 0000000..677e072
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/usb/dwc3-uniphier.txt
> > @@ -0,0 +1,58 @@
> > +UniPhier DWC3 glue layer
> > +
> > +This describes the devicetree bindings for dwc3-uniphier driver implemented on
> > +Socionext UniPhier SoCs.
> > +
> > +Required properties:
> > +- compatible:
> > +  - "socionext,uniphier-pxs2-dwc3" : For UniPhier PXs2 SoC
> > +  - "socionext,uniphier-ld20-dwc3" : For UniPhier LD20 SoC
> > +- reg: Address and range of the glue logic
> > +- clocks: List of phandles for the clocks, and the number of phandles depends
> > +	  on SoC platform.
> 
> Number of clocks needs to be specific. It should be fixed per 
> compatible.

I'll apply dwc3-of-simple framework for core part and separate phy part
from the driver, and as a result the clocks will be separated into clocks
for core and phy.

The core clocks will be described with "clock-names" property like Qualcomm's
dwc3 driver in Documentation/devicetree/bindings/usb/qcom,dwc3.txt.

I think the remaining clocks will be also defined with clock-names properties
or fixed according to the compatible string in the phy driver.

> > +
> > +Optional properties:
> > +- resets: List of phandles for the resets, and the number of phandles depends
> > +	on SoC platform.
> 
> Same here.

Same as above.

Thank you,

---
Best Regards,
Kunihiko Hayashi
