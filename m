From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 30 Mar 2017 17:45:08 +0200
Subject: [PATCH v4 2/4] mvebu: xp: Add PWM properties to .dtsi files
In-Reply-To: <20170327194301.1104-3-ralph.sennhauser@gmail.com> (Ralph
 Sennhauser's message of "Mon, 27 Mar 2017 21:42:58 +0200")
References: <20170327194301.1104-1-ralph.sennhauser@gmail.com>
 <20170327194301.1104-3-ralph.sennhauser@gmail.com>
Message-ID: <87wpb693az.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ralph,
 
 On lun., mars 27 2017, Ralph Sennhauser <ralph.sennhauser@gmail.com> wrote:

The title should start by ARM: dts: mvebu:

If there is no need to have a v5 then I wil take care of modifying the
title while applying it.


> From: Andrew Lunn <andrew@lunn.ch>
>
> Add properties to the GPIO nodes to allow them to be also used as PWM
> lines.
>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> URL: https://patchwork.ozlabs.org/patch/427294/
> [Ralph Sennhauser:
>   * Use new compatible string marvell,armada-370-xp-gpio
>   * Add missing reg-names / #pwm-cell properties to armada-xp-mv78260.dtsi
>     'gpio1' node]
> Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
> ---
>  arch/arm/boot/dts/armada-370.dtsi        | 16 +++++++++++-----
>  arch/arm/boot/dts/armada-xp-mv78230.dtsi | 14 ++++++++++----
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi | 16 +++++++++++-----
>  arch/arm/boot/dts/armada-xp-mv78460.dtsi | 16 +++++++++++-----
>  4 files changed, 43 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
> index cc011c8..e30b076 100644
> --- a/arch/arm/boot/dts/armada-370.dtsi
> +++ b/arch/arm/boot/dts/armada-370.dtsi
> @@ -137,29 +137,35 @@
>  			};
>  
>  			gpio0: gpio at 18100 {
> -				compatible = "marvell,orion-gpio";
> -				reg = <0x18100 0x40>;
> +				compatible = "marvell,armada-370-xp-gpio";

I think we should keep the "marvell,orion-gpio" too because the hardware
is still compatible with it. Morever it will allow to use a recent dtb
with an old kernel.


> +				reg = <0x18100 0x40>, <0x181c0 0x08>;
> +				reg-names = "gpio", "pwm";
>  				ngpios = <32>;
>  				gpio-controller;
>  				#gpio-cells = <2>;
> +				#pwm-cells = <2>;
>  				interrupt-controller;
>  				#interrupt-cells = <2>;
>  				interrupts = <82>, <83>, <84>, <85>;
> +				clocks = <&coreclk 0>;
>  			};
>  
>  			gpio1: gpio at 18140 {
> -				compatible = "marvell,orion-gpio";
> -				reg = <0x18140 0x40>;
> +				compatible = "marvell,armada-370-xp-gpio";

Same here and for all the others...

Thanks,

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
