From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Jul 2015 21:47:47 +0100
Subject: [PATCH 1/7] dt-bindings: add Marvell PMU documentation
In-Reply-To: <CAL_JsqJRyasT49x6JLhy-X0psfT=cUom_RMkFQScqqLzeggUzQ@mail.gmail.com>
References: <20150715185859.GC7557@n2100.arm.linux.org.uk>
 <E1ZFRtu-0003lu-Ft@rmk-PC.arm.linux.org.uk>
 <CAL_JsqJRyasT49x6JLhy-X0psfT=cUom_RMkFQScqqLzeggUzQ@mail.gmail.com>
Message-ID: <20150715204747.GG7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 15, 2015 at 03:39:19PM -0500, Rob Herring wrote:
> On Wed, Jul 15, 2015 at 1:59 PM, Russell King
> <rmk+kernel@arm.linux.org.uk> wrote:
> > Add the required DT binding documentation for the Marvell PMU driver.
> 
> Looks mostly fine to me.
> 
> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > ---
> >  Documentation/devicetree/bindings/soc/dove/pmu.txt | 56 ++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/dove/pmu.txt
> >
> > diff --git a/Documentation/devicetree/bindings/soc/dove/pmu.txt b/Documentation/devicetree/bindings/soc/dove/pmu.txt
> > new file mode 100644
> > index 000000000000..edd40b796b74
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/dove/pmu.txt
> > @@ -0,0 +1,56 @@
> > +Device Tree bindings for Marvell PMU
> > +
> > +Required properties:
> > + - compatible: value should be "marvell,dove-pmu".
> > +    May also include "simple-bus" if there are child devices, in which
> > +    case the ranges node is required.
> > + - reg: two base addresses and sizes of the PM controller and PMU.
> > + - interrupts: single interrupt number for the PMU interrupt
> > + - interrupt-controller: must be specified as the PMU itself is an
> > +    interrupt controller.
> > + - #interrupt-cells: must be 1.
> > + - #reset-cells: must be 1.
> > + - domains: sub-node containing domain descriptions
> > +
> > +Optional properties:
> > + - ranges: defines the address mapping for child devices, as per the
> > +   standard property of this name.  Required when compatible includes
> > +   "simple-bus".
> 
> When would this be used? Your example has child devices, but not this.

Precisely as it says.  No, my example does not have child devices, it
has child nodes which describe the power domains.

"simple-bus" is needed when we list sub-devices of the PMU below it,
such as the RTC, pinmux, clock gating, and GPIO, all of which already
exist today above the PMU, incorrectly (IMHO) described as individual
separate devices.  Please see patch 2, which modifies the Dove DT
file moving these devices below the PMU, as I previously stated was
my intent to do during discussion of the last submission.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
