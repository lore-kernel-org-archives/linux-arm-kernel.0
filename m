From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 27 Nov 2018 00:49:23 +0900
Subject: [PATCH 6/6] ARM: dts: uniphier: Add all CPUs in cooling maps
In-Reply-To: <b522f13dfffcec1e2b78e126513114428ec9a4b4.1542362000.git.viresh.kumar@linaro.org>
References: <cover.1542362000.git.viresh.kumar@linaro.org>
 <b522f13dfffcec1e2b78e126513114428ec9a4b4.1542362000.git.viresh.kumar@linaro.org>
Message-ID: <CAK7LNATh3cGVC+KhBtATyzvCnzqv_QpFujjg_J7WikRHq0rjPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 7:02 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
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
>  arch/arm/boot/dts/uniphier-pxs2.dtsi | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
> index 8d20e9548e39..06a049f6edf8 100644
> --- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
> +++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
> @@ -141,8 +141,10 @@
>                         cooling-maps {
>                                 map {
>                                         trip = <&cpu_alert>;
> -                                       cooling-device = <&cpu0
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
