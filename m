From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 11 May 2016 15:45:17 +0200
Subject: [PATCHv3 1/4] ARM: dts: r8a7790: Reference both DMA controllers
In-Reply-To: <1462972438-20797-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
References: <1462972438-20797-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
 <1462972438-20797-2-git-send-email-niklas.soderlund+renesas@ragnatech.se>
Message-ID: <CAMuHMdWoPThi0w6siA5LJ60oEH6JMv4x80b_Spg5aF-uHq3WqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Niklas,

On Wed, May 11, 2016 at 3:13 PM, Niklas S?derlund
<niklas.soderlund+renesas@ragnatech.se> wrote:
> R-Car Gen2 have two DMA controllers, which are equivalent. Add
> references to both dmac0 and dmac1 so the driver can choose which one to
> use.
>
> Signed-off-by: Niklas S?derlund <niklas.soderlund+renesas@ragnatech.se>
> ---
>  arch/arm/boot/dts/r8a7790.dtsi | 131 ++++++++++++++++++++++++-----------------
>  1 file changed, 78 insertions(+), 53 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index 83cf23c..14fcd19 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi

> @@ -755,9 +773,9 @@
>                 clocks = <&mstp3_clks R8A7790_CLK_SCIF2>, <&zs_clk>,
>                          <&scif_clk>;
>                 clock-names = "fck", "brg_int", "scif_clk";
> -               dmas = <&dmac0 0x2b>, <&dmac0 0x2c>;
> -               dma-names = "tx", "rx";
> -               power-domains = <&sysc R8A7790_PD_ALWAYS_ON>;

Please keep the above line.

> +               dmas = <&dmac0 0x2b>, <&dmac0 0x2c>,
> +                      <&dmac1 0x2b>, <&dmac1 0x2c>;
> +               dma-names = "tx", "rx", "tx", "rx";
>                 status = "disabled";
>         };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
