From: xuwei5@hisilicon.com (Wei Xu)
Date: Fri, 15 Apr 2016 17:19:39 +0100
Subject: [PATCH] arm64: dts: Add L2 cache topology to Hi6220
In-Reply-To: <1456464514-24380-1-git-send-email-leo.yan@linaro.org>
References: <1456464514-24380-1-git-send-email-leo.yan@linaro.org>
Message-ID: <5711149B.8000805@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Leo,

On 26/02/2016 05:28, Leo Yan wrote:
> This patch adds the L2 cache topology on Hi6220. Hi6220 has two
> clusters, every cluster has 512KiB L2 cache (32KiB x 16 ways).
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---

Applied.
Thanks!

Best Regards,
Wei

>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index d8b963c..1746d50 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -82,6 +82,7 @@
>  			device_type = "cpu";
>  			reg = <0x0 0x0>;
>  			enable-method = "psci";
> +			next-level-cache = <&CLUSTER0_L2>;
>  			clocks = <&stub_clock 0>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			cooling-min-level = <4>;
> @@ -96,6 +97,7 @@
>  			device_type = "cpu";
>  			reg = <0x0 0x1>;
>  			enable-method = "psci";
> +			next-level-cache = <&CLUSTER0_L2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
>  		};
> @@ -105,6 +107,7 @@
>  			device_type = "cpu";
>  			reg = <0x0 0x2>;
>  			enable-method = "psci";
> +			next-level-cache = <&CLUSTER0_L2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
>  		};
> @@ -114,6 +117,7 @@
>  			device_type = "cpu";
>  			reg = <0x0 0x3>;
>  			enable-method = "psci";
> +			next-level-cache = <&CLUSTER0_L2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
>  		};
> @@ -123,6 +127,7 @@
>  			device_type = "cpu";
>  			reg = <0x0 0x100>;
>  			enable-method = "psci";
> +			next-level-cache = <&CLUSTER1_L2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
>  		};
> @@ -132,6 +137,7 @@
>  			device_type = "cpu";
>  			reg = <0x0 0x101>;
>  			enable-method = "psci";
> +			next-level-cache = <&CLUSTER1_L2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
>  		};
> @@ -141,6 +147,7 @@
>  			device_type = "cpu";
>  			reg = <0x0 0x102>;
>  			enable-method = "psci";
> +			next-level-cache = <&CLUSTER1_L2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
>  		};
> @@ -150,9 +157,18 @@
>  			device_type = "cpu";
>  			reg = <0x0 0x103>;
>  			enable-method = "psci";
> +			next-level-cache = <&CLUSTER1_L2>;
>  			operating-points-v2 = <&cpu_opp_table>;
>  			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
>  		};
> +
> +		CLUSTER0_L2: l2-cache0 {
> +			compatible = "cache";
> +		};
> +
> +		CLUSTER1_L2: l2-cache1 {
> +			compatible = "cache";
> +		};
>  	};
>  
>  	cpu_opp_table: cpu_opp_table {
> 
