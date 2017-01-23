From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 23 Jan 2017 09:58:43 +0100
Subject: [PATCH 18/18] ARM64: dts: meson-gx-p23x-q20x: Reorder nodes
In-Reply-To: <20170120222118.21476-19-afaerber@suse.de>
References: <20170120222118.21476-1-afaerber@suse.de>
 <20170120222118.21476-19-afaerber@suse.de>
Message-ID: <6ae411af-8561-df9a-f211-71a2c67cc2a9@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2017 11:21 PM, Andreas F?rber wrote:
> Sort nodes referenced by label alphabetically.
> 
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi | 24 +++++++++++-----------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
> index 419c46cc64e4..cfc26a2a3a90 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
> @@ -100,11 +100,8 @@
>  	};
>  };
>  
> -/* This UART is brought out to the DB9 connector */
> -&uart_AO {
> +&ethmac {
>  	status = "okay";
> -	pinctrl-0 = <&uart_ao_a_pins>;
> -	pinctrl-names = "default";
>  };
>  
>  &ir {
> @@ -113,6 +110,14 @@
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
> @@ -177,14 +182,9 @@
>  	vqmmc-supply = <&vddio_boot>;
>  };
>  
> -&pwm_ef {
> +/* This UART is brought out to the DB9 connector */
> +&uart_AO {
>  	status = "okay";
> -	pinctrl-0 = <&pwm_e_pins>;
> +	pinctrl-0 = <&uart_ao_a_pins>;
>  	pinctrl-names = "default";
> -	clocks = <&clkc CLKID_FCLK_DIV4>;
> -	clock-names = "clkin0";
> -};
> -
> -&ethmac {
> -	status = "okay";
>  };
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
