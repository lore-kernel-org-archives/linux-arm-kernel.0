From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 10 Oct 2017 23:09:37 -0700
Subject: [PATCH 3/3] arm64: dts: apq8096-db820c: always enable regulator
 LS expansion
In-Reply-To: <20170814113420.30866-3-srinivas.kandagatla@linaro.org>
References: <20170814113420.30866-1-srinivas.kandagatla@linaro.org>
 <20170814113420.30866-3-srinivas.kandagatla@linaro.org>
Message-ID: <20171011060937.GN1165@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 14 Aug 04:34 PDT 2017, srinivas.kandagatla at linaro.org wrote:

> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> 1.8v regulator on LS expansion should be left as always to comply
> with 96boards spec.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> index 18c61693529e..0c10bbe55317 100644
> --- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> +++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dtsi
> @@ -189,9 +189,15 @@
>  					regulator-min-microvolt = <1300000>;
>  					regulator-max-microvolt = <1300000>;
>  				};
> +
> +				/**
> +				 * 1.8v required on LS expansion
> +				 * for mezzanine boards
> +				 */
>  				s4 {
>  					regulator-min-microvolt = <1800000>;
>  					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
>  				};
>  				s5 {
>  					regulator-min-microvolt = <2150000>;
> -- 
> 2.11.0
> 
