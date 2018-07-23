From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 23 Jul 2018 11:03:28 +0200
Subject: [PATCH 1/9] ARM: dts: porter: Add missing PMIC nodes
In-Reply-To: <1f7c894a-9ad6-2e4e-c144-de982c2ba4c8@gmail.com>
References: <cover.1532086734.git.horms+renesas@verge.net.au>
 <5058a96cb7e8dca97629c48084537fe5def8344f.1532086734.git.horms+renesas@verge.net.au>
 <8312c88f-9ff8-454e-fad9-7bf403c28207@cogentembedded.com>
 <1f7c894a-9ad6-2e4e-c144-de982c2ba4c8@gmail.com>
Message-ID: <CAMuHMdVVGBtBrZ=0356+ZXDeGwiW=Ayvhy3_+AOE-6P3Q8zR6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Sun, Jul 22, 2018 at 2:07 PM Marek Vasut <marek.vasut@gmail.com> wrote:
> On 07/20/2018 06:38 PM, Sergei Shtylyov wrote:
> > On 07/20/2018 03:05 PM, Simon Horman wrote:
> >> From: Marek Vasut <marek.vasut@gmail.com>
> >>
> >> Add PMIC nodes to Porter and connect CPU DVFS supply. There is
> >> one DA9063L and one DA9210 on Porter, the only difference from
> >> the other boards is that DA9063L is at I2C address 0x5a rather
> >> than 0x58 .
> >>
> >> Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
> >> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >> ---
> >>  arch/arm/boot/dts/r8a7791-porter.dts | 33 +++++++++++++++++++++++++++++++++
> >>  1 file changed, 33 insertions(+)
> >>
> >> diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
> >> index a01101b49d99..5f77d73d7462 100644
> >> --- a/arch/arm/boot/dts/r8a7791-porter.dts
> >> +++ b/arch/arm/boot/dts/r8a7791-porter.dts
> >> @@ -375,10 +375,43 @@
> >>      clock-frequency = <400000>;
> >>  };
> >>
> >> +&i2c6 {
> >> +    status = "okay";
> >> +    clock-frequency = <100000>;
> >> +
> >> +    pmic at 5a {
> >> +            compatible = "dlg,da9063l";
> >> +            reg = <0x5a>;
> >> +            interrupt-parent = <&irqc0>;
> >> +            interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
> >> +            interrupt-controller;
> >
> >    Without a label and #interrupt-cells?
>
> Just like the other boards do. What's the problem here ?

Does it support external interrupt inputs? Or only the internal
interrupt sources?
If the former, it needs at  least #interrupt-cells (also in the DT bindings).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
