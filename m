From: david@lechnology.com (David Lechner)
Date: Tue, 25 Oct 2016 14:29:59 -0500
Subject: [PATCH 4/4] ARM: dts: da850: Add the usb otg device node
In-Reply-To: <1477406345-27192-5-git-send-email-abailon@baylibre.com>
References: <1477406345-27192-1-git-send-email-abailon@baylibre.com>
 <1477406345-27192-5-git-send-email-abailon@baylibre.com>
Message-ID: <6768df59-153e-e841-6894-dbab337f71d8@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/25/2016 09:39 AM, Alexandre Bailon wrote:
> This adds the device tree node for the usb otg
> controller present in the da850 family of SoC's.
> This also enables the otg usb controller for the lcdk board.
>
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  arch/arm/boot/dts/da850-lcdk.dts |  8 ++++++++
>  arch/arm/boot/dts/da850.dtsi     | 15 +++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
> index 7b8ab21..dca9735 100644
> --- a/arch/arm/boot/dts/da850-lcdk.dts
> +++ b/arch/arm/boot/dts/da850-lcdk.dts
> @@ -158,6 +158,14 @@
>  	rx-num-evt = <32>;
>  };
>
> +&usb_phy {
> +	status = "okay";
> +	};
> +
> +&usb20 {
> +	status = "okay";
> +};
> +
>  &aemif {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&nand_pins>;
> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> index f79e1b9..b11d395 100644
> --- a/arch/arm/boot/dts/da850.dtsi
> +++ b/arch/arm/boot/dts/da850.dtsi
> @@ -372,6 +372,21 @@
>  					>;
>  			status = "disabled";
>  		};
> +		usb_phy: usb-phy {
> +			compatible = "ti,da830-usb-phy";
> +			#phy-cells = <1>;
> +			status = "disabled";
> +		};
> +		usb20: usb20 at 200000 {

This should be usb0: usb at 200000

> +			compatible = "ti,da830-musb";
> +			reg = <0x200000 0x10000>;
> +			interrupts = <58>;
> +			interrupt-names = "mc";
> +			dr_mode = "otg";
> +			phys = <&usb_phy 0>;
> +			phy-names = "usb-phy";
> +			status = "disabled";
> +		};
>  		gpio: gpio at 226000 {
>  			compatible = "ti,dm6441-gpio";
>  			gpio-controller;
>
