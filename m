From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 24 Aug 2017 14:32:47 +0000
Subject: [PATCH ] ARM: dts: iwg20d-q7: Add chosen node
In-Reply-To: <20170822080735.GH30838@verge.net.au>
References: <1503075488-44304-1-git-send-email-biju.das@bp.renesas.com>
 <20170822080735.GH30838@verge.net.au>
Message-ID: <SG2PR06MB1711E12964D1C1300C4EEB64B89A0@SG2PR06MB1711.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Simon Horman [mailto:horms at verge.net.au]
> Sent: 22 August 2017 09:08
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Magnus Damm <magnus.damm@gmail.com>;
> Russell King <linux@armlinux.org.uk>; Chris Paterson
> <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>; devicetree at vger.kernel.org; linux-renesas-
> soc at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH ] ARM: dts: iwg20d-q7: Add chosen node
>
> On Fri, Aug 18, 2017 at 05:58:08PM +0100, Biju Das wrote:
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > ---
> > This patch tested against renesas-dev tag
> > renesas-devel-20170815-v4.13-rc5
>
> Thanks, I have applied this for v4.15.
>
> There was some fuzz when applying this patch.
> Please check that it is correct when I have pushed today's devel tag to the
> renesas tree.

Looks like this node is misplaced. I will repost this patch.

> >
> >  arch/arm/boot/dts/r8a7743-iwg20d-q7.dts | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
> > b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
> > index 081af01..305a6a1 100644
> > --- a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
> > +++ b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
> > @@ -19,6 +19,11 @@
> >  serial0 = &scif0;
> >  ethernet0 = &avb;
> >  };
> > +
> > +chosen {
> > +bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
> > +stdout-path = "serial0:115200n8";
> > +};
> >  };
> >
> >  &pfc {
> > --
> > 1.9.1
> >



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
