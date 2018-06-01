From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 1 Jun 2018 12:25:56 +0900
Subject: [PATCH 05/15] arm: dts: uniphier: Add missing cooling device
 properties for CPUs
In-Reply-To: <51ac4a5f0466aeed3f223663d9c34d6345b2a1f2.1527244201.git.viresh.kumar@linaro.org>
References: <cover.1527244200.git.viresh.kumar@linaro.org>
 <51ac4a5f0466aeed3f223663d9c34d6345b2a1f2.1527244201.git.viresh.kumar@linaro.org>
Message-ID: <CAK7LNATuDC4i1VoA6W7DmPDuiqOWix0SbWa2baOsfAi-Fk7vBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-05-25 19:31 GMT+09:00 Viresh Kumar <viresh.kumar@linaro.org>:
> The cooling device properties, like "#cooling-cells" and
> "dynamic-power-coefficient", should either be present for all the CPUs
> of a cluster or none. If these are present only for a subset of CPUs of
> a cluster then things will start falling apart as soon as the CPUs are
> brought online in a different order. For example, this will happen
> because the operating system looks for such properties in the CPU node
> it is trying to bring up, so that it can register a cooling device.
>
> Add such missing properties.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>


Applied to linux-uniphier.

I had already sent a PR for v4.18-rc1 before I received this patch.
Please wait for v4.19-rc1.

Thanks.


> ---
>  arch/arm/boot/dts/uniphier-pxs2.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
> index debcbd15c24b..40ed15465095 100644
> --- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
> +++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
> @@ -36,6 +36,7 @@
>                         enable-method = "psci";
>                         next-level-cache = <&l2>;
>                         operating-points-v2 = <&cpu_opp>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 cpu2: cpu at 2 {
> @@ -46,6 +47,7 @@
>                         enable-method = "psci";
>                         next-level-cache = <&l2>;
>                         operating-points-v2 = <&cpu_opp>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 cpu3: cpu at 3 {
> @@ -56,6 +58,7 @@
>                         enable-method = "psci";
>                         next-level-cache = <&l2>;
>                         operating-points-v2 = <&cpu_opp>;
> +                       #cooling-cells = <2>;
>                 };
>         };
>
> --
> 2.15.0.194.g9af6a3dea062
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
