From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 19 Sep 2016 10:14:20 +0200
Subject: [PATCH RFC 5/8] ARM: dts: r8a7743: initial SoC device tree
In-Reply-To: <1679762.ECpvSkQAyM@wasted.cogentembedded.com>
References: <3533019.Wim1Kuh1ic@wasted.cogentembedded.com>
 <1679762.ECpvSkQAyM@wasted.cogentembedded.com>
Message-ID: <CAMuHMdUrPvboqZwNWahGbp3xV3YtzESpiBqYzh5Xtuw5kKQ=4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Fri, Sep 16, 2016 at 3:35 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> The initial R8A7743 SoC device tree including CPU cores, GIC, timer, SYSC,
> and the required  clock descriptions.
>
> Based on the original (and large) patch by Dmitry Shifrin
> <dmitry.shifrin@cogentembedded.com>.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

> --- /dev/null/
> +++ renesas/arch/arm/boot/dts/r8a7743.dtsi
> @@ -0,0 +1,210 @@

> +/ {

> +       soc {
=
> +               /* Special CPG clocks */
> +               cpg_clocks: cpg_clocks at e6150000 {
> +                       compatible = "renesas,r8a7743-cpg-clocks",
> +                                    "renesas,rcar-gen2-cpg-clocks";

For a new SoC family, I would strongly suggest using a renesas,cpg-mssr
based binding instead:
  - No more mstp*_clocks nodes with array triplets to keep in sync,
  - Support for MSSR reset can be added later,
  - No need to add all those fixed-factor clocks to DT,
  - Less DT churn when adding support for new devices.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
