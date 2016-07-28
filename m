From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 28 Jul 2016 12:18:45 +0200
Subject: [PATCH 10/18] ARM: mvebu: a39x: enable watchdog for all
 Armada-39x SoCs
In-Reply-To: <1469105055-25181-12-git-send-email-jaz@semihalf.com> (Grzegorz
 Jaszczyk's message of "Thu, 21 Jul 2016 14:44:07 +0200")
References: <1469105055-25181-1-git-send-email-jaz@semihalf.com>
 <1469105055-25181-12-git-send-email-jaz@semihalf.com>
Message-ID: <87fuqukquy.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grzegorz,
 
 On jeu., juil. 21 2016, Grzegorz Jaszczyk <jaz@semihalf.com> wrote:

Add a commit log here and change the prefix to "ARM: dts: mvebu:
armada-39x:"

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks,

Gregory

> Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
> Reviewed-by: Lior Amsalem <alior@marvell.com>
> ---
>  arch/arm/boot/dts/armada-39x.dtsi | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/armada-39x.dtsi
> index 03dc0ec..5e01438 100644
> --- a/arch/arm/boot/dts/armada-39x.dtsi
> +++ b/arch/arm/boot/dts/armada-39x.dtsi
> @@ -322,6 +322,14 @@
>  				clock-names = "nbclk", "fixed";
>  			};
>  
> +			watchdog at 20300 {
> +				compatible = "marvell,armada-380-wdt";
> +				reg = <0x20300 0x34>, <0x20704 0x4>,
> +				      <0x18260 0x4>;
> +				clocks = <&coreclk 2>, <&refclk>;
> +				clock-names = "nbclk", "fixed";
> +			};
> +
>  			cpurst at 20800 {
>  				compatible = "marvell,armada-370-cpu-reset";
>  				reg = <0x20800 0x10>;
> @@ -534,5 +542,12 @@
>  			#clock-cells = <0>;
>  			clock-frequency = <1000000000>;
>  		};
> +
> +		/* 25 MHz reference crystal */
> +		refclk: oscillator {
> +			compatible = "fixed-clock";
> +			#clock-cells = <0>;
> +			clock-frequency = <25000000>;
> +		};
>  	};
>  };
> -- 
> 1.8.3.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
