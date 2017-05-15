From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 15 May 2017 10:17:06 +0200
Subject: [PATCH v2 15/18] arm64: dts: meson-gxl: Fix node order
In-Reply-To: <20170513143337.14278-16-afaerber@suse.de>
References: <20170513143337.14278-1-afaerber@suse.de>
 <20170513143337.14278-16-afaerber@suse.de>
Message-ID: <21f47a71-a3a2-c0ae-46b1-87902f82e93e@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2017 04:33 PM, Andreas F?rber wrote:
> Sort nodes referenced by label alphabetically.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v1 -> v2:
>  * Rebased (new nodes added)
>  
>  arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 72 +++++++++++++++---------------
>  1 file changed, 36 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> index d8e096dff10a..3efad5f0bca4 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
> @@ -193,6 +193,42 @@
>  	};
>  };
>  
> +&hdmi_tx {
> +	compatible = "amlogic,meson-gxl-dw-hdmi", "amlogic,meson-gx-dw-hdmi";
> +	resets = <&reset RESET_HDMITX_CAPB3>,
> +		 <&reset RESET_HDMI_SYSTEM_RESET>,
> +		 <&reset RESET_HDMI_TX>;
> +	reset-names = "hdmitx_apb", "hdmitx", "hdmitx_phy";
> +	clocks = <&clkc CLKID_HDMI_PCLK>,
> +		 <&clkc CLKID_CLK81>,
> +		 <&clkc CLKID_GCLK_VENCI_INT0>;
> +	clock-names = "isfr", "iahb", "venci";
> +};
> +
> +&hiubus {
> +	clkc: clock-controller at 0 {
> +		compatible = "amlogic,gxl-clkc", "amlogic,gxbb-clkc";
> +		#clock-cells = <1>;
> +		reg = <0x0 0x0 0x0 0x3db>;
> +	};
> +};
> +
> +&i2c_A {
> +	clocks = <&clkc CLKID_I2C>;
> +};
> +
> +&i2c_AO {
> +	clocks = <&clkc CLKID_AO_I2C>;
> +};
> +
> +&i2c_B {
> +	clocks = <&clkc CLKID_I2C>;
> +};
> +
> +&i2c_C {
> +	clocks = <&clkc CLKID_I2C>;
> +};
> +
>  &periphs {
>  	pinctrl_periphs: pinctrl at 4b0 {
>  		compatible = "amlogic,meson-gxl-periphs-pinctrl";
> @@ -501,30 +537,6 @@
>  	};
>  };
>  
> -&hiubus {
> -	clkc: clock-controller at 0 {
> -		compatible = "amlogic,gxl-clkc", "amlogic,gxbb-clkc";
> -		#clock-cells = <1>;
> -		reg = <0x0 0x0 0x0 0x3db>;
> -	};
> -};
> -
> -&i2c_A {
> -	clocks = <&clkc CLKID_I2C>;
> -};
> -
> -&i2c_AO {
> -	clocks = <&clkc CLKID_AO_I2C>;
> -};
> -
> -&i2c_B {
> -	clocks = <&clkc CLKID_I2C>;
> -};
> -
> -&i2c_C {
> -	clocks = <&clkc CLKID_I2C>;
> -};
> -
>  &saradc {
>  	compatible = "amlogic,meson-gxl-saradc", "amlogic,meson-saradc";
>  	clocks = <&xtal>,
> @@ -563,15 +575,3 @@
>  &vpu {
>  	compatible = "amlogic,meson-gxl-vpu", "amlogic,meson-gx-vpu";
>  };
> -
> -&hdmi_tx {
> -	compatible = "amlogic,meson-gxl-dw-hdmi", "amlogic,meson-gx-dw-hdmi";
> -	resets = <&reset RESET_HDMITX_CAPB3>,
> -		 <&reset RESET_HDMI_SYSTEM_RESET>,
> -		 <&reset RESET_HDMI_TX>;
> -	reset-names = "hdmitx_apb", "hdmitx", "hdmitx_phy";
> -	clocks = <&clkc CLKID_HDMI_PCLK>,
> -		 <&clkc CLKID_CLK81>,
> -		 <&clkc CLKID_GCLK_VENCI_INT0>;
> -	clock-names = "isfr", "iahb", "venci";
> -};
> 

Hi Andreas,

Like a previous attempt, I'm not OK with such rework since it will break bisect and add complexity for new patches handling.

The order is not alphabetically ordered, live with it.

Neil
