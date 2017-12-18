From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Mon, 18 Dec 2017 15:41:56 +0000
Subject: [PATCH 2/3] ARM: dts: r8a7743: Add CMT SoC specific support
In-Reply-To: <20171218111819.nsu4dd6wacdud3lc@verge.net.au>
References: <1513104579-6333-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1513104579-6333-3-git-send-email-fabrizio.castro@bp.renesas.com>
 <20171213083829.ptdeggbon3szmko4@verge.net.au>
 <TY1PR06MB0895B34EFC2A48F49AFF0694C0350@TY1PR06MB0895.apcprd06.prod.outlook.com>
 <CAMuHMdWEFttz_Shve+D1Ku2NoUYX-AomzXY9JFGRjzzM=hOc_A@mail.gmail.com>
 <TY1PR06MB08954C04D41BDA8EFA04E1DFC0350@TY1PR06MB0895.apcprd06.prod.outlook.com>
 <20171218111819.nsu4dd6wacdud3lc@verge.net.au>
Message-ID: <TY1PR06MB0895881A40AFCE3FA8F25BC1C00E0@TY1PR06MB0895.apcprd06.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Simon,

> > Hello Geert,
> >
> > thank you for your feedback.
> >
> > > Hi Fabrizio,
> > >
> > > On Wed, Dec 13, 2017 at 10:42 AM, Fabrizio Castro
> > > <fabrizio.castro@bp.renesas.com> wrote:
> > > >> On Tue, Dec 12, 2017 at 06:49:38PM +0000, Fabrizio Castro wrote:
> > > >> > Add CMT[01] support to SoC DT.
> > > >> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > > >> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> > > >> > ---
> > > >> >  arch/arm/boot/dts/r8a7743.dtsi | 30 ++++++++++++++++++++++++++++++
> > > >> >  1 file changed, 30 insertions(+)
> > > >>
> > > >> I was expecting the cmt nodes to be "disabled" in the SoC file
> > > >> and then enabled selectively in board files. Am I missing something?
> > > >
> > > > Since this component is just a compare and match timer, I  thought there was no harm in enabling it by default in the SoC specific
> DT.
> > > > The system will park it and leave its clock disabled until actually needed for something.
> > > > The user can still disable it in the board specific DT if he/she doesn't mean to even have the option to use it. Do you prefer I left it
> > > disabled by default?
> > >
> > > It's debatable (thus up to Simon the maintainer ;-).
> > > For I/O devices, we disable them in the SoC .dtsi file.
> > > For core infrastructure like interrupt, DMA, and GPIO controllers, we keep
> > > them enabled.
> > >
> > > Timers are core functionality, but who's actually using these timers?
> >
> > I don't have a use case in mind unfortunately, but it's still core
> > functionality and pretty harmless as far as I can tell. Let's see what
> > Simon thinks about this.
>
> On Renesas SoCs we have a bit more flexibility with timers than might
> be the case on other SoCs. Thus I'd like to keep with the scheme of
> disabling them in .dtsi and enabling them when they are needed.
>
> Please update the patches.

Ok, I'll send a v2.

Thanks,
Fab



[https://www2.renesas.eu/media/email/unicef_2017.jpg]

This Christmas, instead of sending out cards, Renesas Electronics Europe have decided to support Unicef with a donation. For further details click here<https://www.unicef.org/> to find out about the valuable work they do, helping children all over the world.
We would like to take this opportunity to wish you a Merry Christmas and a prosperous New Year.



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
