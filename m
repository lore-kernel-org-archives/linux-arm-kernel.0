From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 7 Jul 2014 15:33:35 +0800
Subject: [PATCH v2 7/8] ARM: sun5i: enable DMA on SPI
In-Reply-To: <1404619518-7592-8-git-send-email-emilio@elopez.com.ar>
References: <1404619518-7592-1-git-send-email-emilio@elopez.com.ar>
 <1404619518-7592-8-git-send-email-emilio@elopez.com.ar>
Message-ID: <CAGb2v66oNJSw9_tMWJ1PYo9Nm2ReN-=ocuahAXyn6KABrwqw3g@mail.gmail.com>
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
>  arch/arm/boot/dts/sun5i-a10s.dtsi | 6 ++++++
>  arch/arm/boot/dts/sun5i-a13.dtsi  | 6 ++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun5i-a10s.dtsi b/arch/arm/boot/dts/sun5i-a10s.dtsi
> index 3708817..12f26f3 100644
> --- a/arch/arm/boot/dts/sun5i-a10s.dtsi
> +++ b/arch/arm/boot/dts/sun5i-a10s.dtsi
> @@ -314,6 +314,8 @@
>                         interrupts = <10>;
>                         clocks = <&ahb_gates 20>, <&spi0_clk>;
>                         clock-names = "ahb", "mod";
> +                       dmas = <&dma 1 27>, <&dma 1 26>;
> +                       dma-names = "rx", "tx";
>                         status = "disabled";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> @@ -325,6 +327,8 @@
>                         interrupts = <11>;
>                         clocks = <&ahb_gates 21>, <&spi1_clk>;
>                         clock-names = "ahb", "mod";
> +                       dmas = <&dma 1 9>, <&dma 1 8>;
> +                       dma-names = "rx", "tx";
>                         status = "disabled";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> @@ -411,6 +415,8 @@
>                         interrupts = <12>;
>                         clocks = <&ahb_gates 22>, <&spi2_clk>;
>                         clock-names = "ahb", "mod";
> +                       dmas = <&dma 1 29>, <&dma 1 28>;
> +                       dma-names = "rx", "tx";
>                         status = "disabled";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
> index 1f1adf2..4bbf455 100644
> --- a/arch/arm/boot/dts/sun5i-a13.dtsi
> +++ b/arch/arm/boot/dts/sun5i-a13.dtsi
> @@ -312,6 +312,8 @@
>                         interrupts = <10>;
>                         clocks = <&ahb_gates 20>, <&spi0_clk>;
>                         clock-names = "ahb", "mod";
> +                       dmas = <&dma 1 27>, <&dma 1 26>;
> +                       dma-names = "rx", "tx";
>                         status = "disabled";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> @@ -323,6 +325,8 @@
>                         interrupts = <11>;
>                         clocks = <&ahb_gates 21>, <&spi1_clk>;
>                         clock-names = "ahb", "mod";
> +                       dmas = <&dma 1 9>, <&dma 1 8>;
> +                       dma-names = "rx", "tx";
>                         status = "disabled";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> @@ -384,6 +388,8 @@
>                         interrupts = <12>;
>                         clocks = <&ahb_gates 22>, <&spi2_clk>;
>                         clock-names = "ahb", "mod";
> +                       dmas = <&dma 1 29>, <&dma 1 28>;
> +                       dma-names = "rx", "tx";
>                         status = "disabled";
>                         #address-cells = <1>;
>                         #size-cells = <0>;
> --
> 2.0.1
