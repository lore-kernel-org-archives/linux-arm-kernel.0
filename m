From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 10 Oct 2018 15:16:28 +0530
Subject: [PATCH 5/9] arm64: dts: sdm845: Add gpu and gmu device nodes
In-Reply-To: <20180827151112.25211-6-jcrouse@codeaurora.org>
References: <20180827151112.25211-1-jcrouse@codeaurora.org>
 <20180827151112.25211-6-jcrouse@codeaurora.org>
Message-ID: <20181010094628.wejfgmvcv6stzoco@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27-08-18, 09:11, Jordan Crouse wrote:
> Add the nodes to describe the Adreno GPU and GMU devices.
> 
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 121 +++++++++++++++++++++++++++
>  1 file changed, 121 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index cdaabeb3c995..10db0ceb3699 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -192,6 +192,59 @@
>  		method = "smc";
>  	};
>  
> +gpu_opp_table: adreno-opp-table {
> +		compatible = "operating-points-v2-qcom-level";
> +
> +		opp-710000000 {
> +			opp-hz = /bits/ 64 <710000000>;
> +			qcom,level = <416>;

What is qcom,level here ? Is it different than the RPM voting thing ?

If not then you need to follow what Rajendra, Niklas are doing as
well. There needs to be a genpd which needs to carry this value and
the gpu's table will have required-opps entry to point to it.

-- 
viresh
