From: horms@verge.net.au (Simon Horman)
Date: Tue, 17 Oct 2017 10:04:42 +0200
Subject: [PATCH v2 1/3] dt-bindings: mmc: renesas_sdhi: provide example
 in bindings documentation
In-Reply-To: <CAMuHMdUSan7j5wf=cYwO-RdcY7KiJSAPuh7nPq4YQMc_4_sfcA@mail.gmail.com>
References: <20171016075822.18177-1-horms+renesas@verge.net.au>
 <20171016075822.18177-2-horms+renesas@verge.net.au>
 <CAMuHMdUSan7j5wf=cYwO-RdcY7KiJSAPuh7nPq4YQMc_4_sfcA@mail.gmail.com>
Message-ID: <20171017080441.6wbznyz5xlroecyk@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 16, 2017 at 11:13:32AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Mon, Oct 16, 2017 at 9:58 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Provide an example of the usage of the DT bindings for TMIO
> > in their documentation. The example given is for the r8a7790 (R-Car H2).
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > v2
> > * Correct description of example, it is for the r8a7790 (R-Car H2)
> >   rather than the r8a7779 (R-Car H1)
> 
> Thanks for the update!
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> > --- a/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> > +++ b/Documentation/devicetree/bindings/mmc/tmio_mmc.txt
> > @@ -43,3 +43,57 @@ Optional properties:
> >  - pinctrl-names: should be "default", "state_uhs"
> >  - pinctrl-0: should contain default/high speed pin ctrl
> >  - pinctrl-1: should contain uhs mode pin ctrl
> > +
> > +Example: R8A7790 (R-Car H2) SDHI controller nodes
> > +
> > +       sdhi0: sd at ee100000 {
> > +               compatible = "renesas,sdhi-r8a7790";
> > +               reg = <0 0xee100000 0 0x328>;
> > +               interrupts = <GIC_SPI 165 IRQ_TYPE_LEVEL_HIGH>;
> > +               clocks = <&mstp3_clks R8A7790_CLK_SDHI0>;
> 
> You may want to copy the example from the current r8a7790.dtsi, which
> uses the newer CPG/MSSR bindings.

Thanks, v3 sent.
