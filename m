From: srv_yingjoe.chen@mediatek.com (Joe.C)
Date: Fri, 22 Aug 2014 16:39:11 +0800
Subject: [RESEND PATCH v2 4/4] dt-bindings: add bindings for mediatek
 intpol
In-Reply-To: <CABuKBeJ0OsaBex_5D9tazTVZX1T8pnUjG7v0nVay-jzqL2nuqQ@mail.gmail.com>
References: <1407895884-18131-1-git-send-email-srv_yingjoe.chen@mediatek.com>
 <1407895884-18131-5-git-send-email-srv_yingjoe.chen@mediatek.com>
 <CABuKBeJ0OsaBex_5D9tazTVZX1T8pnUjG7v0nVay-jzqL2nuqQ@mail.gmail.com>
Message-ID: <1408696751.27728.61.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi, Rob,

Would you help to review this DT bindings and give us some
suggestions? Matthias suggests moving this to
Documentation/devicetree/bindings/arm/mediatek/mediatek,intpol.txt
I think that's a better place for this. What do you think?

Joe.C

On Thu, 2014-08-21 at 17:02 +0200, Matthias Brugger wrote:
> 2014-08-13 4:11 GMT+02:00 Joe.C <srv_yingjoe.chen@mediatek.com>:
> > From: "Joe.C" <yingjoe.chen@mediatek.com>
> >
> > Add binding documentation for Mediatek SoC GIC interrupt polarity extension.
> >
> > Signed-off-by: Joe.C <yingjoe.chen@mediatek.com>
> > ---
> >  .../bindings/interrupt-controller/mediatek,intpol.txt    | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mediatek,intpol.txt
> 
> I think the place for the file should be in
> Documentation/devicetree/bindings/arm/mediatek/mediatek,intpol.txt as
> it is a interrupt-controller extension of the mediatek architecture.
> 
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,intpol.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,intpol.txt
> > new file mode 100644
> > index 0000000..16ea372
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,intpol.txt
> > @@ -0,0 +1,16 @@
> > +Mediatek 65xx/81xx GIC interrupt polarity extension
> > +
> > +Mediatek SOCs contain controllable inverter for each GIC SPI interrupt,
> > +these can be used as GIC interrupt polarity extension.
> > +
> > +Required properties:
> > +- compatible: Compatible property value should be "mediatek,mt6577-intpol"
> > +
> > +- reg: Physical base address of the int pol registers and length of memory
> > +  mapped region.
> > +
> > +Example:
> > +       intpol: intpol at 10200100 {
> > +               compatible = "mediatek,mt6577-intpol";
> > +               reg = <0x10200100 0x1c>;
> > +       };
> > --
> > 1.8.1.1.dirty
> >
> 
> 
> 
