From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 05 Feb 2018 12:12:53 +0100
Subject: [PATCH 2/2] arm64: dts: fsl: imx8mq-evk: enable watchdog
In-Reply-To: <78318e96c952c5f84644e7035cdefe76f27a9e3c.1517816731.git.baruch@tkos.co.il>
References: <4c7c9104ca95419d22b8df19a69819e194dd3488.1517816731.git.baruch@tkos.co.il>
 <78318e96c952c5f84644e7035cdefe76f27a9e3c.1517816731.git.baruch@tkos.co.il>
Message-ID: <1517829173.3175.11.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 05.02.2018, 09:45 +0200 schrieb Baruch Siach:
> The external nWDOG signal connects to the EVK board reset circuit.
> 
> Tested on the i.MX8MQ EVK rev B3.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
> ?arch/arm64/boot/dts/freescale/imx8mq-evk.dts | 15 +++++++++++++++
> ?1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> index c0e5ee5d6243..757ba226a2fc 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx8mq-evk.dts
> @@ -170,6 +170,13 @@
> ?	status = "okay";
> ?};
> ?
> +&wdog1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_wdog>;
> +	fsl,ext-reset-output;
> +	status = "okay";
> +};
> +
> ?&iomuxc {
> ?	pinctrl_fec1_mdc: fec1mdcgrp {
> ?		pinmux = <MX8MQ_IOMUXC_ENET_MDC_ENET1_MDC>;
> @@ -402,4 +409,12 @@
> ?		bias-pull-up;
> ?		input-schmitt-enable;
> ?	};
> +
> +	pinctrl_wdog: wdoggrp {
> +		fsl,pins = <MX8MQ_IOMUXC_GPIO1_IO02_WDOG1_WDOG_B>;
> +		drive-strength = <6>;
> +		slew-rate = <0>;
> +		bias-pull-up;
> +		input-schmitt-enable;

This might be a plain copy of the downstream pinctrl, but the watchdog
pin being an output, does it really make sense to enable the schmitt-
trigger?

Regards,
Lucas
