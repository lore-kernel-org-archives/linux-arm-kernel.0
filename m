From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 13 Aug 2018 11:53:29 +0000
Subject: [PATCH] arm64: dts: renesas: Initial r8a774a1 SoC device tree
In-Reply-To: <TY1PR01MB1770F5E92353FD04FC49102AC0390@TY1PR01MB1770.jpnprd01.prod.outlook.com>
References: <1534146093-1651-1-git-send-email-biju.das@bp.renesas.com>
 <TY1PR01MB1770D16DDB50BF579ADF8335C0390@TY1PR01MB1770.jpnprd01.prod.outlook.com>
 <OSBPR01MB2103F339F8BB36042C8AD0E1B8390@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <TY1PR01MB1770CD5C853AA5E765961B11C0390@TY1PR01MB1770.jpnprd01.prod.outlook.com>
 <OSBPR01MB2103F387973ECD078290E060B8390@OSBPR01MB2103.jpnprd01.prod.outlook.com>
 <TY1PR01MB1770F5E92353FD04FC49102AC0390@TY1PR01MB1770.jpnprd01.prod.outlook.com>
Message-ID: <OSBPR01MB2103B51773F6CB1708B93196B8390@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fab,

Thanks for the feedback.

> Subject: RE: [PATCH] arm64: dts: renesas: Initial r8a774a1 SoC device tree
>
> Hello Biju,
>
> > Subject: RE: [PATCH] arm64: dts: renesas: Initial r8a774a1 SoC device
> > tree
> >
> >
> > Hello Fab,
> >
> > > > Subject: RE: [PATCH] arm64: dts: renesas: Initial r8a774a1 SoC
> > > > device tree
> > > >
> > > > Hello Fabrizio,
> > > >
> > > > > Hello Biju,
> > > > >
> > > > > Thank you for your patch.
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Biju Das <biju.das@bp.renesas.com>
> > > > > > Sent: 13 August 2018 08:42
> > > > > > To: Rob Herring <robh+dt@kernel.org>; Mark Rutland
> > > > > > <mark.rutland@arm.com>; Catalin Marinas
> > > <catalin.marinas@arm.com>;
> > > > > > Will Deacon <will.deacon@arm.com>
> > > > > > Cc: Biju Das <biju.das@bp.renesas.com>; Simon Horman
> > > > > > <horms@verge.net.au>; Magnus Damm
> <magnus.damm@gmail.com>;
> > > > > > linux-renesas-soc at vger.kernel.org; devicetree at vger.kernel.org;
> > > > > > linux-arm-kernel at lists.infradead.org; Geert Uytterhoeven
> > > > > > <geert+renesas@glider.be>; Chris Paterson
> > > > > > <Chris.Paterson2@renesas.com>; Fabrizio Castro
> > > > > > <fabrizio.castro@bp.renesas.com>
> > > > > > Subject: [PATCH] arm64: dts: renesas: Initial r8a774a1 SoC
> > > > > > device tree
> > > > > >
> > > > > > Basic support for the RZ/G2M SoC.
> > > > > >
> > > > > > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > > > > > ---
> > > > > >  arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 192
> > > > > > ++++++++++++++++++++++++++++++
> > > > > >  1 file changed, 192 insertions(+)  create mode 100644
> > > > > > arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> > > > > >
> > > > > > diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> > > > > > b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> > > > > > new file mode 100644
> > > > > > index 0000000..f3641c0
> > > > > > --- /dev/null
> > > > > > +++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> > > > > > @@ -0,0 +1,192 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > +/*
> > > > > > + * Device Tree Source for the r8a774a1 SoC
> > > > > > + *
> > > > > > + * Copyright (C) 2018 Renesas Electronics Corp.
> > > > > > + */
> > > > > > +
> > > > > > +#include <dt-bindings/interrupt-controller/irq.h>
> > > > > > +#include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > > > +#include <dt-bindings/clock/renesas-cpg-mssr.h>
> > > > > > +
> > > > > > +#define CPG_AUDIO_CLK_I10
> > > > >
> > > > > I believe there is no use case for this macro, therefore I think
> > > > > this device tree can live without it.
> > > > > With that fixed:
> > > >
> > > > This clock is SoC specific clock similar to R-Car Gen-3 H3/M3/M3N.
> > > > Also the same clock is mentioned in Table  8.2b List of clocks of
> > > > RZ/G2M
> > > hardware manual. So I think it is ok.
> > > >
> > > >  If you think defining SoC specific clock is wrong in this file ,
> > > > we need to fix
> > > other boards as well.
> > >
> > > I believe that macro is used on other platforms to provide a little
> > > bit of abstraction when defin ing the clocks of rcar_sound,
> > > therefore it's ok for the other boards.
> >
> > May be I am missing something here. Can you please clarify the use
> > case of Other boards?
>
> For example:
> * r8a7796-salvator-xs.dts includes r8a7796.dtsi and salvator-xs.dtsi which in
>    turn includes salvator-common.dtsi. CPG_AUDIO_CLK_I is defined in
> r8a7796.dtsi
>    (with value R8A7796_CLK_S0D4, which translates to 11) and used in
> salvator-common.dtsi
> * r8a77965-salvator-xs.dts includes r8a77965.dtsi and salvator-xs.dtsi which in
>    turn includes salvator-common.dtsi. CPG_AUDIO_CLK_I is defined in
> r8a77965.dtsi
>    (with value 10) and used in salvator-common.dtsi
>
> That is just an example, salvator-common.dtsi is included from salvator-x.dtsi
> as well, and both salvator-xs.dtsi and salvator-x.dtsi are included by several
> board specific device trees.
>
> My understanding is that the DT architecture for the Salvator family of boards
> allows for maximum reuse of dtsi, macro CPG_AUDIO_CLK_I allows for SoC
> specific definitions while having only one common version of salvator-
> common.dtsi using the value.
>
> So, with the Salvator family of boards they had the need for this, I am not too
> sure we are going to need the same thing here. For the time being we have
> no use case for it (as we are going to upstream the DT for only one board
> once we know more about the HW design), that's why I think we shouldn't
> put this in. And maybe add it later on if the need arises. But as I said, it's just a
> macro and it's not going to hurt anybody...

Ok, Agreed will take away this macro and send v2.



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
