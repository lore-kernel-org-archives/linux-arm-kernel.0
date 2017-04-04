From: christopher.spinrath@rwth-aachen.de (Christopher Spinrath)
Date: Tue, 4 Apr 2017 21:42:57 +0200
Subject: [RESEND PATCH] ARM: dts: imx6q-utilite-pro: add hpd gpio
In-Reply-To: <68f4fe14a312455cbb4165d215277359@rwthex-s1-b.rwth-ad.de>
References: <68f4fe14a312455cbb4165d215277359@rwthex-s1-b.rwth-ad.de>
Message-ID: <537764ad7be24b499b05c2daf4040120@rwthex-s1-b.rwth-ad.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 04/04/2017 09:41 PM, christopher.spinrath at rwth-aachen.de wrote:
> From: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
>
> The hpd pin of the second hdmi connector of the Utilite Pro is wired
> up to a gpio pin of the SoC. Reflect this in the device tree.
>
> Signed-off-by: Christopher Spinrath <christopher.spinrath@rwth-aachen.de>
> ---
>
> Hi Shawn,
>
> this was Patch 2/2 of a mini series [1] I sent four weeks ago. The
> drm part (Patch 1/2) has already been merged into drm-next.
>
> Any comments?
>
> Cheers,
> Christopher

Sorry, I forgot the link:

[1] 
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/491829.html

>
>  arch/arm/boot/dts/imx6q-utilite-pro.dts | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx6q-utilite-pro.dts b/arch/arm/boot/dts/imx6q-utilite-pro.dts
> index 69bdd82..d900ad6 100644
> --- a/arch/arm/boot/dts/imx6q-utilite-pro.dts
> +++ b/arch/arm/boot/dts/imx6q-utilite-pro.dts
> @@ -101,9 +101,11 @@
>
>  	hdmi-connector {
>  		compatible = "hdmi-connector";
> -
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_hpd>;
>  		type = "a";
>  		ddc-i2c-bus = <&i2c_dvi_ddc>;
> +		hpd-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
>
>  		port {
>  			hdmi_connector_in: endpoint {
> @@ -209,6 +211,12 @@
>  		>;
>  	};
>
> +	pinctrl_hpd: hpdgrp {
> +		fsl,pins = <
> +			MX6QDL_PAD_GPIO_4__GPIO1_IO04 0x1b0b0
> +		>;
> +	};
> +
>  	pinctrl_i2c1: i2c1grp {
>  		fsl,pins = <
>  			MX6QDL_PAD_EIM_D21__I2C1_SCL 0x4001b8b1
>
