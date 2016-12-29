From: andy.gross@linaro.org (Andy Gross)
Date: Wed, 28 Dec 2016 21:14:32 -0600
Subject: [1/5] ARM: dts: qcom: apq8064: Add missing scm clock
In-Reply-To: <20161221114939.19973-1-bjorn.andersson@linaro.org>
References: <20161221114939.19973-1-bjorn.andersson@linaro.org>
Message-ID: <20161229031432.GA18506@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2016 at 03:49:35AM -0800, Bjorn Andersson wrote:
> As per the device tree binding the apq8064 scm node requires the core
> clock to be specified, so add this.
> 
> Cc: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  arch/arm/boot/dts/qcom-apq8064.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
> index 268bd470c865..78bf155a52f3 100644
> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
> @@ -303,6 +303,9 @@
>  	firmware {
>  		scm {
>  			compatible = "qcom,scm-apq8064";
> +
> +			clocks = <&gcc CE3_CORE_CLK>;
> +			clock-names = "core";

Isn't this supposed to be the DFAB clk?  The RPM one?  I think that's why we let
the clock just fall through optionally before the recent changes that broke
this.

Regards,

Andy
