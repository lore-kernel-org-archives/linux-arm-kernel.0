From: xuwei5@hisilicon.com (Wei Xu)
Date: Sat, 26 May 2018 19:00:20 +0100
Subject: [PATCH 3/6] arm64: dts: hisilicon: Add missing cooling device
 properties for CPUs
In-Reply-To: <0754957a2c3842cf4e36fa27231d327fd8d6d499.1527225682.git.viresh.kumar@linaro.org>
References: <cover.1527225682.git.viresh.kumar@linaro.org>
 <0754957a2c3842cf4e36fa27231d327fd8d6d499.1527225682.git.viresh.kumar@linaro.org>
Message-ID: <5B09A0B4.2080400@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Viresh,

On 2018/5/25 6:40, Viresh Kumar wrote:
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
> Do minor rearrangement as well to keep ordering consistent.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!
Applied to the hisilicon fix tree.

Best Regards,
Wei

> ---
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index 586b281cd531..247024df714f 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -88,8 +88,8 @@
>  			next-level-cache = <&CLUSTER0_L2>;
>  			clocks = <&stub_clock 0>;
>  			operating-points-v2 = <&cpu_opp_table>;
> -			#cooling-cells = <2>; /* min followed by max */
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			#cooling-cells = <2>; /* min followed by max */
>  			dynamic-power-coefficient = <311>;
>  		};
>  
> @@ -101,6 +101,8 @@
>  			next-level-cache = <&CLUSTER0_L2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			#cooling-cells = <2>; /* min followed by max */
> +			dynamic-power-coefficient = <311>;
>  		};
>  
>  		cpu2: cpu at 2 {
> @@ -111,6 +113,8 @@
>  			next-level-cache = <&CLUSTER0_L2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			#cooling-cells = <2>; /* min followed by max */
> +			dynamic-power-coefficient = <311>;
>  		};
>  
>  		cpu3: cpu at 3 {
> @@ -121,6 +125,8 @@
>  			next-level-cache = <&CLUSTER0_L2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			#cooling-cells = <2>; /* min followed by max */
> +			dynamic-power-coefficient = <311>;
>  		};
>  
>  		cpu4: cpu at 100 {
> @@ -131,6 +137,8 @@
>  			next-level-cache = <&CLUSTER1_L2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			#cooling-cells = <2>; /* min followed by max */
> +			dynamic-power-coefficient = <311>;
>  		};
>  
>  		cpu5: cpu at 101 {
> @@ -141,6 +149,8 @@
>  			next-level-cache = <&CLUSTER1_L2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			#cooling-cells = <2>; /* min followed by max */
> +			dynamic-power-coefficient = <311>;
>  		};
>  
>  		cpu6: cpu at 102 {
> @@ -151,6 +161,8 @@
>  			next-level-cache = <&CLUSTER1_L2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			#cooling-cells = <2>; /* min followed by max */
> +			dynamic-power-coefficient = <311>;
>  		};
>  
>  		cpu7: cpu at 103 {
> @@ -161,6 +173,8 @@
>  			next-level-cache = <&CLUSTER1_L2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			#cooling-cells = <2>; /* min followed by max */
> +			dynamic-power-coefficient = <311>;
>  		};
>  
>  		CLUSTER0_L2: l2-cache0 {
> 
