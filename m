From: horms@verge.net.au (Simon Horman)
Date: Mon, 10 Jul 2017 10:23:51 +0200
Subject: [PATCH v 1/2] ARM: dts: r8a7743: Add Ethernet AVB support
In-Reply-To: <CAMuHMdWsM_FBJ46=U69XptqpyC2cJYx_cqczaHBNq2nxZr68GQ@mail.gmail.com>
References: <1499433165-62475-1-git-send-email-biju.das@bp.renesas.com>
 <1499433165-62475-2-git-send-email-biju.das@bp.renesas.com>
 <CAMuHMdWsM_FBJ46=U69XptqpyC2cJYx_cqczaHBNq2nxZr68GQ@mail.gmail.com>
Message-ID: <20170710082350.GB13680@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 10, 2017 at 09:54:40AM +0200, Geert Uytterhoeven wrote:
> Hi Biju,
> 
> On Fri, Jul 7, 2017 at 3:12 PM, Biju Das <biju.das@bp.renesas.com> wrote:
> > Add Ethernet AVB support for r8a7743 SoC.
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Reviewed-by: Chris Paterson <chris.paterson2@renesas.com>
> 
> With the minor nit below fixed:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > --- a/arch/arm/boot/dts/r8a7743.dtsi
> > +++ b/arch/arm/boot/dts/r8a7743.dtsi
> > @@ -605,6 +605,19 @@
> >                         #size-cells = <0>;
> >                         status = "disabled";
> >                 };
> > +
> > +               avb: ethernet at e6800000 {
> > +                       compatible = "renesas,etheravb-r8a7743",

I do not see a patch to add "renesas,etheravb-r8a7743" to
Documentation/devicetree/bindings/net/renesas,ravb.txt

If you haven't already done so please post a patch to add this
once net-next re-opens.

> > +                                    "renesas,etheravb-rcar-gen2";
> > +                       reg = <0 0xe6800000 0 0x800>, <0 0xee0e8000 0 0x4000>;
> > +                       interrupts = <0 163 IRQ_TYPE_LEVEL_HIGH>;
> 
> s/0/GIC_SPI/

Thanks, I have applied this patch with the minor update above.
