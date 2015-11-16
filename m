From: michael@amarulasolutions.com (Michael Trimarchi)
Date: Mon, 16 Nov 2015 12:54:28 +0100
Subject: [PATCH] ARM: dts: imx6q-icore-rqs: Add Engicam IMX6 Q7 initial
 support
In-Reply-To: <1447674695.3144.21.camel@pengutronix.de>
References: <1447584853-12560-1-git-send-email-michael@amarulasolutions.com>
 <1447665552.3144.6.camel@pengutronix.de>
 <20151116112931.GA10464@panicking>
 <1447673895.3144.16.camel@pengutronix.de>
 <20151116114127.GB10464@panicking>
 <1447674695.3144.21.camel@pengutronix.de>
Message-ID: <20151116115421.GC10464@panicking>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Mon, Nov 16, 2015 at 12:51:35PM +0100, Lucas Stach wrote:
> Am Montag, den 16.11.2015, 12:41 +0100 schrieb Michael Trimarchi:
> > Hi
> > 
> > On Mon, Nov 16, 2015 at 12:38:15PM +0100, Lucas Stach wrote:
> > > Am Montag, den 16.11.2015, 12:29 +0100 schrieb Michael Trimarchi:
> > > > Hi
> > > > 
> > > > On Mon, Nov 16, 2015 at 10:19:12AM +0100, Lucas Stach wrote:
> > > > > Am Sonntag, den 15.11.2015, 11:54 +0100 schrieb Michael Trimarchi:
> > > > > > www.engicam.com/en/products/embedded/som/standard/i-core-rqs-m6s-dl-d-q
> > > > > > 
> > > > > > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > > > > > ---
> > > > > >  arch/arm/boot/dts/Makefile               |   1 +
> > > > > >  arch/arm/boot/dts/imx6q-icore-rqs.dts    |  36 +++
> > > > > >  arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi | 372 +++++++++++++++++++++++++++++++
> > > > > >  3 files changed, 409 insertions(+)
> > > > > >  create mode 100644 arch/arm/boot/dts/imx6q-icore-rqs.dts
> > > > > >  create mode 100644 arch/arm/boot/dts/imx6qdl-icore-rqs.dtsi
> > > > > > 
> > > [...]
> > > > > > diff --git a/arch/arm/boot/dts/imx6q-icore-rqs.dts b/arch/arm/boot/dts/imx6q-icore-rqs.dts
> > > > > > new file mode 100644
> > > > > > index 0000000..cded07d
> > > > > > --- /dev/null
> > > > > > +++ b/arch/arm/boot/dts/imx6q-icore-rqs.dts
> > > > > > @@ -0,0 +1,36 @@
> > > > > > +/*
> > > > > > + * Copyright (C) 2015 Amarula Solutions B.V.
> > > > > > + *
> > > > > > + * This program is free software; you can redistribute it and/or modify
> > > > > > + * it under the terms of the GNU General Public License version 2 as
> > > > > > + * published by the Free Software Foundation.
> > > > > > + */
> > > > > > +
> > > > > > +/dts-v1/;
> > > > > > +
> > > > > > +#include "imx6q.dtsi"
> > > > > > +#include "imx6qdl-icore-rqs.dtsi"
> > > > > > +
> > > > > > +/ {
> > > > > > +	model = "Engicam i.CoreM6 Quad SOM";
> > > > > > +	compatible = "fsl,imx6-icore-rqs", "fsl,imx6q";
> > > > > > +	cpus {
> > > > > > +		cpu at 0 {
> > > > > > +			operating-points = <
> > > > > > +				/* kHz    uV */
> > > > > > +				792000  1150000
> > > > > > +				396000  1150000
> > > > > > +			>;
> > > > > > +
> > > > > > +			fsl,soc-operating-points = <
> > > > > > +				/* ARM kHz  SOC-PU uV */
> > > > > > +				792000        1175000
> > > > > > +				396000        1175000
> > > > > > +			>;
> > > > > > +		};
> > > > > Why do you need to edit the OPPS here? Just to fix them on a specific
> > > > > voltage? Why?
> > > > > 
> > > > 
> > > > Board has no pmu regulator
> > > > 
> > > The default i.MX6 configuration (see imx6q.dtsi) is to connect the ARM
> > > and SOC domain to the internal LDOs, so voltage scaling is not dependent
> > > on an external PMIC being present.
> > > 
> > 
> > Sorry, It was a mistake based on original patch. So I need to limit the max
> > allowed frequency suggested by the vendor. So including the operating points
> > that I support. Is this fine?
> > 
> Do you really want to remove the ability to lower voltage for the slower
> OPPs? Also you only need this if the module includes a higher rated SKU,
> that needs to be throttled below its rated max frequency.
> 
> If the module includes a SKU that is rated for 792MHz by Freescale (like
> the industrial ones) the kernel will read the SoC fuses and disable any
> OPPs that are unsupported by the SKU on its own.
>

Yes I will drop. It's totally wrong, thank you for the lesson on fuses


Michael

> Regards,
> Lucas
> 
> -- 
> Pengutronix e.K.             | Lucas Stach                 |
> Industrial Linux Solutions   | http://www.pengutronix.de/  |
> 

-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
