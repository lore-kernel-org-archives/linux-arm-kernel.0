From: stefan@agner.ch (Stefan Agner)
Date: Fri, 19 Sep 2014 18:03:42 +0200
Subject: [PATCH v2 2/2] ARM: dts: vf610-colibri: Add backlight support
In-Reply-To: <bae435d33cac93fd5f0c763fbe7bb302b52a6f0f.1411130205.git.bhuvanchandra.dv@toradex.com>
References: <cover.1411130205.git.bhuvanchandra.dv@toradex.com>
 <bae435d33cac93fd5f0c763fbe7bb302b52a6f0f.1411130205.git.bhuvanchandra.dv@toradex.com>
Message-ID: <6548345144e6eb9f252bfa35e9783079@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 2014-09-19 15:38, schrieb Bhuvanchandra DV:
> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> ---
>  arch/arm/boot/dts/vf610-colibri-eval-v3.dts |    6 ++++++
>  arch/arm/boot/dts/vf610-colibri.dtsi        |    6 ++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
> b/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
> index 00f63d9..711cf82 100644
> --- a/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
> +++ b/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
> @@ -19,6 +19,12 @@
>  	};
>  };
>  
> +&bl {
> +	brightness-levels = <0 4 8 16 32 64 128 255>;
> +	default-brightness-level = <6>;
> +	status  = "okay";
> +};
> +
>  &esdhc1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_esdhc1>;
> diff --git a/arch/arm/boot/dts/vf610-colibri.dtsi
> b/arch/arm/boot/dts/vf610-colibri.dtsi
> index 560cd69..20b1c15 100644
> --- a/arch/arm/boot/dts/vf610-colibri.dtsi
> +++ b/arch/arm/boot/dts/vf610-colibri.dtsi
> @@ -13,6 +13,12 @@
>  	model = "Toradex Colibri VF61 COM";
>  	compatible = "toradex,vf610-colibri_vf61", "fsl,vf610";
>  
> +	bl: backlight {
> +		compitable = "pwm-backlight";
> +		pwms = <&pwm0 0 5000000 0>;
> +		status = "disabled";
> +	};
> +

Typo, "compitable" is not a valid property...

When this is fixed,
Acked-By: Stefan Agner <stefan@agner.ch>

>  	clocks {
>  		enet_ext {
>  			compatible = "fixed-clock";
