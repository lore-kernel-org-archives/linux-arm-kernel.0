From: horms@verge.net.au (Simon Horman)
Date: Wed, 3 Sep 2014 10:05:49 +0900
Subject: [PATCH 3/3 repost] clocksource: sh_tmu: Document r8a7779 binding
In-Reply-To: <20140827095308.GD7295@leverpostej>
References: <1409117300-2133-1-git-send-email-horms+renesas@verge.net.au>
 <1409117300-2133-4-git-send-email-horms+renesas@verge.net.au>
 <20140827095308.GD7295@leverpostej>
Message-ID: <20140903010549.GD2903@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 10:53:08AM +0100, Mark Rutland wrote:
> On Wed, Aug 27, 2014 at 06:28:20AM +0100, Simon Horman wrote:
> > In general Renesas hardware is not documented to the extent
> > where the relationship between IP blocks on different SoCs can be assumed
> > although they may appear to operate the same way. Furthermore the
> > documentation typically does not specify a version for individual
> > IP blocks. For these reasons a convention of using the SoC name in place
> > of a version and providing SoC-specific compat strings has been adopted.
> > 
> > Although not universally liked this convention is used in the bindings
> > for the drivers a number of drivers for Renesas hardware. The purpose
> > of this patch is to update the Renesas R-Car Timer Unit (TMU)
> > driver to follow this convention.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > 
> > ---
> > * I plan to follow up with a patch patch to use the new binding in the
> >   dtsi files for the r8a7779 SoC.
> > ---
> >  Documentation/devicetree/bindings/timer/renesas,tmu.txt | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/timer/renesas,tmu.txt b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
> > index 425d0c5..712ddfa 100644
> > --- a/Documentation/devicetree/bindings/timer/renesas,tmu.txt
> > +++ b/Documentation/devicetree/bindings/timer/renesas,tmu.txt
> > @@ -8,7 +8,9 @@ are independent. The TMU hardware supports up to three channels.
> >  
> >  Required Properties:
> >  
> > -  - compatible: must contain "renesas,tmu"
> > +  - compatible: must contain one of the following.
> > +    - "renesas,tmu" generic TMU
> > +    - "renesas,tmu-r8a7779" R8A7779 TMU
> 
> Similarly to patch 2, "one or more" and swap the order here?

Sure, will do.
