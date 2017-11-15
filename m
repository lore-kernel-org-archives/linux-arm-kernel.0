From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 15 Nov 2017 15:29:55 +0100
Subject: [PATCH v5 01/15] arm64: dts: renesas: r8a7795: Add IPMMU device
 nodes
In-Reply-To: <20171110132532.1202-2-horms+renesas@verge.net.au>
References: <20171110132532.1202-1-horms+renesas@verge.net.au>
 <20171110132532.1202-2-horms+renesas@verge.net.au>
Message-ID: <CAMuHMdVXJduKrdb0+ujJX7O7_1omvfaWjCjTHwTafFD1sr=q=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Fri, Nov 10, 2017 at 2:25 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Add r8a7795 IPMMU nodes and keep all disabled by default.
>
> This includes all IPMMU devices for r8a7795 ES2.0. Those
> not present in r8a7795 ES1.x are removed from the DT for those
> SoCs using delete-node. A follow-up patch will add IPMMU devices
> to ES1.x which are not also present in ES2.0.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
> v5 [Simon Horman]
> * Correct ES1.x override for ipmmu_vc0
> * Add ES1.x override for ipmmu_vc1
> * Drop mostly redundant comments from nodes
> * Add power domains
> * Consistently mark all nodes as disabled

Thanks for the update!

Looks like "power-domains" do work for IOMMU nodes.
However, adding them seems to postpone initialization of the IOMMUs.

With the two typos below fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi

> +               ipmmu_vc0: mmu at fe6b0000 {
> +                       compatible = "renesas,ipmmu-r8a7795";
> +                       reg = <0 0xfe6b0000 0 0x1000>;
> +                       renesas,ipmmu-main = <&ipmmu_mm 12>;
> +                       power-domains = <&sysc R8A7795_PD_A3VP>;

R8A7795_PD_A3VC

> +                       #iommu-cells = <1>;
> +                       status = "disabled";
> +               };
> +
> +               ipmmu_vc1: mmu at fe6f0000 {
> +                       compatible = "renesas,ipmmu-r8a7795";
> +                       reg = <0 0xfe6f0000 0 0x1000>;
> +                       renesas,ipmmu-main = <&ipmmu_mm 13>;
> +                       power-domains = <&sysc R8A7795_PD_A3VP>;

R8A7795_PD_A3VC

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
