From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 8 Dec 2015 12:11:06 +0000
Subject: [PATCH v2] arm64: dts: juno: Add idle-states to device tree
In-Reply-To: <1449513481.3012.16.camel@linaro.org>
References: <1449513481.3012.16.camel@linaro.org>
Message-ID: <20151208121106.GA404@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 07, 2015 at 06:38:01PM +0000, Jon Medhurst (Tixy) wrote:
> The latency times were suggested by Lorenzo Pieralisi after some ad hoc
> testing.
> 
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
> 
> Lorenzo, are you happy with my statement that you did 'ad hoc testing'
> to derive the figures or is there something more specific that's worth
> adding?

Well, it is what I did but I would rephrase the commit log. I am
ok with the patch as it is as long as you update the commit log.

"This patch adds idle-states bindings data collected through a set
of benchmarking experiments (latency and energy consumption) on Juno boards.
Lantecies data represents the worst case scenarios as required by the DT
idle-states bindings." or something like that.

Thanks,
Lorenzo

> 
>  arch/arm64/boot/dts/arm/juno-r1.dts | 28 ++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/arm/juno.dts    | 28 ++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
> index 93bc3d7..8826f83 100644
> --- a/arch/arm64/boot/dts/arm/juno-r1.dts
> +++ b/arch/arm64/boot/dts/arm/juno-r1.dts
> @@ -60,6 +60,28 @@
>  			};
>  		};
>  
> +		idle-states {
> +			entry-method = "arm,psci";
> +
> +			CPU_SLEEP_0: cpu-sleep-0 {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x0010000>;
> +				local-timer-stop;
> +				entry-latency-us = <300>;
> +				exit-latency-us = <1200>;
> +				min-residency-us = <2000>;
> +			};
> +
> +			CLUSTER_SLEEP_0: cluster-sleep-0 {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x1010000>;
> +				local-timer-stop;
> +				entry-latency-us = <300>;
> +				exit-latency-us = <1200>;
> +				min-residency-us = <2500>;
> +			};
> +		};
> +
>  		A57_0: cpu at 0 {
>  			compatible = "arm,cortex-a57","arm,armv8";
>  			reg = <0x0 0x0>;
> @@ -67,6 +89,7 @@
>  			enable-method = "psci";
>  			next-level-cache = <&A57_L2>;
>  			clocks = <&scpi_dvfs 0>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		A57_1: cpu at 1 {
> @@ -76,6 +99,7 @@
>  			enable-method = "psci";
>  			next-level-cache = <&A57_L2>;
>  			clocks = <&scpi_dvfs 0>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		A53_0: cpu at 100 {
> @@ -85,6 +109,7 @@
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
>  			clocks = <&scpi_dvfs 1>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		A53_1: cpu at 101 {
> @@ -94,6 +119,7 @@
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
>  			clocks = <&scpi_dvfs 1>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		A53_2: cpu at 102 {
> @@ -103,6 +129,7 @@
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
>  			clocks = <&scpi_dvfs 1>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		A53_3: cpu at 103 {
> @@ -112,6 +139,7 @@
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
>  			clocks = <&scpi_dvfs 1>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		A57_L2: l2-cache0 {
> diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
> index 53442b5..dcfcf15 100644
> --- a/arch/arm64/boot/dts/arm/juno.dts
> +++ b/arch/arm64/boot/dts/arm/juno.dts
> @@ -60,6 +60,28 @@
>  			};
>  		};
>  
> +		idle-states {
> +			entry-method = "arm,psci";
> +
> +			CPU_SLEEP_0: cpu-sleep-0 {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x0010000>;
> +				local-timer-stop;
> +				entry-latency-us = <300>;
> +				exit-latency-us = <1200>;
> +				min-residency-us = <2000>;
> +			};
> +
> +			CLUSTER_SLEEP_0: cluster-sleep-0 {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x1010000>;
> +				local-timer-stop;
> +				entry-latency-us = <300>;
> +				exit-latency-us = <1200>;
> +				min-residency-us = <2500>;
> +			};
> +		};
> +
>  		A57_0: cpu at 0 {
>  			compatible = "arm,cortex-a57","arm,armv8";
>  			reg = <0x0 0x0>;
> @@ -67,6 +89,7 @@
>  			enable-method = "psci";
>  			next-level-cache = <&A57_L2>;
>  			clocks = <&scpi_dvfs 0>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		A57_1: cpu at 1 {
> @@ -76,6 +99,7 @@
>  			enable-method = "psci";
>  			next-level-cache = <&A57_L2>;
>  			clocks = <&scpi_dvfs 0>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		A53_0: cpu at 100 {
> @@ -85,6 +109,7 @@
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
>  			clocks = <&scpi_dvfs 1>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		A53_1: cpu at 101 {
> @@ -94,6 +119,7 @@
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
>  			clocks = <&scpi_dvfs 1>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		A53_2: cpu at 102 {
> @@ -103,6 +129,7 @@
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
>  			clocks = <&scpi_dvfs 1>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		A53_3: cpu at 103 {
> @@ -112,6 +139,7 @@
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
>  			clocks = <&scpi_dvfs 1>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		A57_L2: l2-cache0 {
> -- 
> 2.1.4
> 
> 
> 
