From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 27 May 2013 09:44:57 +0200
Subject: [PATCH v3 6/6] ARM: dts: imx6qdl: enable the WEIM NOR
In-Reply-To: <1369389564-13181-7-git-send-email-b32955@freescale.com>
References: <1369389564-13181-1-git-send-email-b32955@freescale.com>
 <1369389564-13181-7-git-send-email-b32955@freescale.com>
Message-ID: <20130527074457.GY20989@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the subject: s/imx6qdl/imx6qdl-sabreauto/

Sascha

On Fri, May 24, 2013 at 05:59:24PM +0800, Huang Shijie wrote:
> Enable the WEIM NOR for imx6q{dl} boards.
> 
> For the pin conflict with SPI NOR, its status is set to "disabled".
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi |   20 ++++++++++++++++++++
>  1 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> index a4466e6..bb0f185 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> @@ -58,3 +58,23 @@
>  	wp-gpios = <&gpio1 13 0>;
>  	status = "okay";
>  };
> +
> +&weim {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_weim_nor_1 &pinctrl_weim_cs_0>;
> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +	ranges = <0 0 0x08000000 0x08000000>;
> +	status = "disabled"; /* pin conflict with SPI NOR */
> +
> +	nor at 0,0 {
> +		compatible = "cfi-flash";
> +		reg = <0 0 0x02000000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		bank-width = <2>;
> +
> +		fsl,weim-cs-timing = <0x00620081 0x00000001 0x1C022000
> +				0x0000C000 0x1404a38e 0x00000000>;
> +	};
> +};
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
