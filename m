From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 27 Nov 2018 00:49:04 +0900
Subject: [PATCH 10/10] ARM64: dts: uniphier: Add all CPUs in cooling maps
In-Reply-To: <c759699a44189aed078186fd19089d2f44d988e3.1542362530.git.viresh.kumar@linaro.org>
References: <cover.1542362530.git.viresh.kumar@linaro.org>
 <c759699a44189aed078186fd19089d2f44d988e3.1542362530.git.viresh.kumar@linaro.org>
Message-ID: <CAK7LNAQ5OhS4tcZCP_Rykpxsgc5-rJTiZXS_yOravZv6iEeP3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 7:06 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> Each CPU can (and does) participate in cooling down the system but the
> DT only captures a handful of them, normally CPU0, in the cooling maps.
> Things work by chance currently as under normal circumstances its the
> first CPU of each cluster which is used by the operating systems to
> probe the cooling devices. But as soon as this CPU ordering changes and
> any other CPU is used to bring up the cooling device, we will start
> seeing failures.
>
> Also the DT is rather incomplete when we list only one CPU in the
> cooling maps, as the hardware doesn't have any such limitations.
>
> Update cooling maps to include all devices affected by individual trip
> points.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>


Applied to linux-uniphier.
Thanks.




> ---
>  arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> index d7e2d8969601..4a0c46cb11cd 100644
> --- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> +++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
> @@ -206,13 +206,10 @@
>                         cooling-maps {
>                                 map0 {
>                                         trip = <&cpu_alert>;
> -                                       cooling-device = <&cpu0
> -                                           THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> -                               };
> -                               map1 {
> -                                       trip = <&cpu_alert>;
> -                                       cooling-device = <&cpu2
> -                                           THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +                                       cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +                                                        <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
>                                 };
>                         };
>                 };
> --
> 2.19.1.568.g152ad8e3369a
>


-- 
Best Regards
Masahiro Yamada
