From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 18 Oct 2017 18:36:53 +0200
Subject: [PATCH v7 02/10] arm: dts: sunxi: Restore EMAC changes
In-Reply-To: <20171018114458.17891-3-clabbe.montjoie@gmail.com>
References: <20171018114458.17891-1-clabbe.montjoie@gmail.com>
 <20171018114458.17891-3-clabbe.montjoie@gmail.com>
Message-ID: <20171018163653.GC15371@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> index e1dba9ffa94b..f2292deaa590 100644
> --- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
> @@ -52,6 +52,7 @@
>  	compatible = "sinovoip,bpi-m2-plus", "allwinner,sun8i-h3";
>  
>  	aliases {
> +		ethernet0 = &emac;
>  		serial0 = &uart0;
>  		serial1 = &uart1;
>  	};
> @@ -111,6 +112,24 @@
>  	status = "okay";
>  };
>  
> +&emac {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emac_rgmii_pins>;
> +	phy-supply = <&reg_gmac_3v3>;
> +	phy-handle = <&ext_rgmii_phy>;
> +	phy-mode = "rgmii";
> +
> +	allwinner,leds-active-low;
> +	status = "okay";
> +};
> +
> +&external_mdio {
> +	ext_rgmii_phy: ethernet-phy at 1 {
> +		compatible = "ethernet-phy-ieee802.3-c22";
> +		reg = <0>;
> +	};

The reg value should match the @ value.

    Andrew
