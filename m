From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 5 May 2017 09:56:55 +0800
Subject: [PATCH] ARM: dts: imx: add DH2228FV DAC to Gateworks Ventana
 boards with SPI
In-Reply-To: <1493823894-2107-1-git-send-email-tharvey@gateworks.com>
References: <1493823894-2107-1-git-send-email-tharvey@gateworks.com>
Message-ID: <20170505015653.GT18578@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 03, 2017 at 08:04:54AM -0700, Tim Harvey wrote:
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  arch/arm/boot/dts/imx6qdl-gw52xx.dtsi | 6 ++++++
>  arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 6 ++++++
>  arch/arm/boot/dts/imx6qdl-gw560x.dtsi | 6 ++++++
>  3 files changed, 18 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> index 91991d6..b5c1a8f 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
> @@ -143,6 +143,12 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_ecspi3>;
>  	status = "okay";
> +
> +	spidev0: spidev at 0 {
> +		compatible = "rohm,dh2228fv";

I do not see this is a documented compatible.

Shawn

> +		reg = <0>;
> +		spi-max-frequency = <60000000>;
> +	};
>  };
>  
>  &fec {
> diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> index 968fda9..9d26511 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> @@ -154,6 +154,12 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_ecspi2>;
>  	status = "okay";
> +
> +	spidev0: spidev at 0 {
> +		compatible = "rohm,dh2228fv";
> +		reg = <0>;
> +		spi-max-frequency = <60000000>;
> +	};
>  };
>  
>  &fec {
> diff --git a/arch/arm/boot/dts/imx6qdl-gw560x.dtsi b/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
> index d894dde..bfb63e9 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw560x.dtsi
> @@ -208,6 +208,12 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_ecspi3>;
>  	status = "okay";
> +
> +	spidev0: spidev at 0 {
> +		compatible = "rohm,dh2228fv";
> +		reg = <0>;
> +		spi-max-frequency = <60000000>;
> +	};
>  };
>  
>  &can1 {
> -- 
> 2.7.4
> 
