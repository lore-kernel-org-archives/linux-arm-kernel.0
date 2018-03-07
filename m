From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 7 Mar 2018 10:49:47 +0100
Subject: [PATCH 2/3] arm64: dts: renesas: r8a7795: sort subnodes of the
 cpu node
In-Reply-To: <20180307094046.4907-3-horms+renesas@verge.net.au>
References: <20180307094046.4907-1-horms+renesas@verge.net.au>
 <20180307094046.4907-3-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdUnpvF0TXW9FaoYTe-dTQ9prDNmHa6OkbZbww-m7wav_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Wed, Mar 7, 2018 at 10:40 AM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> Sort subnodes of the cpu node alphanumerically.
>
> This is part of an ongoing effort to provide consistent node
> order in the DT of Renesas SoCs to improve maintainability.
>
> This should not have any run-time effect.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Thanks for your patch!

> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> @@ -34,6 +34,50 @@
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
> +               a53_0: cpu at 100 {
> +                       compatible = "arm,cortex-a53", "arm,armv8";
> +                       reg = <0x100>;
> +                       device_type = "cpu";
> +                       power-domains = <&sysc R8A7795_PD_CA53_CPU0>;
> +                       next-level-cache = <&L2_CA53>;
> +                       enable-method = "psci";
> +                       clocks =<&cpg CPG_CORE R8A7795_CLK_Z2>;
> +                       operating-points-v2 = <&cluster1_opp>;
> +               };

[...]

>                 a57_0: cpu at 0 {
>                         compatible = "arm,cortex-a57", "arm,armv8";
>                         reg = <0x0>;

Given the CPU nodes do have reg properties and unit addresses, shouldn't
they be sorted by these values, instead of alphabetically?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
