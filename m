From: horms@verge.net.au (Simon Horman)
Date: Tue, 10 Oct 2017 09:25:46 +0200
Subject: [PATCH v2 2/2] arm64: dts: r8a7796: Add OPPs table for cpu devices
In-Reply-To: <CAMuHMdWnpx4UUSgWv5oPyqPBb2EHtGH8BpZ_zxtv+BdWwgmNaw@mail.gmail.com>
References: <1507209984-17123-1-git-send-email-horms+renesas@verge.net.au>
 <1507209984-17123-3-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdWnpx4UUSgWv5oPyqPBb2EHtGH8BpZ_zxtv+BdWwgmNaw@mail.gmail.com>
Message-ID: <20171010072545.GJ2518@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 09, 2017 at 01:56:17PM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Thu, Oct 5, 2017 at 3:26 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> > From: Dien Pham <dien.pham.ry@rvc.renesas.com>
> >
> > Current, OPP tables are defined temporary,
> > they are being evaluated and adjust in future.
> >
> > Based in part on work by Hien Dang.
> 
> > --- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> 
> > @@ -108,6 +116,56 @@
> >                 };
> >         };
> >
> > +       cluster0_opp: opp_table0 {
> > +               compatible = "operating-points-v2";
> > +               opp-shared;
> > +
> > +               opp at 500000000 {
> 
> As reported before, with "make dtbs W=1":
> 
> arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb: Warning
> (unit_address_vs_reg): Node /opp_table0/opp at 500000000 has a unit name,
> but no reg property
> 
> etc.
> 
> opp-500000000

Thanks, will fix.
