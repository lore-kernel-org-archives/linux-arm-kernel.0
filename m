From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Mon, 24 Nov 2014 23:14:27 +0800
Subject: [PATCH v7 4/4] dt-bindings: add bindings for mediatek sysirq
In-Reply-To: <20141119180724.GE12851@leverpostej>
References: <1416406451-4578-1-git-send-email-yingjoe.chen@mediatek.com>
 <1416406451-4578-5-git-send-email-yingjoe.chen@mediatek.com>
 <20141119180724.GE12851@leverpostej>
Message-ID: <1416842067.28838.20.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Mark,

On Wed, 2014-11-19 at 18:07 +0000, Mark Rutland wrote:
> On Wed, Nov 19, 2014 at 02:14:11PM +0000, Yingjoe Chen wrote:
> > Add binding documentation for Mediatek SoC SYSIRQ.
> > 
> > Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> > ---
> >  .../bindings/arm/mediatek/mediatek,sysirq.txt      | 26 ++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt
> > new file mode 100644
> > index 0000000..8669536
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt
> > @@ -0,0 +1,26 @@
> > +Mediatek 65xx/81xx sysirq
> > +
> > +Mediatek SOCs sysirq support controllable irq inverter for each GIC SPI
> > +interrupt.
> > +
> > +Required properties:
> > +- compatible: should be one of:
> > +	"mediatek,mt8135-sysirq"
> > +	"mediatek,mt8127-sysirq"
> > +	"mediatek,mt6589-sysirq"
> > +	"mediatek,mt6582-sysirq"
> > +	"mediatek,mt6577-sysirq"
> > +- interrupt-controller : Identifies the node as an interrupt controller
> > +- #interrupt-cells : Must use the same cells/format as parent controller.
> > +- interrupt-parent: phandle of irq domain parent for sysirq.
> 
> I'm concerned that this sounds very general while the binding assumes
> the GICv2 interrupt-specifier format. Either the driver needs to become
> more general, or this needs to be tightened up.
> 
> It's also odd to say "irq domain parent", as that's purely a Linux
> construct and has nothing to do with the HW.

The implementation expect the parent to use the same interrupt-cells
format as GIC. Based on the block diagram in the cover-letter, we could
say GIC is the irq parent of sysirq. So I'm planning to change to this,
hope this is OK.

- #interrupt-cells : Use the same format as specified by GIC in
  Documentation/devicetree/bindings/arm/gic.txt
- interrupt-parent: phandle of irq parent for sysirq. The parent must
  use the same interrupt-cells format as GIC.

Joe.C
