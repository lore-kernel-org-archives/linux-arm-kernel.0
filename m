From: nm@ti.com (Nishanth Menon)
Date: Thu, 21 May 2015 00:34:47 -0500
Subject: [PATCH V5 2/3] OPP: Allow multiple OPP tables to be passed via DT
In-Reply-To: <4690ad854263d6553debab67d65d230105c206ec.1432091956.git.viresh.kumar@linaro.org>
References: <cover.1432091956.git.viresh.kumar@linaro.org>
 <4690ad854263d6553debab67d65d230105c206ec.1432091956.git.viresh.kumar@linaro.org>
Message-ID: <555D6E77.3060206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/19/2015 10:41 PM, Viresh Kumar wrote:
Thinking a little more..

> +Example 5: Multiple OPP tables
> +
> +/ {
> +	cpus {
> +		cpu at 0 {
> +			compatible = "arm,cortex-a7";
> +			...
> +
> +			opp-supply = <&cpu_supply>
> +			operating-points-v2 = <&cpu0_opp0>, <&cpu0_opp1>;
> +		};
> +	};
> +
> +	cpu0_opp0: opp0 {

Maybe we should rename these as cpu0_opp_table_slow opp_table-fast

> +		compatible = "operating-points-v2";
> +		opp-name = "opp-slow";

just name = "slow" ?

> +		opp-shared;
> +
> +		entry00 {

rename these as opp0, opp01 etc?
these are the actual OPP description, while, what we call "cpu0_opp0" is
actually an OPP table choice we have.

> +			opp-hz = <600000000>;
> +			...
> +		};
> +
> +		entry01 {
> +			opp-hz = <800000000>;
> +			...
> +		};
> +	};
> +
> +	cpu0_opp1: opp1 {
> +		compatible = "operating-points-v2";
> +		opp-name = "opp-fast";
> +		opp-shared;
> +
> +		entry10 {
> +			opp-hz = <1000000000>;
> +			...
> +		};
> +
> +		entry11 {
> +			opp-hz = <1100000000>;
> +			...
> +		};
> +	};
> +};
> 


-- 
Regards,
Nishanth Menon
