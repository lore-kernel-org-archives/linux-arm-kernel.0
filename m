From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 10 Aug 2017 19:44:38 +0900
Subject: [PATCH v3 1/2] ARM: dts: uniphier: add nodes of thermal monitor
 and thermal zone for PXs2
In-Reply-To: <1499255595-31805-2-git-send-email-hayashi.kunihiko@socionext.com>
References: <1499255595-31805-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1499255595-31805-2-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <CAK7LNAS2chLuW_PzeghNCTYf038qS_BgxMqJ6FoQbqT6hRJYSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hayashi-san


2017-07-05 20:53 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:
> Add nodes of thermal monitor and thermal zone for UniPhier PXs2 SoC.
> The thermal monitor is included in sysctrl.
> Furthermore, add cpuN labels for reference in cooling-device property.
>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---


Please add socionext,tmod-calibration
in case the efuse is not brown.


>
> +       thermal-zones {
> +               cpu_thermal {
> +                       polling-delay-passive = <250>;  /* 250ms */
> +                       polling-delay = <1000>;         /* 1000ms */
> +                       thermal-sensors = <&pvtctl>;
> +
> +                       trips {
> +                               cpu_crit: cpu_crit {
> +                                       temperature = <95000>;  /* 95C */
> +                                       hysteresis = <2000>;
> +                                       type = "critical";
> +                               };
> +                               cpu_alert: cpu_alert {
> +                                       temperature = <85000>;  /* 85C */
> +                                       hysteresis = <2000>;
> +                                       type = "passive";
> +                               };
> +                       };
> +
> +                       cooling-maps {
> +                               map {
> +                                       trip = <&cpu_alert>;
> +                                       cooling-device = <&cpu0 (-1) (-1)>;
> +                               };


After all, I decided to use dt-bindings headers.
Could you use THERMAL_NO_LIMIT for clarification?



-- 
Best Regards
Masahiro Yamada
