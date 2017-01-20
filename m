From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 20 Jan 2017 17:23:30 +0100
Subject: [PATCH v3 4/9] ARM64: dts: meson-gxbb-nexbox-a95x: add the
 ethernet PHY's reset GPIO
In-Reply-To: <20170120152232.13943-5-martin.blumenstingl@googlemail.com>
References: <20170120132650.9784-1-martin.blumenstingl@googlemail.com>
 <20170120152232.13943-1-martin.blumenstingl@googlemail.com>
 <20170120152232.13943-5-martin.blumenstingl@googlemail.com>
Message-ID: <d9ad0856-60e0-e0d4-6ed1-118bec148e52@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2017 04:22 PM, Martin Blumenstingl wrote:
> This resets the ethernet PHY during boot to get the PHY into a "clean"
> state.
> While here also specify the phy-handle of the ethmac node to make the
> PHY configuration similar to the one we have on GXL devices. This will
> allow us to specify OF-properties for the PHY itself.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
> index 4cbd626a9e88..c7e3ea008566 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
> @@ -164,7 +164,24 @@
>  	status = "okay";
>  	pinctrl-0 = <&eth_rmii_pins>;
>  	pinctrl-names = "default";
> +	phy-handle = <&eth_phy0>;
>  	phy-mode = "rmii";
> +
> +	snps,reset-gpio = <&gpio GPIOZ_14 0>;
> +	snps,reset-delays-us = <0 10000 1000000>;
> +	snps,reset-active-low;
> +
> +	mdio {
> +		compatible = "snps,dwmac-mdio";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		eth_phy0: ethernet-phy at 0 {
> +			compatible = "ethernet-phy-id0243.0c54",
> +				     "ethernet-phy-ieee802.3-c22";
> +			reg = <0>;
> +		};
> +	};
>  };
>  
>  &ir {
> 

On Nexbox A95X (S905) :
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
