From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Thu, 19 May 2016 10:11:21 +0530
Subject: [PATCH 2/8] ARM: dts: am33xx: Move to operating-points-v2 table
 and ti-cpufreq driver
In-Reply-To: <f30e0313514cdbb9c3b0a83bbb96f05f2e179775.1463606963.git.d-gerlach@ti.com>
References: <cover.1463606963.git.d-gerlach@ti.com>
 <f30e0313514cdbb9c3b0a83bbb96f05f2e179775.1463606963.git.d-gerlach@ti.com>
Message-ID: <20160519044121.GD32001@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18-05-16, 18:36, Dave Gerlach wrote:
> +	cpu0_opp_table: opp_table0 {
> +		compatible = "operating-points-v2";
> +
> +		/*
> +		 * The three following nodes are marked with opp-suspend
> +		 * because the can not be enabled simultaneously on a
> +		 * single SoC.
> +		 */
> +		opp50 at 300000000 {
> +			opp-hz = /bits/ 64 <300000000>;
> +			opp-microvolt = <950000 931000 969000>;
> +			opp-supported-hw = <0x06 0x0010>;

Is there any place in either of the patchsets you have sent, that details the
usage of the above two values? I mean which defines, what is 0x6 and what is
0x1 ?

-- 
viresh
