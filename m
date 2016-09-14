From: patrice.chotard@st.com (Patrice Chotard)
Date: Wed, 14 Sep 2016 14:00:11 +0200
Subject: [PATCH v9 10/19] ARM: DT: STiH407: Add i2s_out pinctrl
 configuration
In-Reply-To: <1473081421-16555-11-git-send-email-peter.griffin@linaro.org>
References: <1473081421-16555-1-git-send-email-peter.griffin@linaro.org>
 <1473081421-16555-11-git-send-email-peter.griffin@linaro.org>
Message-ID: <2784abd2-59ed-33d1-60d8-e7b9e4e777a6@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter

On 09/05/2016 03:16 PM, Peter Griffin wrote:
> This patch adds the pinctrl config for the i2s_out pins
> used by the uniperif player IP.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
>  arch/arm/boot/dts/stih407-pinctrl.dtsi | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> index a538ae5..0fb5c8a 100644
> --- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
> @@ -1067,6 +1067,29 @@
>  				};
>  			};
>  
> +			i2s_out {
> +				pinctrl_i2s_8ch_out: i2s_8ch_out{
> +					st,pins {
> +						mclk = <&pio33 5 ALT1 OUT>;
> +						lrclk = <&pio33 7 ALT1 OUT>;
> +						sclk = <&pio33 6 ALT1 OUT>;
> +						data0 = <&pio33 4 ALT1 OUT>;
> +						data1 = <&pio34 0 ALT1 OUT>;
> +						data2 = <&pio34 1 ALT1 OUT>;
> +						data3 = <&pio34 2 ALT1 OUT>;
> +					};
> +				};
> +
> +				pinctrl_i2s_2ch_out: i2s_2ch_out{
> +					st,pins {
> +						mclk = <&pio33 5 ALT1 OUT>;
> +						lrclk = <&pio33 7 ALT1 OUT>;
> +						sclk = <&pio33 6 ALT1 OUT>;
> +						data0 = <&pio33 4 ALT1 OUT>;
> +					};
> +				};
> +			};
> +
>  			serial3 {
>  				pinctrl_serial3: serial3-0 {
>  					st,pins {
> 


Applied for STi next

Thanks
