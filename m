From: mka@chromium.org (Matthias Kaehlcke)
Date: Tue, 17 Jul 2018 14:11:28 -0700
Subject: [PATCH v4 2/3] arm64: dts: qcom: pm8998: Add spmi-temp-alarm node
In-Reply-To: <20180717210815.245639-2-mka@chromium.org>
References: <20180717210815.245639-1-mka@chromium.org>
 <20180717210815.245639-2-mka@chromium.org>
Message-ID: <20180717211128.GB129942@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 02:08:14PM -0700, Matthias Kaehlcke wrote:
> This adds the spmi-temp-alarm node to pm8998 based on the examples in the
> bindings.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

I should have added:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

> ---
> Changes in v4:
> - none
> 
> Changes in v3:
> - changed node name from 'qcom,temp-alarm at 2400' to 'temp-alarm at 2400'
> - removed controller register length value from 'reg'
> 
> Changes in v2:
> - none
> ---
>  arch/arm64/boot/dts/qcom/pm8998.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> index 92bed1e7d4bb..7eea94701b23 100644
> --- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
> @@ -11,6 +11,13 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> +		pm8998_temp: temp-alarm at 2400 {
> +			compatible = "qcom,spmi-temp-alarm";
> +			reg = <0x2400>;
> +			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
> +			#thermal-sensor-cells = <0>;
> +		};
> +
>  		pm8998_gpio: gpios at c000 {
>  			compatible = "qcom,pm8998-gpio", "qcom,spmi-gpio";
>  			reg = <0xc000>;
