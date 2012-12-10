From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 10 Dec 2012 21:49:56 +0000
Subject: [PATCH 2/2] rtc: rtc-mv: Add the device tree binding documentation
In-Reply-To: <20121210133914.GH21694@titan.lakedaemon.net>
References: <1355136122-30729-1-git-send-email-gregory.clement@free-electrons.com>
 <1355136122-30729-3-git-send-email-gregory.clement@free-electrons.com>
 <20121210133914.GH21694@titan.lakedaemon.net>
Message-ID: <20121210214956.7D2A13E0D09@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 10 Dec 2012 08:39:14 -0500, Jason Cooper <jason@lakedaemon.net> wrote:
> On Mon, Dec 10, 2012 at 11:42:02AM +0100, Gregory CLEMENT wrote:
> > The support was already written, but the binding documentation was
> > lacking.
> 
> Thanks for doing this, Gregory.  I missed this the first time around
> when we added the DT bindings to the rtc driver.
> 
> thx,

Applied the documentation patch, thanks. The code patch should go
through the rtc tree.

g.

> 
> Jason.
> 
> > 
> > Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> > ---
> >  .../devicetree/bindings/rtc/orion-rtc.txt          |   18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rtc/orion-rtc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/rtc/orion-rtc.txt b/Documentation/devicetree/bindings/rtc/orion-rtc.txt
> > new file mode 100644
> > index 0000000..3bf63ff
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rtc/orion-rtc.txt
> > @@ -0,0 +1,18 @@
> > +* Mvebu Real Time Clock
> > +
> > +RTC controller for the Kirkwood, the Dove, the Armada 370 and the
> > +Armada XP SoCs
> > +
> > +Required properties:
> > +- compatible : Should be "marvell,orion-rtc"
> > +- reg: physical base address of the controller and length of memory mapped
> > +  region.
> > +- interrupts: IRQ line for the RTC.
> > +
> > +Example:
> > +
> > +rtc at 10300 {
> > +        compatible = "marvell,orion-rtc";
> > +        reg = <0xd0010300 0x20>;
> > +        interrupts = <50>;
> > +};
> > -- 
> > 1.7.9.5
> > 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.
