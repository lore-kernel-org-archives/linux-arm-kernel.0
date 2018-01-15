From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 15 Jan 2018 22:27:31 +0200
Subject: [PATCH v2 01/16] drivers: pwm: core: use a single of xlate
 function
In-Reply-To: <6441df76-fb4a-ce00-1019-f7ff9143b75e@microchip.com>
References: <1515766983-15151-1-git-send-email-claudiu.beznea@microchip.com>
 <1515766983-15151-2-git-send-email-claudiu.beznea@microchip.com>
 <20180112183512.GB102880@google.com>
 <6441df76-fb4a-ce00-1019-f7ff9143b75e@microchip.com>
Message-ID: <CAHp75VcaFDEQ1cBzeU2eBj_vf19ok6EWLC07SOTQLRH8BQSbzA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 15, 2018 at 10:41 AM, Claudiu Beznea
<Claudiu.Beznea@microchip.com> wrote:

> For this driver, the PWM bindings were changed (I did a grep by "google,cros-ec-pwm"
> and located only:
> arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
> arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> files) and changed the bindings in this series, as follows, patch 7 from this series:
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
> index 0384e3121f18..0c790ec387eb 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru-kevin.dts
> @@ -77,7 +77,7 @@
>
>         backlight: backlight {
>                 compatible = "pwm-backlight";
> -               pwms = <&cros_ec_pwm 1>;
> +               pwms = <&cros_ec_pwm 1 65535>;

This shows an breakage for user. The old PWM device tree sources or
binaries should work independently on what changes you did to kernel.

-- 
With Best Regards,
Andy Shevchenko
