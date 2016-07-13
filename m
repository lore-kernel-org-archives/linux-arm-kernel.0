From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 13 Jul 2016 03:37:00 +0200
Subject: [PATCH 2/2] ARM: dts: r8a7792: add SDHI support
In-Reply-To: <8030361.FnpbGzHVP8@wasted.cogentembedded.com>
References: <2441635.ESeLhIjWEX@wasted.cogentembedded.com>
 <8030361.FnpbGzHVP8@wasted.cogentembedded.com>
Message-ID: <CAMuHMdWxsjodScdgWxLBe4yq1k140FGk1gcG4aNS783XoyYyDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 12, 2016 at 11:11 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> Define the generic R8A7792 part of the SDHI0 device node.
>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>  arch/arm/boot/dts/r8a7792.dtsi |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> Index: renesas/arch/arm/boot/dts/r8a7792.dtsi
> ===================================================================
> --- renesas.orig/arch/arm/boot/dts/r8a7792.dtsi
> +++ renesas/arch/arm/boot/dts/r8a7792.dtsi
> @@ -435,6 +435,18 @@
>                         status = "disabled";
>                 };
>
> +               sdhi0: sd at ee100000 {
> +                       compatible = "renesas,sdhi-r8a7792";
> +                       reg = <0 0xee100000 0 0x200>;
> +                       interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
> +                       dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
> +                              <&dmac1 0xcd>, <&dmac1 0xce>;
> +                       dma-names = "tx", "rx", "tx", "rx";
> +                       clocks = <&mstp3_clks R8A7792_CLK_SDHI0>;
> +                       power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;

Do we want a "max-frequency" property here?
Note that this instance doesn't support SDR104/SDR50.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
