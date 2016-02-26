From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 26 Feb 2016 11:50:35 -0800
Subject: [RFC v2 12/12] ARM64: dts: Define CPU power domain for MSM8916
In-Reply-To: <1455310238-8963-13-git-send-email-lina.iyer@linaro.org>
References: <1455310238-8963-1-git-send-email-lina.iyer@linaro.org>
 <1455310238-8963-13-git-send-email-lina.iyer@linaro.org>
Message-ID: <20160226195035.GA28849@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12, Lina Iyer wrote:
> @@ -101,6 +105,27 @@
>  		};
>  	};
>  
> +	CPU_PD: cpu-pd at 0 {
> +		#power-domain-cells = <0>;
> +		power-states = <&CLUSTER_RET>, <&CLUSTER_PWR_DWN>;

Why isn't this part of the psci node? PSCI is the node that's
providing the code/logic for the power domain.

> +	};
> +
> +	pd-power-states {
> +		CLUSTER_RET: power-state at 1 {
> +			state-param = <0x1000010>;
> +			entry-latency-us = <500>;
> +			exit-latency-us = <500>;
> +			residency-us = <2000>;
> +		 };
> +
> +		CLUSTER_PWR_DWN: power-state at 2 {
> +			state-param = <0x1000030>;
> +			entry-latency-us = <2000>;
> +			exit-latency-us = <2000>;
> +			residency-us = <6000>;
> +		};
> +	};
> +

And I would expect these to be put somewhere inside the power
domain provider as well? Is this documented somewhere?

>  	psci {
>  		compatible = "arm,psci-1.0";
>  		method = "smc";

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
