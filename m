From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 7 Apr 2017 20:33:13 +0800
Subject: [PATCH] ARM: dts: imx: ventana: fix DTC warnings
In-Reply-To: <1491252168-7934-1-git-send-email-tharvey@gateworks.com>
References: <1491252168-7934-1-git-send-email-tharvey@gateworks.com>
Message-ID: <20170407123312.GE16503@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 03, 2017 at 01:42:48PM -0700, Tim Harvey wrote:
> Remove the sky2 ethernet device node from the pcie controller which was
> invalid to begin with.
> 
> The original intent was to allow the bootloader to populate the MAC via
> dt but this requires the PCI bus topology to be complete in dt as well
> and as these boards have an expansion connector that topology is dynamic
> and can't be represented here.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
>  arch/arm/boot/dts/imx6q-gw5400-a.dts  | 4 ----
>  arch/arm/boot/dts/imx6qdl-gw53xx.dtsi | 4 ----
>  arch/arm/boot/dts/imx6qdl-gw54xx.dtsi | 4 ----
>  3 files changed, 12 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-gw5400-a.dts b/arch/arm/boot/dts/imx6q-gw5400-a.dts
> index 8e84713..5b066c0 100644
> --- a/arch/arm/boot/dts/imx6q-gw5400-a.dts
> +++ b/arch/arm/boot/dts/imx6q-gw5400-a.dts
> @@ -347,10 +347,6 @@
>  &pcie {
>  	reset-gpio = <&gpio1 29 GPIO_ACTIVE_LOW>;
>  	status = "okay";
> -
> -	eth1: sky2 at 8 { /* MAC/PHY on bus 8 */
> -		compatible = "marvell,sky2";
> -	};

The label 'eth1' is referenced by aliases, and so DTC complains as
below.

ERROR (path_references): Reference to non-existent node or label "eth1".

Please test before submitting.

Shawn

>  };
>  
>  &ssi1 {
> diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
> index a208e7e..420a2f6 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
> @@ -342,10 +342,6 @@
>  	pinctrl-0 = <&pinctrl_pcie>;
>  	reset-gpio = <&gpio1 29 GPIO_ACTIVE_LOW>;
>  	status = "okay";
> -
> -	eth1: sky2 at 8 { /* MAC/PHY on bus 8 */
> -		compatible = "marvell,sky2";
> -	};
>  };
>  
>  &pwm2 {
> diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> index 968fda9..e742153 100644
> --- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
> @@ -379,10 +379,6 @@
>  	pinctrl-0 = <&pinctrl_pcie>;
>  	reset-gpio = <&gpio1 29 GPIO_ACTIVE_LOW>;
>  	status = "okay";
> -
> -	eth1: sky2 at 8 { /* MAC/PHY on bus 8 */
> -		compatible = "marvell,sky2";
> -	};
>  };
>  
>  &pwm1 {
> -- 
> 2.7.4
> 
