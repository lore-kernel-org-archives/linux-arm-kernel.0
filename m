From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 7 Jul 2014 15:33:57 +0800
Subject: [PATCH v2 6/8] ARM: sun4i: enable DMA on SPI
In-Reply-To: <1404619518-7592-7-git-send-email-emilio@elopez.com.ar>
References: <1404619518-7592-1-git-send-email-emilio@elopez.com.ar>
 <1404619518-7592-7-git-send-email-emilio@elopez.com.ar>
Message-ID: <CAGb2v66x6pse3vFDCKSONbgePMHbSjVw11mNJ8mOFcQ9EGdE_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 6, 2014 at 12:05 PM, Emilio L?pez <emilio@elopez.com.ar> wrote:
> All of our SPI controllers support DMA transfers, so let's add the
> properties here so they can be used when it's best to do so.
>
> Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>

Numbers are good.

Reviewed-by: Chen-Yu Tsai <wens@csie.org>


> ---
>  arch/arm/boot/dts/sun4i-a10.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi b/arch/arm/boot/dts/sun4i-a10.dtsi
> index f17cbeb..56d02af 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -353,6 +353,8 @@
>                         interrupts = <10>;
>                         clocks = <&ahb_gates 20>, <&spi0_clk>;
>                         clock-names = "ahb", "mod";
> +                       dmas = <&dma 1 27>, <&dma 1 26>;
> +                       dma-names = "rx", "tx";
>                         status = "disabled";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> @@ -364,6 +366,8 @@
>                         interrupts = <11>;
>                         clocks = <&ahb_gates 21>, <&spi1_clk>;
>                         clock-names = "ahb", "mod";
> +                       dmas = <&dma 1 9>, <&dma 1 8>;
> +                       dma-names = "rx", "tx";
>                         status = "disabled";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> @@ -459,6 +463,8 @@
>                         interrupts = <12>;
>                         clocks = <&ahb_gates 22>, <&spi2_clk>;
>                         clock-names = "ahb", "mod";
> +                       dmas = <&dma 1 29>, <&dma 1 28>;
> +                       dma-names = "rx", "tx";
>                         status = "disabled";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> @@ -498,6 +504,8 @@
>                         interrupts = <50>;
>                         clocks = <&ahb_gates 23>, <&spi3_clk>;
>                         clock-names = "ahb", "mod";
> +                       dmas = <&dma 1 31>, <&dma 1 30>;
> +                       dma-names = "rx", "tx";
>                         status = "disabled";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> --
> 2.0.1
