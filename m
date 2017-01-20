From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 20 Jan 2017 11:03:19 +0100
Subject: [PATCH v9 8/8] ARM: dts: stm32: Enable pwm1 and pwm3 for
 stm32f469-disco
In-Reply-To: <1484903709-11650-9-git-send-email-benjamin.gaignard@st.com>
References: <1484903709-11650-1-git-send-email-benjamin.gaignard@st.com>
 <1484903709-11650-9-git-send-email-benjamin.gaignard@st.com>
Message-ID: <77a0e229-1ab0-33f2-edf0-71efd76fdc4a@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benjamin,

On 01/20/2017 10:15 AM, Benjamin Gaignard wrote:
> Define and enable pwm1 and pwm3 for stm32f469 discovery board
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  arch/arm/boot/dts/stm32f469-disco.dts | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
> index 8a163d7..92552d3 100644
> --- a/arch/arm/boot/dts/stm32f469-disco.dts
> +++ b/arch/arm/boot/dts/stm32f469-disco.dts
> @@ -81,3 +81,31 @@
>  &usart3 {
>  	status = "okay";
>  };
> +
> +&timers1 {
> +	status = "okay";
> +
> +	pwm {
> +		pinctrl-0 = <&pwm1_pins>;
> +		pinctrl-names = "default";
> +		status = "okay";
> +	};
> +
> +	timer at 0 {
> +		status = "okay";
> +	};
> +};
> +
> +&timers3 {
> +	status = "okay";
> +
> +	pwm {
> +		pinctrl-0 = <&pwm3_pins>;
> +		pinctrl-names = "default";
> +		status = "okay";
> +	};
> +
> +	timer at 2 {
> +		status = "okay";
> +	};
> +};
>

Acked-by: Alexandre TORGUE <alexandre.torgue@st.com>

Thanks
Alex
