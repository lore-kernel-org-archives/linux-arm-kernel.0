From: madalin.bucur@nxp.com (Madalin-Cristian Bucur)
Date: Fri, 12 May 2017 14:14:12 +0000
Subject: [PATCH 1/3] dts: arm64: add DPAA QBMan portals
In-Reply-To: <20170331014945.GH683@dragon>
References: <1490884672-18294-1-git-send-email-madalin.bucur@nxp.com>
 <1490884672-18294-2-git-send-email-madalin.bucur@nxp.com>
 <20170331014945.GH683@dragon>
Message-ID: <AM5PR0402MB269109AD8E249CAD01C94BA1ECE20@AM5PR0402MB2691.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Friday, March 31, 2017 4:50 AM
> On Thu, Mar 30, 2017 at 05:37:50PM +0300, Madalin Bucur wrote:
> > Add the DPAA 1.x DPAA QMan and BMan portal nodes.
> >
> > Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
> > Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
> 
> The patches should be prefixed like 'arm64: dts: ...'.
> 
> > ---
> >  .../boot/dts/freescale/qoriq-bman1-portals.dtsi    | 67
> +++++++++++++++++++
> >  .../boot/dts/freescale/qoriq-qman1-portals.dtsi    | 76
> ++++++++++++++++++++++
> >  2 files changed, 143 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/qoriq-bman1-
> portals.dtsi
> >  create mode 100644 arch/arm64/boot/dts/freescale/qoriq-qman1-
> portals.dtsi
> 
> What does the suffix number '1' mean here?

Will be removed, was used to differentiate between different revisions
on PPC, inherited from there.

> >
> > diff --git a/arch/arm64/boot/dts/freescale/qoriq-bman1-portals.dtsi
> b/arch/arm64/boot/dts/freescale/qoriq-bman1-portals.dtsi
> > new file mode 100644
> > index 0000000..b007344
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/qoriq-bman1-portals.dtsi
> > @@ -0,0 +1,67 @@
> > +/*
> > + * QorIQ BMan Portals device tree
> > + *
> > + * Copyright 2011-2016 Freescale Semiconductor Inc.
> > + *
> > + * SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> > + */
> > +
> > +&bportals {
> > +	#address-cells = <1>;
> > +	#size-cells = <1>;
> > +	compatible = "simple-bus";
> > +
> > +	bman-portal at 0 {
> > +		compatible = "fsl,bman-portal";
> 
> The bindings/soc/fsl/bman-portals.txt says: Must include
> "fsl,bman-portal-<hardware revision>".

This is satisfied by device tree fix-ups performed by the bootloader
adding the correct version. I'll introduce a comment about this here.

> > +		reg = <0x0 0x4000 0x4000000 0x4000>;
> 
> Can we write it in the same way how the example in the bindings doc
> does?
> 
> 	reg = <0x0 0x4000>, <0x4000000 0x4000>;
> 
> It's more obvious to tell that it has two memory regions.

Will change that.
 
> > +		interrupts = <0 173 0x4>;
> 
> Can we use GIC_SPI and IRQ_TYPE_LEVEL_HIGH which are defined by
> headers in include/dt-bindings/interrupt-controller/ to make it more
> readable?

Yes, done.

> Shawn
<snip>

Thanks,
Madalin
