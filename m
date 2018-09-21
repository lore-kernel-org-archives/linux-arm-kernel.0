From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Fri, 21 Sep 2018 16:14:54 +0200
Subject: [RESEND PATCH 1/4] arm64: dts: marvell: move AP806/CP110 thermal
 nodes into a new syscon
In-Reply-To: <20180830081501.11569-1-miquel.raynal@bootlin.com> (Miquel
 Raynal's message of "Thu, 30 Aug 2018 10:14:58 +0200")
References: <20180830081501.11569-1-miquel.raynal@bootlin.com>
Message-ID: <87o9crgco1.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miquel,
 
 On jeu., ao?t 30 2018, Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> New bindings impose to declare the thermal IP from within a new syscon.
>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied on mvebu/dt64

Thanks,

Gregory

> ---
>  arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 14 ++++++++++----
>  arch/arm64/boot/dts/marvell/armada-cp110.dtsi | 18 ++++++++++++------
>  2 files changed, 22 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> index 92215342b453..3da3a13f7ee1 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
> @@ -256,10 +256,16 @@
>  				};
>  			};
>  
> -			ap_thermal: thermal at 6f808c {
> -				compatible = "marvell,armada-ap806-thermal";
> -				reg = <0x6f808c 0x4>,
> -				      <0x6f8084 0x8>;
> +			ap_syscon1: system-controller at 6f8000 {
> +				compatible = "syscon", "simple-mfd";
> +				reg = <0x6f8000 0x1000>;
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +
> +				ap_thermal: thermal-sensor at 80 {
> +					compatible = "marvell,armada-ap806-thermal";
> +					reg = <0x80 0x10>;
> +				};
>  			};
>  		};
>  	};
> diff --git a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> index 4315eeb0a473..62842fae2571 100644
> --- a/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-cp110.dtsi
> @@ -177,12 +177,6 @@
>  			interrupts = <77 IRQ_TYPE_LEVEL_HIGH>;
>  		};
>  
> -		CP110_LABEL(thermal): thermal at 400078 {
> -			compatible = "marvell,armada-cp110-thermal";
> -			reg = <0x400078 0x4>,
> -			<0x400070 0x8>;
> -		};
> -
>  		CP110_LABEL(syscon0): system-controller at 440000 {
>  			compatible = "syscon", "simple-mfd";
>  			reg = <0x440000 0x2000>;
> @@ -223,6 +217,18 @@
>  			};
>  		};
>  
> +		CP110_LABEL(syscon1): system-controller at 400000 {
> +			compatible = "syscon", "simple-mfd";
> +			reg = <0x400000 0x1000>;
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			CP110_LABEL(thermal): thermal-sensor at 70 {
> +				compatible = "marvell,armada-cp110-thermal";
> +				reg = <0x70 0x10>;
> +			};
> +		};
> +
>  		CP110_LABEL(usb3_0): usb3 at 500000 {
>  			compatible = "marvell,armada-8k-xhci",
>  			"generic-xhci";
> -- 
> 2.17.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
