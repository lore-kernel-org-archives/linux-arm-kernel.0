From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 08 Feb 2016 11:28:22 +0100
Subject: [PATCH v2 04/10] ARM64: dts: rockchip: Add GMAC to GeekBox
In-Reply-To: <1454897859-7601-5-git-send-email-afaerber@suse.de>
References: <1454897859-7601-1-git-send-email-afaerber@suse.de>
 <1454897859-7601-5-git-send-email-afaerber@suse.de>
Message-ID: <5875277.Y7zJ7W9GkY@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andreas,

Am Montag, 8. Februar 2016, 03:17:33 schrieb Andreas F?rber:
> Signed-off-by: Andreas F?rber <afaerber@suse.de>

is there some special reason that gmac, emmc, ir, etc are in separate 
patches? I guess I'll just fold them into the core patch otherwise.


Heiko

> ---
>  v2: New
> 
>  arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts | 20 ++++++++++++++++++++
> 1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
> b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts index
> bc91d39758ab..a8dcf3c2b0c1 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
> @@ -56,6 +56,13 @@
>  		reg = <0x0 0x0 0x0 0x80000000>;
>  	};
> 
> +	ext_gmac: gmac-clk {
> +		compatible = "fixed-clock";
> +		clock-frequency = <125000000>;
> +		clock-output-names = "ext_gmac";
> +		#clock-cells = <0>;
> +	};
> +
>  	leds: gpio-leds {
>  		compatible = "gpio-leds";
> 
> @@ -82,6 +89,19 @@
>  	};
>  };
> 
> +&gmac {
> +	status = "okay";
> +	phy-supply = <&vcc_lan>;
> +	phy-mode = "rgmii";
> +	clock_in_out = "input";
> +	assigned-clocks = <&cru SCLK_MAC>;
> +	assigned-clock-parents = <&ext_gmac>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmii_pins>;
> +	tx_delay = <0x30>;
> +	rx_delay = <0x10>;
> +};
> +
>  &i2c0 {
>  	status = "okay";
