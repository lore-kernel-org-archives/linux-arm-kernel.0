From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 06 Nov 2013 13:22:44 +0100
Subject: [PATCH 2/3] clk: shmobile: Add MSTP clock support
In-Reply-To: <20131106020928.GA17384@verge.net.au>
References: <1383058511-26046-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383058511-26046-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131106020928.GA17384@verge.net.au>
Message-ID: <2388201.Z5FWo3Tb4E@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wednesday 06 November 2013 11:09:31 Simon Horman wrote:
> On Tue, Oct 29, 2013 at 03:55:10PM +0100, Laurent Pinchart wrote:
> > MSTP clocks are gate clocks controlled through a register that handles
> > up to 32 clocks. The register is often sparsely populated.
> > 
> > Those clocks are found on Renesas ARM SoCs.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >  .../bindings/clock/renesas,cpg-mstp-clocks.txt     |  47 +++++
> >  drivers/clk/shmobile/Makefile                      |   1 +
> >  drivers/clk/shmobile/clk-mstp.c                    | 229 ++++++++++++++++
> >  include/dt-bindings/clock/r8a7790-clock.h          |  56 +++++
> >  4 files changed, 333 insertions(+)
> >  create mode 100644
> >  Documentation/devicetree/bindings/clock/renesas,cpg-mstp-clocks.txt
> >  create mode 100644 drivers/clk/shmobile/clk-mstp.c
> >  create mode 100644 include/dt-bindings/clock/r8a7790-clock.h
> 
> [snip]
> 
> > diff --git a/include/dt-bindings/clock/r8a7790-clock.h
> > b/include/dt-bindings/clock/r8a7790-clock.h new file mode 100644
> > index 0000000..19f2b48
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/r8a7790-clock.h
> 
> I wonder if it would be best to put this in a separate patch
> as it is SoC-specific.
> 
> > @@ -0,0 +1,56 @@
> > +/*
> > + * Copyright 2013 Ideas On Board SPRL
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + */
> > +
> > +#ifndef __DT_BINDINGS_CLOCK_R8A7790_H__
> > +#define __DT_BINDINGS_CLOCK_R8A7790_H__
> > +
> > +/* MSTP1 */
> > +#define R8A7790_CLK_CMT0		20
> 
> I believe that R8A7790_CLK_CMT0 should be 24.

Good catch, thank you.

> > +
> > +/* MSTP2 */
> > +#define R8A7790_CLK_SCIFA2		2
> > +#define R8A7790_CLK_SCIFA1		3
> > +#define R8A7790_CLK_SCIFA0		4
> > +#define R8A7790_CLK_SCIFB0		6
> > +#define R8A7790_CLK_SCIFB1		7
> > +#define R8A7790_CLK_SCIFB2		16
> > +
> > +/* MSTP3 */
> > +#define R8A7790_CLK_TPU0		4
> > +#define R8A7790_CLK_MMCIF1		5
> > +#define R8A7790_CLK_SDHI3		11
> > +#define R8A7790_CLK_SDHI2		12
> > +#define R8A7790_CLK_SDHI1		13
> > +#define R8A7790_CLK_SDHI0		14
> > +#define R8A7790_CLK_MMCIF0		15
> > +
> > +/* MSTP5 */
> > +#define R8A7790_CLK_THERMAL		22
> > +
> > +/* MSTP7 */
> > +#define R8A7790_CLK_HSCIF1		16
> > +#define R8A7790_CLK_HSCIF0		17
> > +#define R8A7790_CLK_SCIF1		20
> > +#define R8A7790_CLK_SCIF0		21
> > +#define R8A7790_CLK_DU2			22
> > +#define R8A7790_CLK_DU1			23
> > +#define R8A7790_CLK_DU0			24
> > +#define R8A7790_CLK_LVDS1		25
> > +#define R8A7790_CLK_LVDS0		26
> > +
> > +/* MSTP8 */
> > +#define R8A7790_CLK_ETHER		13
> > +
> > +/* MSTP9 */
> > +#define R8A7790_CLK_I2C3		28
> > +#define R8A7790_CLK_I2C2		29
> > +#define R8A7790_CLK_I2C1		30
> > +#define R8A7790_CLK_I2C0		31
> > +
> > +#endif /* __DT_BINDINGS_CLOCK_R8A7790_H__ */
-- 
Regards,

Laurent Pinchart
