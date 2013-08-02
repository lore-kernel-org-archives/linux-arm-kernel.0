From: sjoshi.open@gmail.com (sunil joshi)
Date: Fri, 2 Aug 2013 12:02:17 +0530
Subject: [PATCH V2 6/8] ARM: dts: exynos5420: add i2s controllers
In-Reply-To: <1374845812-7803-7-git-send-email-padma.v@samsung.com>
References: <1374845812-7803-1-git-send-email-padma.v@samsung.com>
 <1374845812-7803-7-git-send-email-padma.v@samsung.com>
Message-ID: <CANruHrT6m233MH69XitCwb66cgKvAngKBv5EPPD4xb-1jx1DUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Padma,
You may move the common stuff of I2S contents for 5250 & 5420 into exynos5.dtsi.

Regards
Sunil

On Fri, Jul 26, 2013 at 7:06 PM, Padmavathi Venna <padma.v@samsung.com> wrote:
> From: Andrew Bresticker <abrestic@chromium.org>
>
> This adds device-tree bindings for the i2s controllers on Exynos 5420.
>
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> Reviewed-on: https://gerrit.chromium.org/gerrit/57713
> ---
>  arch/arm/boot/dts/exynos5420.dtsi |   44 +++++++++++++++++++++++++++++++++++++
>  1 files changed, 44 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index d2fdb87..c9ed8d2 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -242,4 +242,48 @@
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&i2c3_bus>;
>         };
> +
> +       i2s_0: i2s at 03830000 {
> +               compatible = "samsung,exynos5420-i2s";
> +               reg = <0x03830000 0x100>;
> +               dmas = <&adma 0
> +                       &adma 2
> +                       &adma 1>;
> +               dma-names = "tx", "rx", "tx-sec";
> +               clocks = <&clock_audss EXYNOS_I2S_BUS>,
> +                       <&clock_audss EXYNOS_I2S_BUS>,
> +                       <&clock_audss EXYNOS_SCLK_I2S>;
> +               clock-names = "iis", "i2s_opclk0", "i2s_opclk1";
> +               samsung,idma-addr = <0x03000000>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&i2s0_bus>;
> +               status = "disabled";
> +       };
> +
> +       i2s_1: i2s at 12D60000 {
> +               compatible = "samsung,s3c6410-i2s";
> +               reg = <0x12D60000 0x100>;
> +               dmas = <&pdma1 12
> +                       &pdma1 11>;
> +               dma-names = "tx", "rx";
> +               clocks = <&clock 275>, <&clock 138>;
> +               clock-names = "iis", "i2s_opclk0";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&i2s1_bus>;
> +               status = "disabled";
> +       };
> +
> +       i2s_2: i2s at 12D70000 {
> +               compatible = "samsung,s3c6410-i2s";
> +               reg = <0x12D70000 0x100>;
> +               dmas = <&pdma0 12
> +                       &pdma0 11>;
> +               dma-names = "tx", "rx";
> +               clocks = <&clock 276>, <&clock 139>;
> +               clock-names = "iis", "i2s_opclk0";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&i2s2_bus>;
> +               status = "disabled";
> +       };
> +
>  };
> --
> 1.7.4.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
