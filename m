From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 23 Jan 2017 09:58:30 +0100
Subject: [PATCH 17/18] ARM64: dts: meson-gxm-nexbox-a1: Reorder nodes
In-Reply-To: <20170120222118.21476-18-afaerber@suse.de>
References: <20170120222118.21476-1-afaerber@suse.de>
 <20170120222118.21476-18-afaerber@suse.de>
Message-ID: <5d11845f-32c7-e39a-664c-68f28e3d2f3b@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2017 11:21 PM, Andreas F?rber wrote:
> Sort nodes referenced by label alphabetically.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts | 58 +++++++++++-----------
>  1 file changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
> index 439060652689..804e8de80f37 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
> @@ -102,10 +102,35 @@
>  	};
>  };
>  
> -&uart_AO {
> +&cvbs_vdac_port {
> +	cvbs_vdac_out: endpoint {
> +		remote-endpoint = <&cvbs_connector_in>;
> +	};
> +};
> +
> +&ethmac {
>  	status = "okay";
> -	pinctrl-0 = <&uart_ao_a_pins>;
> +
> +	pinctrl-0 = <&eth_pins>;
>  	pinctrl-names = "default";
> +
> +	/* Select external PHY by default */
> +	phy-handle = <&external_phy>;
> +
> +	snps,reset-gpio = <&gpio GPIOZ_14 0>;
> +	snps,reset-delays-us = <0 10000 1000000>;
> +	snps,reset-active-low;
> +
> +	/* External PHY is in RGMII */
> +	phy-mode = "rgmii";
> +};
> +
> +&external_mdio {
> +	external_phy: ethernet-phy at 0 {
> +		compatible = "ethernet-phy-id001c.c916", "ethernet-phy-ieee802.3-c22";
> +		reg = <0>;
> +		max-speed = <1000>;
> +	};
>  };
>  
>  &ir {
> @@ -152,33 +177,8 @@
>  	vqmmc-supply = <&vddio_boot>;
>  };
>  
> -&ethmac {
> +&uart_AO {
>  	status = "okay";
> -
> -	pinctrl-0 = <&eth_pins>;
> +	pinctrl-0 = <&uart_ao_a_pins>;
>  	pinctrl-names = "default";
> -
> -	/* Select external PHY by default */
> -	phy-handle = <&external_phy>;
> -
> -	snps,reset-gpio = <&gpio GPIOZ_14 0>;
> -	snps,reset-delays-us = <0 10000 1000000>;
> -	snps,reset-active-low;
> -
> -	/* External PHY is in RGMII */
> -	phy-mode = "rgmii";
> -};
> -
> -&external_mdio {
> -	external_phy: ethernet-phy at 0 {
> -		compatible = "ethernet-phy-id001c.c916", "ethernet-phy-ieee802.3-c22";
> -		reg = <0>;
> -		max-speed = <1000>;
> -	};
> -};
> -
> -&cvbs_vdac_port {
> -	cvbs_vdac_out: endpoint {
> -		remote-endpoint = <&cvbs_connector_in>;
> -	};
>  };
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
