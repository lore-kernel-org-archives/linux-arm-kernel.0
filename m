From: horms@verge.net.au (Simon Horman)
Date: Wed, 3 Sep 2014 10:02:01 +0900
Subject: [PATCH 2/3 repost] clocksource: sh_mtu2: Document r7s72100 binding
In-Reply-To: <20140827095240.GC7295@leverpostej>
References: <1409117300-2133-1-git-send-email-horms+renesas@verge.net.au>
 <1409117300-2133-3-git-send-email-horms+renesas@verge.net.au>
 <20140827095240.GC7295@leverpostej>
Message-ID: <20140903010201.GA2903@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 10:52:40AM +0100, Mark Rutland wrote:
> On Wed, Aug 27, 2014 at 06:28:19AM +0100, Simon Horman wrote:
> > In general Renesas hardware is not documented to the extent
> > where the relationship between IP blocks on different SoCs can be assumed
> > although they may appear to operate the same way. Furthermore the
> > documentation typically does not specify a version for individual
> > IP blocks. For these reasons a convention of using the SoC name in place
> > of a version and providing SoC-specific compat strings has been adopted.
> > 
> > Although not universally liked this convention is used in the bindings
> > for the drivers a number of drivers for Renesas hardware. The purpose
> > of this patch is to update the Renesas R-Car Multi-Function Timer Pulse
> > Unit 2 (MTU2) driver to follow this convention.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > ---
> > * I plan to follow up with a patch patch to use the new binding in the
> >   dtsi files for the r7s72100 SoC.
> > ---
> >  Documentation/devicetree/bindings/timer/renesas,mtu2.txt | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/timer/renesas,mtu2.txt b/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
> > index 917453f..ec4d334 100644
> > --- a/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
> > +++ b/Documentation/devicetree/bindings/timer/renesas,mtu2.txt
> > @@ -8,7 +8,9 @@ are independent. The MTU2 hardware supports five channels indexed from 0 to 4.
> >  
> >  Required Properties:
> >  
> > -  - compatible: must contain "renesas,mtu2"
> > +  - compatible: must be one of the following.
> 
> Surely "one or more", follwing the example?

Thanks, yes, it should be "one or more".

> > +    - "renesas,mtu2" for generic MTU2
> 
> s/generic/any/ to make it clearer this should be present in all lists
> for the moment?

Sure.

> > +    - "renesas,mtu2-r7s72100" for R7S72100 MTU2
> 
> It might make sense to move this above the "renesas,mtu2" entry to make
> the ordering a bit clearer.

Sure.

> Cheers,
> Mark.
> 
> >  
> >    - reg: base address and length of the registers block for the timer module.
> >  
> > @@ -26,7 +28,7 @@ Required Properties:
> >  Example: R7S72100 (RZ/A1H) MTU2 node
> >  
> >  	mtu2: timer at fcff0000 {
> > -		compatible = "renesas,mtu2";
> > +		compatible = "renesas,mtu2-r7s72100", "renesas,mtu2";
> >  		reg = <0xfcff0000 0x400>;
> >  		interrupts = <0 139 IRQ_TYPE_LEVEL_HIGH>,
> >  			     <0 146 IRQ_TYPE_LEVEL_HIGH>,
> > -- 
> > 2.0.1
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe devicetree" in
> > the body of a message to majordomo at vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
