From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Thu, 27 Sep 2018 10:53:41 +0000
Subject: [PATCH v2 3/3] arm64: dts: renesas: r8a774a1: Add CAN nodes
In-Reply-To: <20180911133220.3kjx5dqp65drx3qs@verge.net.au>
References: <1536576195-11520-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1536576195-11520-4-git-send-email-fabrizio.castro@bp.renesas.com>
 <20180911133220.3kjx5dqp65drx3qs@verge.net.au>
Message-ID: <TY1PR01MB1770B42824076BF5C57F12DDC0140@TY1PR01MB1770.jpnprd01.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Simon,

> Subject: Re: [PATCH v2 3/3] arm64: dts: renesas: r8a774a1: Add CAN nodes
>
> On Mon, Sep 10, 2018 at 11:43:15AM +0100, Fabrizio Castro wrote:
> > From: Chris Paterson <chris.paterson2@renesas.com>
> >
> > Add the device nodes for both RZ/G2M CAN channels.
> >
> > Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
> > Reviewed-by: Biju Das <biju.das@bp.renesas.com>
> > ---
> >
> > v1->v2:
> > * replaced "renesas,rzg-gen2-can" with "renesas,rcar-gen3-can" as per
> >   Geert's comment.
> >
> > This patch applies on top of renesas-devel-20180906-v4.19-rc2.
>
> Thanks Fabrizio,
>
> I would like to waif for the bindings to be accepted before accepting this
> patch.

Marc has taken the bindings, I guess we can unblock this patch now?

Thanks,
Fab

>
> >
> >  arch/arm64/boot/dts/renesas/r8a774a1.dtsi | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> > index 046fc93..867e875 100644
> > --- a/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a774a1.dtsi
> > @@ -874,6 +874,30 @@
> >  status = "disabled";
> >  };
> >
> > +can0: can at e6c30000 {
> > +compatible = "renesas,can-r8a774a1",
> > +     "renesas,rcar-gen3-can";
> > +reg = <0 0xe6c30000 0 0x1000>;
> > +interrupts = <GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
> > +clocks = <&cpg CPG_MOD 916>, <&can_clk>;
> > +clock-names = "clkp1", "can_clk";
> > +power-domains = <&sysc 32>;
> > +resets = <&cpg 916>;
> > +status = "disabled";
> > +};
> > +
> > +can1: can at e6c38000 {
> > +compatible = "renesas,can-r8a774a1",
> > +     "renesas,rcar-gen3-can";
> > +reg = <0 0xe6c38000 0 0x1000>;
> > +interrupts = <GIC_SPI 187 IRQ_TYPE_LEVEL_HIGH>;
> > +clocks = <&cpg CPG_MOD 915>, <&can_clk>;
> > +clock-names = "clkp1", "can_clk";
> > +power-domains = <&sysc 32>;
> > +resets = <&cpg 915>;
> > +status = "disabled";
> > +};
> > +
> >  pwm0: pwm at e6e30000 {
> >  compatible = "renesas,pwm-r8a774a1", "renesas,pwm-rcar";
> >  reg = <0 0xe6e30000 0 0x8>;
> > --
> > 2.7.4
> >



Renesas Electronics Europe Ltd, Dukes Meadow, Millboard Road, Bourne End, Buckinghamshire, SL8 5FH, UK. Registered in England & Wales under Registered No. 04586709.
