From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 7 Jul 2014 15:32:33 +0800
Subject: [PATCH v2 8/8] ARM: sun7i: enable DMA on SPI
In-Reply-To: <1404619518-7592-9-git-send-email-emilio@elopez.com.ar>
References: <1404619518-7592-1-git-send-email-emilio@elopez.com.ar>
 <1404619518-7592-9-git-send-email-emilio@elopez.com.ar>
Message-ID: <CAGb2v67vub+Bf9zkUUGB=Kqi5dm7DeGay8HsMbdsx4ZmcfcgPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jul 6, 2014 at 12:05 PM, Emilio L?pez <emilio@elopez.com.ar> wrote:
> All of our SPI controllers support DMA transfers, so let's add the
> properties here so they can be used when it's best to do so.
>
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>

Numbers are good.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>


> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 8cd3534..804dc01 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -437,6 +437,8 @@
>                         interrupts = <0 10 4>;
>                         clocks = <&ahb_gates 20>, <&spi0_clk>;
>                         clock-names = "ahb", "mod";
> +                       dmas = <&dma 1 27>, <&dma 1 26>;
> +                       dma-names = "rx", "tx";
>                         status = "disabled";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> @@ -448,6 +450,8 @@
>                         interrupts = <0 11 4>;
>                         clocks = <&ahb_gates 21>, <&spi1_clk>;
>                         clock-names = "ahb", "mod";
> +                       dmas = <&dma 1 9>, <&dma 1 8>;
> +                       dma-names = "rx", "tx";
>                         status = "disabled";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> @@ -543,6 +547,8 @@
>                         interrupts = <0 12 4>;
>                         clocks = <&ahb_gates 22>, <&spi2_clk>;
>                         clock-names = "ahb", "mod";
> +                       dmas = <&dma 1 29>, <&dma 1 28>;
> +                       dma-names = "rx", "tx";
>                         status = "disabled";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> @@ -582,6 +588,8 @@
>                         interrupts = <0 50 4>;
>                         clocks = <&ahb_gates 23>, <&spi3_clk>;
>                         clock-names = "ahb", "mod";
> +                       dmas = <&dma 1 31>, <&dma 1 30>;
> +                       dma-names = "rx", "tx";
>                         status = "disabled";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> --
> 2.0.1
