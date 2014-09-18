From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 18 Sep 2014 22:17:06 +0800
Subject: [PATCH 3/3] ARM: dts: vf610-colibri: Add backlight support
In-Reply-To: <cea494421deefe0b862e31b08685074715acf8d6.1410930820.git.bhuvanchandra.dv@toradex.com>
References: <cover.1410930820.git.bhuvanchandra.dv@toradex.com>
 <cea494421deefe0b862e31b08685074715acf8d6.1410930820.git.bhuvanchandra.dv@toradex.com>
Message-ID: <20140918141705.GM4796@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 01:46:30PM +0530, Bhuvanchandra DV wrote:
> 
> Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
> ---
>  arch/arm/boot/dts/vf610-colibri-eval-v3.dts |    6 ++++++
>  arch/arm/boot/dts/vf610-colibri.dtsi        |    7 +++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610-colibri-eval-v3.dts b/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
> index ba98039..f1988a0 100644
> --- a/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
> +++ b/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
> @@ -52,3 +52,9 @@
>  &pwm1 {
>  	status = "okay";
>  };
> +
> +&backlight {
> +	brightness-levels = <0 4 8 16 32 64 128 255>;
> +	default-brightness-level = <6>;
> +	status  = "okay";
> +};
> diff --git a/arch/arm/boot/dts/vf610-colibri.dtsi b/arch/arm/boot/dts/vf610-colibri.dtsi
> index 9bd1415..e725306 100644
> --- a/arch/arm/boot/dts/vf610-colibri.dtsi
> +++ b/arch/arm/boot/dts/vf610-colibri.dtsi
> @@ -25,6 +25,13 @@
>  		};
>  	};
>  
> +	backlight: bl {

I would suggest we name the node following the example in
Documentation/devicetree/bindings/pwm/pwm.txt, i.e. bl: backlight.

> +		compitable = "pwm-backlight";
> +		pwms = <&pwm0 0 5000000 0>;
> +		pwm-names = " backlight";

Drop the leading space in the string.

Shawn

> +		status = "disabled";
> +	};
> +
>  };
>  
>  &esdhc1 {
> -- 
> 1.7.9.5
> 
