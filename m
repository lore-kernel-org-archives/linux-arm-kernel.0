From: horms@verge.net.au (Simon Horman)
Date: Wed, 29 Nov 2017 12:22:20 +0100
Subject: [PATCH 1/2] arm64: dts: renesas: initial V3MSK board device tree
In-Reply-To: <06d59459-86dc-89b1-a0ed-adbd1481abc6@cogentembedded.com>
References: <20171124210313.219761525@cogentembedded.com>
 <20171129095109.d2uan35eui4kzav6@verge.net.au>
 <06d59459-86dc-89b1-a0ed-adbd1481abc6@cogentembedded.com>
Message-ID: <20171129112219.7pw5kjwxcvi2r2bn@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 29, 2017 at 01:14:21PM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 11/29/2017 12:51 PM, Simon Horman wrote:
> 
> > > Add the initial device  tree for the V3M Starter Kit board.
> > > The board has 1 debug serial port (SCIF0); include support for it,
> > > so that the serial console can work.
> > > 
> > > Based on the original (and large) patch by Vladimir Barinov.
> > > 
> > > Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> > > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > > 
> > > ---
> > >   arch/arm64/boot/dts/renesas/Makefile           |    2 -
> [...]
> > > Index: renesas/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
> > > ===================================================================
> > > --- /dev/null
> > > +++ renesas/arch/arm64/boot/dts/renesas/r8a77970-v3msk.dts
> > > @@ -0,0 +1,44 @@
> > > +/*
> > > + * Device Tree Source for the V3M Starter Kit board
> > > + *
> > > + * Copyright (C) 2017 Renesas Electronics Corp.
> > > + * Copyright (C) 2017 Cogent Embedded, Inc.
> > > + *
> > > + * This file is licensed under the terms of the GNU General Public License
> > > + * version 2.  This program is licensed "as is" without any warranty of any
> > > + * kind, whether express or implied.
> > > + */
> > > +
> > > +/dts-v1/;
> > > +#include "r8a77970.dtsi"
> > > +
> > > +/ {
> > > +	model = "Renesas V3M Starter Kit board";
> > > +	compatible = "renesas,v3msk", "renesas,r8a77970";
> > > +
> > > +	aliases {
> > > +		serial0 = &scif0;
> > > +	};
> > > +
> > > +	chosen {
> > 
> > For consistency with other Renesas boards I would like to request the
> > following be added here:
> > 
> > 		bootargs = "ignore_loglevel rw";
> 
>    There's currently no consistency as ulcb.dtsi doesn't seem to specify
> "bootargs" prop at all. Moreover, this prop seems to be ignored by ARM64
> kernel -- I can only specify "bootargs" in U-Boot....

I had assumed that ulcb.dtsi should be updated in this regards but
I now see that bootargs does not seem to have any effect (on
r8a7796/salvator-x) as you suggest.

I have applied this and the following patch.
