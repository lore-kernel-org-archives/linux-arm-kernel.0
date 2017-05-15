From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 15 May 2017 10:17:08 +0200
Subject: [PATCH v2 13/18] arm64: dts: meson-gxbb-nexbox-a95x: Fix node
 order
In-Reply-To: <20170513143337.14278-14-afaerber@suse.de>
References: <20170513143337.14278-1-afaerber@suse.de>
 <20170513143337.14278-14-afaerber@suse.de>
Message-ID: <22302468-9c71-18f2-0e2f-1ab7764a8e91@baylibre.com>
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
>  .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    | 52 +++++++++++-----------
>  1 file changed, 26 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
> index 87198eafb04b..a1078b3e1c76 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
> @@ -165,10 +165,10 @@
>  	};
>  };
>  
> -&uart_AO {
> -	status = "okay";
> -	pinctrl-0 = <&uart_ao_a_pins>;
> -	pinctrl-names = "default";
> +&cvbs_vdac_port {
> +	cvbs_vdac_out: endpoint {
> +		remote-endpoint = <&cvbs_connector_in>;
> +	};
>  };
>  
>  &ethmac {
> @@ -195,12 +195,32 @@
>  	};
>  };
>  
> +&hdmi_tx {
> +	status = "okay";
> +	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
> +	pinctrl-names = "default";
> +};
> +
> +&hdmi_tx_tmds_port {
> +	hdmi_tx_tmds_out: endpoint {
> +		remote-endpoint = <&hdmi_connector_in>;
> +	};
> +};
> +
>  &ir {
>  	status = "okay";
>  	pinctrl-0 = <&remote_input_ao_pins>;
>  	pinctrl-names = "default";
>  };
>  
> +&pwm_ef {
> +	status = "okay";
> +	pinctrl-0 = <&pwm_e_pins>;
> +	pinctrl-names = "default";
> +	clocks = <&clkc CLKID_FCLK_DIV4>;
> +	clock-names = "clkin0";
> +};
> +
>  /* Wireless SDIO Module */
>  &sd_emmc_a {
>  	status = "okay";
> @@ -260,28 +280,8 @@
>  	vqmmc-supply = <&vddio_boot>;
>  };
>  
> -&pwm_ef {
> -	status = "okay";
> -	pinctrl-0 = <&pwm_e_pins>;
> -	pinctrl-names = "default";
> -	clocks = <&clkc CLKID_FCLK_DIV4>;
> -	clock-names = "clkin0";
> -};
> -
> -&cvbs_vdac_port {
> -	cvbs_vdac_out: endpoint {
> -		remote-endpoint = <&cvbs_connector_in>;
> -	};
> -};
> -
> -&hdmi_tx {
> +&uart_AO {
>  	status = "okay";
> -	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
> +	pinctrl-0 = <&uart_ao_a_pins>;
>  	pinctrl-names = "default";
>  };
> -
> -&hdmi_tx_tmds_port {
> -	hdmi_tx_tmds_out: endpoint {
> -		remote-endpoint = <&hdmi_connector_in>;
> -	};
> -};
> 

Hi Andreas,

Like a previous attempt, I'm not OK with such rework since it will break bisect and add complexity for new patches handling.

The order is not alphabetically ordered, live with it.

Neil
