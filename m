From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Sat, 28 Apr 2018 13:20:21 +0200
Subject: [PATCH 16/27] dt-bindings: cp110: prepare the syscon file to
 list other syscons nodes
In-Reply-To: <20180427210603.fkcuxnug3rgq3wjl@rob-hp-laptop>
References: <20180421151255.29929-1-miquel.raynal@bootlin.com>
 <20180421151255.29929-17-miquel.raynal@bootlin.com>
 <20180427210603.fkcuxnug3rgq3wjl@rob-hp-laptop>
Message-ID: <20180428132021.46883eb8@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Fri, 27 Apr 2018 16:06:03 -0500, Rob Herring <robh@kernel.org> wrote:

> On Sat, Apr 21, 2018 at 05:12:44PM +0200, Miquel Raynal wrote:
> > There are multiple system controllers in CP110. Because all syscon nodes
> > use the same compatible, it is pertinent to use this same file to list
> > IPs inside it. Thus, change the header to be more generic, and align
> > with AP806 file.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > ---
> >  .../bindings/arm/marvell/cp110-system-controller.txt       | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
> > index 29cdbae6c5ac..56e7fb1153e7 100644
> > --- a/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
> > +++ b/Documentation/devicetree/bindings/arm/marvell/cp110-system-controller.txt
> > @@ -1,15 +1,15 @@
> > -Marvell Armada CP110 System Controller 0
> > -========================================
> > +Marvell Armada CP110 System Controller
> > +======================================
> >  
> >  The CP110 is one of the two core HW blocks of the Marvell Armada 7K/8K
> > -SoCs. It contains two sets of system control registers, System
> > -Controller 0 and System Controller 1. This Device Tree binding allows
> > -to describe the first system controller, which provides registers to
> > -configure various aspects of the SoC.
> > +SoCs. It contains system controllers, which provide several registers  
> 
> Is this really multiple discrete blocks?

I can't tell for sure, but the specification clearly names the
#6f8000-#6f9000 region as "AP General Management Registers" and does
not refer in any manner to the other (already described) syscon at
#6f4000-#6f6000 which is used for clocks and pinctrl management
already.

> 
> > +giving access to numerous features: clocks, pin-muxing and many other
> > +SoC configuration items. This DT binding allows to describe these
> > +system controllers.
> >  
> >  For the top level node:
> >   - compatible: must be: "syscon", "simple-mfd";
> > - - reg: register area of the CP110 system controller 0
> > + - reg: register area of the CP110 system controller
> >  
> >  Clocks:
> >  -------
> > -- 
> > 2.14.1
> >   

Regards,
Miqu?l
