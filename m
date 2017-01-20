From: alexandre.torgue@st.com (Alexandre Torgue)
Date: Fri, 20 Jan 2017 11:19:08 +0100
Subject: [PATCH 7/7] ARM: dts: stm32: Enable pwm1 and pwm3 for
 stm32f469-eval
In-Reply-To: <1484832854-6314-8-git-send-email-fabrice.gasnier@st.com>
References: <1484832854-6314-1-git-send-email-fabrice.gasnier@st.com>
 <1484832854-6314-8-git-send-email-fabrice.gasnier@st.com>
Message-ID: <451b28a0-6cf3-d75a-59a2-d4e2f8a7b373@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabrice


On 01/19/2017 02:34 PM, Fabrice Gasnier wrote:
> Define and enable pwm1 and pwm3, timers1 & 3 trigger outputs on
> stm32f469-eval board.
>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---

Typo issue in commit header (stm32f469 --> stm32f429)


>  arch/arm/boot/dts/stm32429i-eval.dts | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32429i-eval.dts b/arch/arm/boot/dts/stm32429i-eval.dts
> index 2181220..892100f 100644
> --- a/arch/arm/boot/dts/stm32429i-eval.dts
> +++ b/arch/arm/boot/dts/stm32429i-eval.dts
> @@ -171,3 +171,31 @@
>  	pinctrl-names = "default";
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
