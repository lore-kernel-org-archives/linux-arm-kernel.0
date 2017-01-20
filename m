From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 20 Jan 2017 17:23:22 +0100
Subject: [PATCH v3 1/9] ARM64: dts: meson-gxbb-odroidc2: add the ethernet
 PHY's reset GPIO
In-Reply-To: <20170120152232.13943-2-martin.blumenstingl@googlemail.com>
References: <20170120132650.9784-1-martin.blumenstingl@googlemail.com>
 <20170120152232.13943-1-martin.blumenstingl@googlemail.com>
 <20170120152232.13943-2-martin.blumenstingl@googlemail.com>
Message-ID: <3c5b07ce-78ff-edbc-adce-9ed9e70c05b4@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2017 04:22 PM, Martin Blumenstingl wrote:
> This resets the ethernet PHY during boot to get the PHY into a "clean"
> state. While here also explicitly specify the phy-mode instead of
> relying on the default-value from meson-gx.dtsi.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> index c59403adb387..6b5579522587 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> @@ -152,6 +152,11 @@
>  	pinctrl-0 = <&eth_rgmii_pins>;
>  	pinctrl-names = "default";
>  	phy-handle = <&eth_phy0>;
> +	phy-mode = "rgmii";
> +
> +	snps,reset-gpio = <&gpio GPIOZ_14 0>;
> +	snps,reset-delays-us = <0 10000 1000000>;
> +	snps,reset-active-low;
>  
>  	mdio {
>  		compatible = "snps,dwmac-mdio";
> 

On Odroid-c2 rev 0.2 :
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
