From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 23 Oct 2017 11:04:28 +0000
Subject: [PATCH 2/4] ARM: dts: iwg22d: Add /dev/ttySC5 support
In-Reply-To: <20171017075747.hftrfirrzu3ihesp@verge.net.au>
References: <1507899796-7941-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1507899796-7941-3-git-send-email-fabrizio.castro@bp.renesas.com>
 <20171017075747.hftrfirrzu3ihesp@verge.net.au>
Message-ID: <TY1PR06MB0895C595BCA5DA90999959D5C0460@TY1PR06MB0895.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Simon,

>
> Please include some text in the changelog, ideally describing the
> motivation (why not what) for this patch.

Sure, I'll a description for v2. Thank you for the feedback.

Thanks,
Fab

>
>
> On Fri, Oct 13, 2017 at 02:03:14PM +0100, Fabrizio Castro wrote:
> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> > ---
> >  arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
> > index edda4f1..5d5bb2f 100644
> > --- a/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
> > +++ b/arch/arm/boot/dts/r8a7745-iwg22d-sodimm.dts
> > @@ -17,6 +17,7 @@
> >
> >  aliases {
> >  serial3 = &scif4;
> > +serial5 = &hscif1;
> >  ethernet0 = &avb;
> >  };
> >
> > @@ -39,7 +40,20 @@
> >  };
> >  };
> >
> > +&hscif1 {
> > +pinctrl-0 = <&hscif1_pins>;
> > +pinctrl-names = "default";
> > +
> > +uart-has-rtscts;
> > +status = "okay";
> > +};
> > +
> >  &pfc {
> > +hscif1_pins: hscif1 {
> > +groups = "hscif1_data", "hscif1_ctrl";
> > +function = "hscif1";
> > +};
> > +
> >  scif4_pins: scif4 {
> >  groups = "scif4_data_b";
> >  function = "scif4";
> > --
> > 2.7.4
> >



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
