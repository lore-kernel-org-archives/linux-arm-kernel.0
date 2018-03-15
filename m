From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 15 Mar 2018 23:54:32 +0900
Subject: [PATCH] arm64: dts: uniphier: divide I2S and S/PDIF audio out
 pin-mux group
In-Reply-To: <20180314063700.13365-1-suzuki.katsuhiro@socionext.com>
References: <20180314063700.13365-1-suzuki.katsuhiro@socionext.com>
Message-ID: <CAK7LNARWj+v5mA6cA7mF8xZg-H1PHSp9WsWLNfQLZQngby=kUA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-03-14 15:37 GMT+09:00 Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>:
> This patch divides large pin-mux group 'aio' of UniPhier LD11/LD20
> audio system as following:
>   aout1   : 8ch I2S output: AO1DACCK, AO1BCK, AO1LRCK, AO1D[0-2]
>   aoutiec1: S/PDIF output : AO1IEC, AO1ARC
>
> Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
> ---

Squashed to the previos
"arm64: dts: uniphier: add sound node"

Thanks!

>  arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 5 +++--
>  arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 9 +++++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
> index c17b77091129..e64b03fc0cae 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
> @@ -192,7 +192,8 @@
>                         reg = <0x56000000 0x80000>;
>                         interrupts = <0 144 4>;
>                         pinctrl-names = "default";
> -                       pinctrl-0 = <&pinctrl_aout>;
> +                       pinctrl-0 = <&pinctrl_aout1>,
> +                                   <&pinctrl_aoutiec1>;
>                         clock-names = "aio";
>                         clocks = <&sys_clk 40>;
>                         reset-names = "aio";
> @@ -578,7 +579,7 @@
>
>  #include "uniphier-pinctrl.dtsi"
>
> -&pinctrl_aout {
> +&pinctrl_aoutiec1 {
>         drive-strength = <4>;   /* default: 4mA */
>
>         ao1arc {
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> index c85e790fd00d..9a5df24059a2 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> @@ -292,7 +292,8 @@
>                         reg = <0x56000000 0x80000>;
>                         interrupts = <0 144 4>;
>                         pinctrl-names = "default";
> -                       pinctrl-0 = <&pinctrl_aout>;
> +                       pinctrl-0 = <&pinctrl_aout1>,
> +                                   <&pinctrl_aoutiec1>;
>                         clock-names = "aio";
>                         clocks = <&sys_clk 40>;
>                         reset-names = "aio";
> @@ -633,13 +634,17 @@
>
>  #include "uniphier-pinctrl.dtsi"
>
> -&pinctrl_aout {
> +&pinctrl_aout1 {
>         drive-strength = <4>;   /* default: 3.5mA */
>
>         ao1dacck {
>                 pins = "AO1DACCK";
>                 drive-strength = <5>;   /* 5mA */
>         };
> +};
> +
> +&pinctrl_aoutiec1 {
> +       drive-strength = <4>;   /* default: 3.5mA */
>
>         ao1arc {
>                 pins = "AO1ARC";
> --
> 2.16.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
