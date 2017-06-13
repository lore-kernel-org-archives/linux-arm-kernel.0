From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Tue, 13 Jun 2017 10:48:50 +0200
Subject: [PATCH] ARM: dts: mvebu: Add PWM properties for armada-38x
In-Reply-To: <20170601201030.22525-1-ralph.sennhauser@gmail.com> (Ralph
 Sennhauser's message of "Thu, 1 Jun 2017 22:10:30 +0200")
References: <20170601201030.22525-1-ralph.sennhauser@gmail.com>
Message-ID: <87y3sw8e8d.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ralph,
 
 On jeu., juin 01 2017, Ralph Sennhauser <ralph.sennhauser@gmail.com> wrote:

> Add the required properties to the GPIO nodes for them to be used as PWM
> lines.
>
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>

Applied on mvebu/dt

Thanks,

Gregory

>
> ---
>
> Hi everyone,
>
> this patch uses "marvell,armada-370-gpio" for the compatible property
> and as such depends on the rename of the property to still make it in in
> time for 4.12 ("gpio: mvebu: change compatible string for PWM support").
> Otherwise the compatible string will need to be amended to
> "marvell,armada-370-xp-gpio".
>
> Checked the functional spec and the register ranges and offsets are the
> same as for armada-xp. Likely the same holds true for the armada-39x
> family, though I neither have access to the spec nor any such hardware.
>
> Ralph
> ---
>  arch/arm/boot/dts/armada-38x.dtsi | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index 8b165c3..af31f5d 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -312,31 +312,39 @@
>  			};
>  
>  			gpio0: gpio at 18100 {
> -				compatible = "marvell,orion-gpio";
> -				reg = <0x18100 0x40>;
> +				compatible = "marvell,armada-370-gpio",
> +					     "marvell,orion-gpio";
> +				reg = <0x18100 0x40>, <0x181c0 0x08>;
> +				reg-names = "gpio", "pwm";
>  				ngpios = <32>;
>  				gpio-controller;
>  				#gpio-cells = <2>;
> +				#pwm-cells = <2>;
>  				interrupt-controller;
>  				#interrupt-cells = <2>;
>  				interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&coreclk 0>;
>  			};
>  
>  			gpio1: gpio at 18140 {
> -				compatible = "marvell,orion-gpio";
> -				reg = <0x18140 0x40>;
> +				compatible = "marvell,armada-370-gpio",
> +					     "marvell,orion-gpio";
> +				reg = <0x18140 0x40>, <0x181c8 0x08>;
> +				reg-names = "gpio", "pwm";
>  				ngpios = <28>;
>  				gpio-controller;
>  				#gpio-cells = <2>;
> +				#pwm-cells = <2>;
>  				interrupt-controller;
>  				#interrupt-cells = <2>;
>  				interrupts = <GIC_SPI 58 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>,
>  					     <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
> +				clocks = <&coreclk 0>;
>  			};
>  
>  			systemc: system-controller at 18200 {
> -- 
> 2.10.2
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
