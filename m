From: horms@verge.net.au (Simon Horman)
Date: Sat, 6 Sep 2014 10:14:00 +0900
Subject: [PATCH v2 1/3] clocksource: sh_cmt: Document SoC specific bindings
In-Reply-To: <6240436.VfJ5CJaKOx@avalon>
References: <1409792121-28912-1-git-send-email-horms+renesas@verge.net.au>
 <1409792121-28912-2-git-send-email-horms+renesas@verge.net.au>
 <6240436.VfJ5CJaKOx@avalon>
Message-ID: <20140906011359.GB16116@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 04, 2014 at 09:58:40AM +0300, Laurent Pinchart wrote:
> Hi Simon,
> 
> A couple of other small issues I've missed.
> 
> On Thursday 04 September 2014 09:55:19 Simon Horman wrote:
> > In general Renesas hardware is not documented to the extent
> > where the relationship between IP blocks on different SoCs can be assumed
> > although they may appear to operate the same way. Furthermore the
> > documentation typically does not specify a version for individual
> > IP blocks. For these reasons a convention of using the SoC name in place
> > of a version and providing SoC-specific compat strings has been adopted.
> > 
> > Although not universally liked this convention is used in the bindings for
> > a number of drivers for Renesas hardware. The purpose of this patch is to
> > update the Renesas R-Car Compare Match Timer (CMT) driver to follow this
> > convention.
> > 
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > 
> > ---
> > * I plan to follow up with patches to use these new bindings in the
> >   dtsi files for the affected SoCs.
> > 
> > v2
> > * Reorder compat entries so more-specific entries and their fallbacks
> >   are grouped with the fallback entry coming last.
> > * Explicitly document fallback
> > ---
> >  .../devicetree/bindings/timer/renesas,cmt.txt      | 44 ++++++++++++++++---
> >  1 file changed, 38 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
> > b/Documentation/devicetree/bindings/timer/renesas,cmt.txt index
> > a17418b..7b44f4b 100644
> > --- a/Documentation/devicetree/bindings/timer/renesas,cmt.txt
> > +++ b/Documentation/devicetree/bindings/timer/renesas,cmt.txt
> > @@ -11,15 +11,47 @@ datasheets.
> > 
> >  Required Properties:
> > 
> > -  - compatible: must contain one of the following.
> > -    - "renesas,cmt-32" for the 32-bit CMT
> > +  - compatible: must contain one or more of the following:
> > +    - "renesas,cmt-32-r8a7740" for the R8a7740 32-bit CMT
> 
> s/R8a7740/R8A7740/
> 
> > +		(CMT0)
> > +    - "renesas,cmt-32-sh7372" for the SH7372 32-bit CMT
> > +		(CMT0)
> > +    - "renesas,cmt-32-sh73a0" for the SH73a0 32-bit CMT
> 
> s/SH73a0/SH73A0/

Thanks, I have decided to go for lower case instead.
That is consistent with other nearby usage in the same file.

[snip]
