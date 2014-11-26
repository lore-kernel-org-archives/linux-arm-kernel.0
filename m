From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Nov 2014 12:18:51 -0800
Subject: [PATCH v10 10/10] arm: dts: qcom: Add idle state device nodes
 for 8064
In-Reply-To: <1416593037-27527-11-git-send-email-lina.iyer@linaro.org>
References: <1416593037-27527-1-git-send-email-lina.iyer@linaro.org>
 <1416593037-27527-11-git-send-email-lina.iyer@linaro.org>
Message-ID: <547635AB.3010700@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2014 10:03 AM, Lina Iyer wrote:
> Add ARM common idle state device bindings for cpuidle support for APQ
> 8064.
>
> Support Standby and Standalone power collapse (power down that does not
> affect any SoC idle states) for each cpu.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

With nitpick addressed:

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

> @@ -53,12 +56,30 @@
>   			next-level-cache = <&L2>;
>   			qcom,acc = <&acc3>;
>   			qcom,saw = <&saw3>;
> +			cpu-idle-states = <&CPU_STBY &CPU_SPC>;
>   		};
>   
>   		L2: l2-cache {
>   			compatible = "cache";
>   			cache-level = <2>;
>   		};
> +
> +		idle-states {
> +			CPU_STBY: standby {
> +				compatible = "qcom,idle-state-stby", "arm,idle-state";
> +				entry-latency-us = <1>;
> +				exit-latency-us = <1>;
> +				min-residency-us = <2>;
> +			};
> +
> +			CPU_SPC: spc {
> +				compatible = "qcom,idle-state-spc", "arm,idle-state";
> +				entry-latency-us = <400>;
> +				exit-latency-us = <900>;
> +				min-residency-us = <3000>;
> +			};
> +		};
> +

Nitpick, no need for blank line here.

>   	};
>   
>   	cpu-pmu {


-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
