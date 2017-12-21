From: tony@atomide.com (Tony Lindgren)
Date: Thu, 21 Dec 2017 06:53:22 -0800
Subject: [PATCH v5 4/5] DTS: gta04: add uart2 child node for w2sg00x4
In-Reply-To: <1b1c7a8319eaf61a46eebd7a366ea745b7a54634.1512114577.git.hns@goldelico.com>
References: <cover.1512114576.git.hns@goldelico.com>
 <1b1c7a8319eaf61a46eebd7a366ea745b7a54634.1512114577.git.hns@goldelico.com>
Message-ID: <20171221145322.GN3875@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* H. Nikolaus Schaller <hns@goldelico.com> [171130 23:52]:
> GTA04 has a W2SG0004/84 connected to UART2 of the OMAP3
> processor. A GPIO can pulse the on/off toggle switch.
> 
> The VSIM regulator is used to power on/off the LNA of an external
> active GPS antenna so that a driver can turn the LNA off if GPS is
> not needed to save battery energy.
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Sounds like Greg's going to take the whole series, so for this
patch:

Acked-by: Tony Lindgren <tony@atomide.com>

> ---
>  arch/arm/boot/dts/omap3-gta04.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> index 4504908c23fe..1ad744a25c36 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -477,6 +477,13 @@
>  &uart2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart2_pins>;
> +
> +	gps: gps {
> +		compatible = "wi2wi,w2sg0004";
> +		lna-supply = <&vsim>;   /* LNA regulator */
> +		/* GPIO_145: trigger for on/off-impulse for w2sg0004 */
> +		enable-gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;
> +	};
>  };
>  
>  &uart3 {
> -- 
> 2.12.2
> 
