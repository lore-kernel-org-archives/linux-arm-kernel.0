From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 1 Feb 2016 22:03:01 +0800
Subject: [PATCH net-next 39/40] ARM: dts: imx6qdl-nitrogen6x: add phy
 interrupt to eliminate polling
In-Reply-To: <1454016364-30985-40-git-send-email-troy.kisky@boundarydevices.com>
References: <1454016364-30985-1-git-send-email-troy.kisky@boundarydevices.com>
 <1454016364-30985-40-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <20160201140301.GK10671@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2016 at 02:26:03PM -0700, Troy Kisky wrote:
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> ---
>  arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> index caeed56..1d42331 100644
> --- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> @@ -288,6 +288,15 @@
>  	interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
>  			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
>  	status = "okay";
> +	phy-handle = <&ethphy>;

Have a new line between properties and sub-node.

> +	mdio {
> +		#address-cells = <0>;
> +		#size-cells = <1>;

Ditto

Shawn

> +		ethphy: ethernet-phy at 6 {
> +			reg = <6>;
> +			interrupts-extended = <&gpio1 28 IRQ_TYPE_LEVEL_LOW>;
> +		};
> +	};
>  };
>  
>  &hdmi {
> @@ -409,6 +418,8 @@
>  				/* Phy reset */
>  				MX6QDL_PAD_ENET_RXD0__GPIO1_IO27	0x000b0
>  				MX6QDL_PAD_GPIO_6__ENET_IRQ		0x000b1
> +				/* ethernet phy interrupt */
> +				MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28	0x1b0b0
>  			>;
>  		};
>  
> -- 
> 2.5.0
> 
> 
