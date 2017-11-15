From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 15 Nov 2017 15:41:14 +0100
Subject: [PATCH v2 1/7] arm64: dts: renesas: r8a7796: Add IPMMU device
 nodes
In-Reply-To: <20171110132612.1589-2-horms+renesas@verge.net.au>
References: <20171110132612.1589-1-horms+renesas@verge.net.au>
 <20171110132612.1589-2-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdW-fpLiMk-cJBaFgR0WVLa0LLO4Nj_nm9mtyU93=T5h=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, Nov 10, 2017 at 2:26 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Add r8a7796 IPMMU nodes and keep all disabled by default.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> v2 [Simon Horman]
> * Drop mostly redundant comments from nodes
> * Add power domains

Thanks for the update!

With the below fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi

[...]

> +               ipmmu_vc0: mmu at fe6b0000 {
> +                       compatible = "renesas,ipmmu-r8a7796";
> +                       reg = <0 0xfe6b0000 0 0x1000>;
> +                       renesas,ipmmu-main = <&ipmmu_mm 8>;
> +                       power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;

R8A7796_PD_A3VC

> +                       #iommu-cells = <1>;
> +                       status = "disabled";
> +               };

[...]

> +               ipmmu_ds0: mmu at e6740000 {
> +                       compatible = "renesas,ipmmu-r8a7796";
> +                       reg = <0 0xe6740000 0 0x1000>;
> +                       renesas,ipmmu-main = <&ipmmu_mm 0>;

power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;

> +                       #iommu-cells = <1>;
> +                       status = "disabled";
> +               };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
