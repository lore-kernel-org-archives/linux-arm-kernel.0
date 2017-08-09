From: horms@verge.net.au (Simon Horman)
Date: Wed, 9 Aug 2017 09:55:57 +0200
Subject: [PATCH 3/3] arm64: dts: r8a7795: Use R-Car GPIO Gen3 fallback
 compat string
In-Reply-To: <CANqRtoTBt34QOoubpYPS65-8qVJ8c2X=u+bmMACXGr3nyTEpkA@mail.gmail.com>
References: <1502182499-16210-1-git-send-email-horms+renesas@verge.net.au>
 <1502182499-16210-4-git-send-email-horms+renesas@verge.net.au>
 <CANqRtoTBt34QOoubpYPS65-8qVJ8c2X=u+bmMACXGr3nyTEpkA@mail.gmail.com>
Message-ID: <20170809075557.GF2705@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 08, 2017 at 07:24:58PM +0900, Magnus Damm wrote:
> Hi Simon,
> 
> On Tue, Aug 8, 2017 at 5:54 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> > Use newly added R-Car GPIO Gen3 fallback compat string
> > in the DT of the r8a7795 SoC.
> >
> > This should have no run-time effect as the driver matches against
> > the per-SoC compat string before the fallback compat string is considered.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> >  arch/arm64/boot/dts/renesas/r8a7795.dtsi | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > index a87ae76880ab..c9f2b87e7ee3 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> > @@ -1451,7 +1451,8 @@
> >                 };
> >
> >                 sata: sata at ee300000 {
> > -                       compatible = "renesas,sata-r8a7795";
> > +                       compatible = "renesas,sata-r8a7795",
> > +                                    "renesas,rcar-gen3-sata";
> >                         reg = <0 0xee300000 0 0x200000>;
> >                         interrupts = <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
> >                         clocks = <&cpg CPG_MOD 815>;
> > --
> > 2.1.4
> 
> This patch looks odd. The subject and patch description says GPIO but
> the hunk above modifies SATA...?

Yes, it looks like I have made a cut-and-paste error there.
I'll repost.
