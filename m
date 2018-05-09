From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 9 May 2018 14:41:14 -0700
Subject: [PATCH] arm64: dts: sdm845: Add command DB node
In-Reply-To: <20180509213439.165623-1-dianders@chromium.org>
References: <20180509213439.165623-1-dianders@chromium.org>
Message-ID: <20180509214114.GH14924@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 09 May 14:34 PDT 2018, Douglas Anderson wrote:

> Add command DB node based on the bindings example.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index 486ace9a9e8b..7b5f2b3982a3 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -21,6 +21,18 @@
>  		reg = <0 0x80000000 0 0>;
>  	};
>  
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		reserved-memory at 85fe0000 {
> +			compatible = "qcom,cmd-db";
> +			reg = <0x0 0x85fe0000 0x0 0x20000>;
> +			no-map;
> +		};
> +	};
> +
>  	cpus {
>  		#address-cells = <2>;
>  		#size-cells = <0>;
> -- 
> 2.17.0.441.gb46fe60e1d-goog
> 
