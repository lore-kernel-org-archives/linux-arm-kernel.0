From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 4 Jul 2018 22:45:39 +0200
Subject: [PATCH 1/3] ARM: dts: Add WAN ethernet port to the SQ201
In-Reply-To: <20180704191759.12577-1-linus.walleij@linaro.org>
References: <20180704191759.12577-1-linus.walleij@linaro.org>
Message-ID: <20180704204539.GE23469@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2018 at 09:17:57PM +0200, Linus Walleij wrote:
> This sets up the ethernet interface and PHY for the
> WAN ethernet port which uses a Marvell PHY.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/boot/dts/gemini-sq201.dts | 85 ++++++++++++++++++++++++++++++
>  1 file changed, 85 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/gemini-sq201.dts b/arch/arm/boot/dts/gemini-sq201.dts
> index e5cf9d1a98cd..2706b86e06f1 100644
> --- a/arch/arm/boot/dts/gemini-sq201.dts
> +++ b/arch/arm/boot/dts/gemini-sq201.dts
> @@ -55,6 +55,21 @@
>  		};
>  	};
>  
> +	mdio0: ethernet-phy {

Hi Linus

mdio0: mdio - This node is not an ethernet phy, it is an mdio bus.

> +		compatible = "virtual,mdio-gpio";
> +		/* Uses MDC and MDIO */
> +		gpios = <&gpio0 22 GPIO_ACTIVE_HIGH>, /* MDC */
> +			<&gpio0 21 GPIO_ACTIVE_HIGH>; /* MDIO */
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		/* This is a Marvell 88E1111 ethernet transciever */
> +		phy0: ethernet-phy at 1 {
> +			reg = <1>;
> +			device_type = "ethernet-phy";

device_type is not needed, and not part of the binding in
Documentation/devicetree/bindings/net/phy.txt

	Andrew
