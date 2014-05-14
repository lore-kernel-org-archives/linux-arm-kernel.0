From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 14 May 2014 15:18:03 +0200
Subject: [PATCH v6 3/3] ARM: sunxi: Add IR controller support in DT on A20
In-Reply-To: <1400006342-2968-4-git-send-email-bay@hackerdom.ru>
References: <1400006342-2968-1-git-send-email-bay@hackerdom.ru>
 <1400006342-2968-4-git-send-email-bay@hackerdom.ru>
Message-ID: <53736D0B.5070600@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

<snip>

On 05/13/2014 08:39 PM, Alexander Bersenev wrote:
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 0ae2b77..40ded74 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -724,6 +724,19 @@
>  				allwinner,drive = <2>;
>  				allwinner,pull = <0>;
>  			};
> +
> +			ir0_pins_a: ir0 at 0 {
> +				    allwinner,pins = "PB3","PB4";
> +				    allwinner,function = "ir0";
> +				    allwinner,drive = <0>;
> +				    allwinner,pull = <0>;
> +			};
> +			ir1_pins_a: ir1 at 0 {
> +				    allwinner,pins = "PB22","PB23";
> +				    allwinner,function = "ir1";
> +				    allwinner,drive = <0>;
> +				    allwinner,pull = <0>;
> +			};
>  		};
>  
>  		timer at 01c20c00 {
> @@ -937,5 +950,23 @@
>  			#interrupt-cells = <3>;
>  			interrupts = <1 9 0xf04>;
>  		};
> +
> +		ir0: ir at 01c21800 {
> +			compatible = "allwinner,sun7i-a20-ir";
> +			clocks = <&apb0_gates 6>, <&ir0_clk>;
> +			clock-names = "apb", "ir";
> +			interrupts = <0 5 4>;
> +			reg = <0x01c21800 0x40>;
> +			status = "disabled";
> +		};
> +
> +		ir1: ir at 01c21c00 {
> +			compatible = "allwinner,sun7i-a20-ir";
> +			clocks = <&apb0_gates 7>, <&ir1_clk>;
> +			clock-names = "apb", "ir";
> +			interrupts = <0 6 4>;
> +			reg = <0x01C21c00 0x40>;
> +			status = "disabled";
> +		};
>  	};
>  };
> 

The entries in the soc block are sorted by register address, so please
don't add these at the end, instead keep things sorted.

Regards,

Hans
