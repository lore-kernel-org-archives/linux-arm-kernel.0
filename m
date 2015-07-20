From: djkurtz@chromium.org (Daniel Kurtz)
Date: Mon, 20 Jul 2015 20:22:38 +0800
Subject: [PATCH v6 3/3] arm64: dts: mt8173: add MT8173 display PWM driver
 support node
In-Reply-To: <1437380237-28961-4-git-send-email-yh.huang@mediatek.com>
References: <1437380237-28961-1-git-send-email-yh.huang@mediatek.com>
 <1437380237-28961-4-git-send-email-yh.huang@mediatek.com>
Message-ID: <CAGS+omCKipMoQG7Mw6OJ0tmNdmbQP-3FQVtmeSqZi4janyuMKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 20, 2015 at 4:17 PM, YH Huang <yh.huang@mediatek.com> wrote:
> Add display PWM node in mt8173-evb.dts and mt8173.dtsi.
>
> Signed-off-by: YH Huang <yh.huang@mediatek.com>

For the series:
Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> ---
>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts | 15 +++++++++++++++
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi    | 22 ++++++++++++++++++++++
>  2 files changed, 37 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> index f433c21..b7c1d9f 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> @@ -34,6 +34,21 @@
>         chosen { };
>  };
>
> +&pio {
> +       disp_pwm0_pins: disp_pwm0_pins {
> +               pins1 {
> +                       pinmux = <MT8173_PIN_87_DISP_PWM0__FUNC_DISP_PWM0>;
> +                       bias-pull-up;
> +               };
> +       };
> +};
> +
> +&pwm0 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&disp_pwm0_pins>;
> +       status = "okay";
> +};
> +
>  &pwrap {
>         pmic: mt6397 {
>                 compatible = "mediatek,mt6397";
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> index 0696f8f..44cab19 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -393,6 +393,28 @@
>                         #size-cells = <0>;
>                         status = "disabled";
>                 };
> +
> +               pwm0: pwm at 1401e000 {
> +                       compatible = "mediatek,mt8173-disp-pwm",
> +                                    "mediatek,mt6595-disp-pwm";
> +                       reg = <0 0x1401e000 0 0x1000>;
> +                       #pwm-cells = <2>;
> +                       clocks = <&mmsys CLK_MM_DISP_PWM026M>,
> +                                <&mmsys CLK_MM_DISP_PWM0MM>;
> +                       clock-names = "main", "mm";
> +                       status = "disabled";
> +               };
> +
> +               pwm1: pwm at 1401f000 {
> +                       compatible = "mediatek,mt8173-disp-pwm",
> +                                    "mediatek,mt6595-disp-pwm";
> +                       reg = <0 0x1401f000 0 0x1000>;
> +                       #pwm-cells = <2>;
> +                       clocks = <&mmsys CLK_MM_DISP_PWM126M>,
> +                                <&mmsys CLK_MM_DISP_PWM1MM>;
> +                       clock-names = "main", "mm";
> +                       status = "disabled";
> +               };
>         };
>  };
>
> --
> 1.8.1.1.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
