From: robh@kernel.org (Rob Herring)
Date: Thu, 5 Nov 2015 07:27:37 -0600
Subject: [PATCH 1/2] ls2080a/dts: Add little endian property for GPIO IP
 block
In-Reply-To: <1446619704-27669-1-git-send-email-Gang.Liu@freescale.com>
References: <1446619704-27669-1-git-send-email-Gang.Liu@freescale.com>
Message-ID: <20151105132737.GA11186@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04, 2015 at 02:48:23PM +0800, Liu Gang wrote:
> The GPIO block for ls2080a platform has little endian registers,
> the GPIO driver needs this property to read/write registers by
> right interface.
> 
> Signed-off-by: Liu Gang <Gang.Liu@freescale.com>

Acked-by: Rob Herring <robh@kernel.org>


> diff --git a/Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt b/Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt
> index f2455c5..c836dab 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-mpc8xxx.txt
> @@ -10,6 +10,9 @@ Required properties:
>    the second cell is used to specify the gpio polarity:
>        0 = active high
>        1 = active low
> +- little-endian : Should be set if the GPIO has little endian
> +		  registers. No the property means the GPIO
> +		  registers are big endian mode.
>  
>  Example:
>  
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> index f3c59f9..41bb8c1 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi
> @@ -277,6 +277,7 @@
>  			reg = <0x0 0x2300000 0x0 0x10000>;
>  			interrupts = <0 36 0x4>; /* Level high type */
>  			gpio-controller;
> +			little-endian;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
> @@ -287,6 +288,7 @@
>  			reg = <0x0 0x2310000 0x0 0x10000>;
>  			interrupts = <0 36 0x4>; /* Level high type */
>  			gpio-controller;
> +			little-endian;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
> @@ -297,6 +299,7 @@
>  			reg = <0x0 0x2320000 0x0 0x10000>;
>  			interrupts = <0 37 0x4>; /* Level high type */
>  			gpio-controller;
> +			little-endian;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
> @@ -307,6 +310,7 @@
>  			reg = <0x0 0x2330000 0x0 0x10000>;
>  			interrupts = <0 37 0x4>; /* Level high type */
>  			gpio-controller;
> +			little-endian;
>  			#gpio-cells = <2>;
>  			interrupt-controller;
>  			#interrupt-cells = <2>;
> -- 
> 2.1.0.27.g96db324
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
