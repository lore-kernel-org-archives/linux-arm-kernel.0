From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 2 Mar 2018 16:03:54 +0000
Subject: [PATCH 05/10] ARM64: dts: hi6220: Remove
 "cooling-{min|max}-level" for CPU nodes
In-Reply-To: <68740229a7397336ae92bad65f69a58c91819c37.1518166039.git.viresh.kumar@linaro.org>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <68740229a7397336ae92bad65f69a58c91819c37.1518166039.git.viresh.kumar@linaro.org>
Message-ID: <5A9975EA.3010306@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On 2018/2/9 8:58, Viresh Kumar wrote:
> The "cooling-min-level" and "cooling-max-level" properties are not
> parsed by any part of the kernel currently and the max cooling state of
> a CPU cooling device is found by referring to the cpufreq table instead.
> 
> Moreover, the entries are incorrect here as min level is 4 and the max
> level is 0.
> 
> Remove the unused properties from the CPU nodes.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Applied into hisilicon dt tree.
Thanks!

BR,
Wei

>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index 6a180d1926e8..fca8e4ee98e7 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -88,8 +88,6 @@
>  			next-level-cache = <&CLUSTER0_L2>;
>  			clocks = <&stub_clock 0>;
>  			operating-points-v2 = <&cpu_opp_table>;
> -			cooling-min-level = <4>;
> -			cooling-max-level = <0>;
>  			#cooling-cells = <2>; /* min followed by max */
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
>  			dynamic-power-coefficient = <311>;
> 
