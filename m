From: punit.agrawal@arm.com (Punit Agrawal)
Date: Thu, 22 Oct 2015 14:22:33 +0100
Subject: [PATCH] arm64: dts: Add idle-states for Juno
In-Reply-To: <1430402268.2868.20.camel@linaro.org> (Jon Medhurst's message of
 "Thu, 30 Apr 2015 14:57:48 +0100")
References: <1430402268.2868.20.camel@linaro.org>
Message-ID: <9hheggnca1y.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Jon Medhurst (Tixy)" <tixy@linaro.org> writes:

> From: Jon Medhurst <tixy@linaro.org>
>
> Signed-off-by: Jon Medhurst <tixy@linaro.org>

Apologies for resurrecting an old thread.

Following the discussion on this thread, even though certain concerns
were raised, there wasn't any objection to $SUBJECT being merged.

I don't see this patch in any tree; perhaps it's slipped through the
cracks.

Could this be merged please?

> ---
>
> These have been kicking around out of tree for ages, any reason they
> shouldn't be in mainline? Also, was unsure of what to put in commit
> message.
>
>  arch/arm64/boot/dts/arm/juno.dts | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
> index 133ee59..7a9a449 100644
> --- a/arch/arm64/boot/dts/arm/juno.dts
> +++ b/arch/arm64/boot/dts/arm/juno.dts
> @@ -34,12 +34,35 @@
>  		#address-cells = <2>;
>  		#size-cells = <0>;
>  
> +		idle-states {
> +			entry-method = "arm,psci";
> +
> +			CPU_SLEEP_0: cpu-sleep-0 {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x0010000>;
> +				local-timer-stop;
> +				entry-latency-us = <100>;
> +				exit-latency-us = <250>;
> +				min-residency-us = <2000>;
> +			};
> +
> +			CLUSTER_SLEEP_0: cluster-sleep-0 {
> +				compatible = "arm,idle-state";
> +				arm,psci-suspend-param = <0x1010000>;
> +				local-timer-stop;
> +				entry-latency-us = <800>;
> +				exit-latency-us = <700>;
> +				min-residency-us = <2500>;
> +			};
> +		};
> +
>  		A57_0: cpu at 0 {
>  			compatible = "arm,cortex-a57","arm,armv8";
>  			reg = <0x0 0x0>;
>  			device_type = "cpu";
>  			enable-method = "psci";
>  			next-level-cache = <&A57_L2>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		A57_1: cpu at 1 {
> @@ -48,6 +71,7 @@
>  			device_type = "cpu";
>  			enable-method = "psci";
>  			next-level-cache = <&A57_L2>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		A53_0: cpu at 100 {
> @@ -56,6 +80,7 @@
>  			device_type = "cpu";
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		A53_1: cpu at 101 {
> @@ -64,6 +89,7 @@
>  			device_type = "cpu";
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		A53_2: cpu at 102 {
> @@ -72,6 +98,7 @@
>  			device_type = "cpu";
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		A53_3: cpu at 103 {
> @@ -80,6 +107,7 @@
>  			device_type = "cpu";
>  			enable-method = "psci";
>  			next-level-cache = <&A53_L2>;
> +			cpu-idle-states = <&CPU_SLEEP_0 &CLUSTER_SLEEP_0>;
>  		};
>  
>  		A57_L2: l2-cache0 {
