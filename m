From: horms@verge.net.au (Simon Horman)
Date: Mon, 18 Dec 2017 12:18:20 +0100
Subject: [PATCH 2/3] ARM: dts: r8a7743: Add CMT SoC specific support
In-Reply-To: <TY1PR06MB08954C04D41BDA8EFA04E1DFC0350@TY1PR06MB0895.apcprd06.prod.outlook.com>
References: <1513104579-6333-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1513104579-6333-3-git-send-email-fabrizio.castro@bp.renesas.com>
 <20171213083829.ptdeggbon3szmko4@verge.net.au>
 <TY1PR06MB0895B34EFC2A48F49AFF0694C0350@TY1PR06MB0895.apcprd06.prod.outlook.com>
 <CAMuHMdWEFttz_Shve+D1Ku2NoUYX-AomzXY9JFGRjzzM=hOc_A@mail.gmail.com>
 <TY1PR06MB08954C04D41BDA8EFA04E1DFC0350@TY1PR06MB0895.apcprd06.prod.outlook.com>
Message-ID: <20171218111819.nsu4dd6wacdud3lc@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 13, 2017 at 10:15:39AM +0000, Fabrizio Castro wrote:
> Hello Geert,
> 
> thank you for your feedback.
> 
> > Hi Fabrizio,
> >
> > On Wed, Dec 13, 2017 at 10:42 AM, Fabrizio Castro
> > <fabrizio.castro@bp.renesas.com> wrote:
> > >> On Tue, Dec 12, 2017 at 06:49:38PM +0000, Fabrizio Castro wrote:
> > >> > Add CMT[01] support to SoC DT.
> > >> > Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > >> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> > >> > ---
> > >> >  arch/arm/boot/dts/r8a7743.dtsi | 30 ++++++++++++++++++++++++++++++
> > >> >  1 file changed, 30 insertions(+)
> > >>
> > >> I was expecting the cmt nodes to be "disabled" in the SoC file
> > >> and then enabled selectively in board files. Am I missing something?
> > >
> > > Since this component is just a compare and match timer, I  thought there was no harm in enabling it by default in the SoC specific DT.
> > > The system will park it and leave its clock disabled until actually needed for something.
> > > The user can still disable it in the board specific DT if he/she doesn't mean to even have the option to use it. Do you prefer I left it
> > disabled by default?
> >
> > It's debatable (thus up to Simon the maintainer ;-).
> > For I/O devices, we disable them in the SoC .dtsi file.
> > For core infrastructure like interrupt, DMA, and GPIO controllers, we keep
> > them enabled.
> >
> > Timers are core functionality, but who's actually using these timers?
> 
> I don't have a use case in mind unfortunately, but it's still core
> functionality and pretty harmless as far as I can tell. Let's see what
> Simon thinks about this.

On Renesas SoCs we have a bit more flexibility with timers than might
be the case on other SoCs. Thus I'd like to keep with the scheme of
disabling them in .dtsi and enabling them when they are needed.

Please update the patches.
