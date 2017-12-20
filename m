From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 20 Dec 2017 08:56:14 +0530
Subject: [PATCH v5 15/15] devicetree: bindings: Document qcom,pvs
In-Reply-To: <1513698900-10638-16-git-send-email-sricharan@codeaurora.org>
References: <1513698900-10638-1-git-send-email-sricharan@codeaurora.org>
 <1513698900-10638-16-git-send-email-sricharan@codeaurora.org>
Message-ID: <20171220032614.GQ19815@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19-12-17, 21:25, Sricharan R wrote:
> +	cpu at 0 {
> +		compatible = "qcom,krait";
> +		enable-method = "qcom,kpss-acc-v1";
> +		device_type = "cpu";
> +		reg = <0>;
> +		qcom,acc = <&acc0>;
> +		qcom,saw = <&saw0>;
> +		clocks = <&kraitcc 0>;
> +		clock-names = "cpu";
> +		cpu-supply = <&smb208_s2a>;
> +		operating-points-v2 = <&cpu_opp_table>;
> +	};
> +
> +	qcom,pvs {
> +		qcom,pvs-format-a;
> +	};

Not sure what Rob is going to say on that :)

> +
> +
> +	cpu_opp_table: opp_table {
> +		compatible = "operating-points-v2";
> +
> +		/*
> +		 * Missing opp-shared property means CPUs switch DVFS states
> +		 * independently.
> +		 */
> +
> +		opp-1400000000 {
> +			opp-hz = /bits/ 64 <1400000000>;
> +			opp-microvolt-speed0-pvs0-v0 = <1250000>;

Why speed0 and v0 in all the names ?

-- 
viresh
