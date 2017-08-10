From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 10 Aug 2017 11:19:10 +0000
Subject: [PATCH  0/3] Add SMP support
References: <1502189793-59679-1-git-send-email-biju.das@bp.renesas.com>
 <20170809083554.GI2705@verge.net.au>
Message-ID: <KL1PR06MB1702C4E3CE94EFA111DE530BB8880@KL1PR06MB1702.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Biju Das
> Sent: 10 August 2017 10:17
> To: 'Simon Horman' <horms@verge.net.au>
> Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland
> <mark.rutland@arm.com>; Magnus Damm <magnus.damm@gmail.com>;
> Russell King <linux@armlinux.org.uk>; Chris Paterson
> <Chris.Paterson2@renesas.com>; devicetree at vger.kernel.org; linux-renesas-
> soc at vger.kernel.org; linux-arm-kernel at lists.infradead.org
> Subject: RE: [PATCH 0/3] Add SMP support
>
>
> > -----Original Message-----
> > From: Simon Horman [mailto:horms at verge.net.au]
> > Sent: 09 August 2017 09:36
> > To: Biju Das <biju.das@bp.renesas.com>
> > Cc: Rob Herring <robh+dt@kernel.org>; Mark Rutland
> > <mark.rutland@arm.com>; Magnus Damm <magnus.damm@gmail.com>;
> Russell
> > King <linux@armlinux.org.uk>; Chris Paterson
> > <Chris.Paterson2@renesas.com>; devicetree at vger.kernel.org;
> > linux-renesas- soc at vger.kernel.org;
> > linux-arm-kernel at lists.infradead.org
> > Subject: Re: [PATCH 0/3] Add SMP support
> >
> > On Tue, Aug 08, 2017 at 11:56:30AM +0100, Biju Das wrote:
> > > This series aims to add SMP support for r8a7743 SoC.
> > >
> > > This series has been tested against Linux-next tag 20170727 and
> > > renesas-dev branch.
> >
> > It seems that these patches are targeted at the renesas tree.
> > The best practice in that case is to base patches on the latest devel branch.
> > Please consider doing so in future.
> >
> > The patches themselves seem good to me, however, I would like to
> > enquire about testing. In particular, have you tested CPU hotplug and
> > suspend to RAM with these patches (and without in the case of the latter)?
>
> I have tested CPU hotplug with this patch and it works ok.
>
> Currently iWave platform doesn't support STR I guess. But we should check the
> changes on other M2 platforms to prove that things don't break.

I have tested STR on RZ-G1M SK(r8a7743) platform using gpio-key as wake up source.
It works fine with and without the patch . It is tested against renesas-developer branch.

Also I have tested STR on R-Car M2 board.it works fine with gpio-key as wake up source.

> [>]
> > I am cautious about any regressions that may creep in when going from
> > UP to SMP.
>
> > >
> > > Biju Das (3):
> > >   dt-bindings: apmu: Document r8a7743 support
> > >   ARM: dts: r8a7743: Add APMU node and second CPU core
> > >   ARM: dts: r8a7743: Add OPP table for frequency scaling
> > >
> > >  .../devicetree/bindings/power/renesas,apmu.txt     |  3 ++-
> > >  arch/arm/boot/dts/r8a7743.dtsi                     | 25
> ++++++++++++++++++++++
> > >  2 files changed, 27 insertions(+), 1 deletion(-)
> > >
> > > --
> > > 1.9.1
> > >



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
