From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 23 Jan 2017 09:57:25 +0100
Subject: [PATCH 13/18] ARM64: dts: meson-gxbb-nexbox-a95x: Reorder nodes
In-Reply-To: <20170120222118.21476-14-afaerber@suse.de>
References: <20170120222118.21476-1-afaerber@suse.de>
 <20170120222118.21476-14-afaerber@suse.de>
Message-ID: <6cb7edb5-533d-12ec-3018-edcecd2f46a0@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2017 11:21 PM, Andreas F?rber wrote:
> Sort nodes referenced by label alphabetically.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    | 28 +++++++++++-----------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
> index 4cbd626a9e88..e642bfd5eec5 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
> @@ -154,10 +154,10 @@
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
> @@ -173,6 +173,14 @@
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
> @@ -232,16 +240,8 @@
>  	vqmmc-supply = <&vddio_boot>;
>  };
>  
> -&pwm_ef {
> +&uart_AO {
>  	status = "okay";
> -	pinctrl-0 = <&pwm_e_pins>;
> +	pinctrl-0 = <&uart_ao_a_pins>;
>  	pinctrl-names = "default";
> -	clocks = <&clkc CLKID_FCLK_DIV4>;
> -	clock-names = "clkin0";
> -};
> -
> -&cvbs_vdac_port {
> -	cvbs_vdac_out: endpoint {
> -		remote-endpoint = <&cvbs_connector_in>;
> -	};
>  };
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
