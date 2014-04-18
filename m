From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Apr 2014 09:49:05 +0200
Subject: [PATCH 3/5] ARM: mvebu: use clocks property for serial ports
In-Reply-To: <1397806908-7550-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397806908-7550-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397806908-7550-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5350D8F1.5010602@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/04/2014 09:41, Thomas Petazzoni wrote:
> Back when the Armada 370 and Armada XP initial support was introduced,
> the only way to pass the clock frequency to the of_serial driver was
> through a clock-frequency Device Tree property.
> 
> Thanks to 0bbeb3c3e84bc963d1c66661e082d207023b0e5c ('of serial port
> driver - add clk_get_rate() support'), it is possible to use the
> standard 'clocks' DT property to reference the clock used for a
> particular UART controller. This clock is then used by the of_serial
> driver to retrieve the clock rate.
> 
> This commit modifies the SoC-level Device Tree files of Armada 370,
> Armada XP, Armada 375 and Armada 38x to use this possibility. Since
> there is no gatable clock for the UART controllers, we simply
> reference the TCLK, which is the main SoC clock for the peripherals.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi | 2 ++
>  arch/arm/boot/dts/armada-375.dtsi    | 2 ++
>  arch/arm/boot/dts/armada-38x.dtsi    | 2 ++
>  arch/arm/boot/dts/armada-xp.dtsi     | 2 ++
>  4 files changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> index bbb40f6..3bc1fa80 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -157,6 +157,7 @@
>  				reg-shift = <2>;
>  				interrupts = <41>;
>  				reg-io-width = <1>;
> +				clocks = <&coreclk 0>;
>  				status = "disabled";
>  			};
>  			serial at 12100 {
> @@ -165,6 +166,7 @@
>  				reg-shift = <2>;
>  				interrupts = <42>;
>  				reg-io-width = <1>;
> +				clocks = <&coreclk 0>;
>  				status = "disabled";
>  			};
>  
> diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
> index 3877693..0c50c44 100644
> --- a/arch/arm/boot/dts/armada-375.dtsi
> +++ b/arch/arm/boot/dts/armada-375.dtsi
> @@ -194,6 +194,7 @@
>  				reg-shift = <2>;
>  				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
>  				reg-io-width = <1>;
> +				clocks = <&coreclk 0>;
>  				status = "disabled";
>  			};
>  
> @@ -203,6 +204,7 @@
>  				reg-shift = <2>;
>  				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>  				reg-io-width = <1>;
> +				clocks = <&coreclk 0>;
>  				status = "disabled";
>  			};
>  
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index a064f59..63fdf2d 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -174,6 +174,7 @@
>  				reg-shift = <2>;
>  				interrupts = <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>;
>  				reg-io-width = <1>;
> +				clocks = <&coreclk 0>;
>  				status = "disabled";
>  			};
>  
> @@ -183,6 +184,7 @@
>  				reg-shift = <2>;
>  				interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>;
>  				reg-io-width = <1>;
> +				clocks = <&coreclk 0>;
>  				status = "disabled";
>  			};
>  
> diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
> index abb9f9d..a9fff62 100644
> --- a/arch/arm/boot/dts/armada-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-xp.dtsi
> @@ -58,6 +58,7 @@
>  				reg-shift = <2>;
>  				interrupts = <43>;
>  				reg-io-width = <1>;
> +				clocks = <&coreclk 0>;
>  				status = "disabled";
>  			};
>  			serial at 12300 {
> @@ -66,6 +67,7 @@
>  				reg-shift = <2>;
>  				interrupts = <44>;
>  				reg-io-width = <1>;
> +				clocks = <&coreclk 0>;
>  				status = "disabled";
>  			};
>  
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
