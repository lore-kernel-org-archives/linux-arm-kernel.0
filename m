From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 22 May 2018 13:48:06 +0200
Subject: [PATCH 1/2] arm64: dts: renesas: r8a77980: add GEther support
In-Reply-To: <8910c197-cf1b-9ee9-9ddb-5d2f705a4b26@cogentembedded.com>
References: <a4230699-e46f-0782-e3b1-22d58b9033c8@cogentembedded.com>
 <8910c197-cf1b-9ee9-9ddb-5d2f705a4b26@cogentembedded.com>
Message-ID: <CAMuHMdW9UzOGV_zh3NxugYrj0j0qszX+NFoZtFvZRD9CNMHt+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Fri, May 18, 2018 at 9:45 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Define the generic R8A77980 part of the GEther device node.
>
> Based on the original (and large) patch by Vladimir Barinov.
>
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Thanks for your patch!

With the below addressed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> +++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> @@ -417,6 +417,17 @@
>                         dma-channels = <16>;
>                 };
>
> +               gether: ethernet at e7400000 {
> +                       compatible = "renesas,gether-r8a77980";
> +                       reg = <0 0xe7400000 0 0x1000>;
> +                       interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
> +                       clocks = <&cpg CPG_MOD 813>;
> +                       power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;

resets = <&cpg 813>;

> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +                       status = "disabled";

Any default phy-mode needed?

> +               };
> +
>                 mmc0: mmc at ee140000 {
>                         compatible = "renesas,sdhi-r8a77980",
>                                      "renesas,rcar-gen3-sdhi";


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
