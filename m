From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 06 Dec 2017 12:07:13 -0800
Subject: [PATCH] ARM64: dts: meson-axg: add ethernet mac controller
In-Reply-To: <20171113080155.2463-1-yixun.lan@amlogic.com> (Yixun Lan's
 message of "Mon, 13 Nov 2017 16:01:55 +0800")
References: <20171113080155.2463-1-yixun.lan@amlogic.com>
Message-ID: <7hy3mfr572.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Yixun Lan <yixun.lan@amlogic.com> writes:

> Add DT info for the stmmac ethernet MAC which found in
> the Amlogic's Meson-AXG SoC, also describe the ethernet
> pinctrl & clock information here.
>
> This is tested in the S400 dev board which use a RTL8211F PHY,
> and the pins connect to the 'eth_rgmii_y_pins' group.
>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

This doesn't apply cleanly to mainline.  Are there some dependencies
here that I'm not aware of?

Also...

> ---
>  arch/arm64/boot/dts/amlogic/meson-axg-s400.dts |  7 ++++
>  arch/arm64/boot/dts/amlogic/meson-axg.dtsi     | 53 ++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> index 9eb6aaee155d..7b39a9fe2b0f 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
> @@ -21,3 +21,10 @@
>  	status = "okay";
>  };
>  
> +&ethmac {
> +	status = "okay";
> +	phy-mode = "rgmii";
> +
> +	pinctrl-0 = <&eth_rgmii_y_pins>;
> +	pinctrl-names = "default";
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index 65945c6c8b65..57faaa9d8013 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -157,6 +157,19 @@
>  			#address-cells = <0>;
>  		};
>  
> +		ethmac: ethernet at ff3f0000 {
> +			compatible = "amlogic,meson-axg-dwmac", "amlogic,meson-gxbb-dwmac", "snps,dwmac";

The new "meson-axg-dwmac" is not documented in the binding.  Can you add
that?

Kevin
