From: rabeeh@solid-run.com (Rabeeh Khoury)
Date: Mon, 23 Mar 2015 20:06:27 +0200
Subject: [PATCH 2/2] ARM: dts: hummingboard: Setup pwm lines
In-Reply-To: <E1YSWZL-0002Aw-B5@rmk-PC.arm.linux.org.uk>
References: <E1YSWZL-0002Aw-B5@rmk-PC.arm.linux.org.uk>
Message-ID: <55105623.1010804@solid-run.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/02/2015 10:03 PM, Russell King wrote:
> From: Rabeeh Khoury <rabeeh@solid-run.com>
>
> Setup pwm lines as follows -
> pwm1: In case HummingBoard base carrier; this pin drives through a serial
>        capacitor the mono out of the audio jack.
>        In case HummingBoard pro the this pad can be reached by wiring to
>        C8 capacitors on the board.
> pwm2: Setup pwm2 on gpio-1 but leave the default function of the iopad as
>        a gpio.
>        The user can change the io pad mux in user space and therefore use
>        this function on gpio-1 (pin number 7 on the 26 pin header).
> pwm3,pwm4: unused
>
> Signed-off-by: Rabeeh Khoury <rabeeh@solid-run.com>
> [tweaked alias for pwm pinctrl group --rmk]
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> For acks please.
Ack.
>
>   arch/arm/boot/dts/imx6qdl-hummingboard.dtsi | 23 +++++++++++++++++++++++
>   1 file changed, 23 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
> index 93588c987d2c..c0dc5948fa3c 100644
> --- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
> @@ -164,6 +164,10 @@
>   			>;
>   		};
>   
> +		pinctrl_hummingboard_pwm1: pwm1grp {
> +			fsl,pins = <MX6QDL_PAD_DISP0_DAT8__PWM1_OUT 0x1b0b1>;
> +		};
> +
>   		pinctrl_hummingboard_spdif: hummingboard-spdif {
>   			fsl,pins = <MX6QDL_PAD_GPIO_17__SPDIF_OUT 0x13091>;
>   		};
> @@ -203,6 +207,25 @@
>   	};
>   };
>   
> +&pwm1 {
> +	 pinctrl-names = "default";
> +	 pinctrl-0 = <&pinctrl_hummingboard_pwm1>;
> +	 status = "okay";
> +};
> +
> +&pwm2 {
> +	 pinctrl-names = "default";
> +	 status = "okay";
> +};
> +
> +&pwm3 {
> +	status = "disabled";
> +};
> +
> +&pwm4 {
> +	status = "disabled";
> +};
> +
>   &spdif {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pinctrl_hummingboard_spdif>;
