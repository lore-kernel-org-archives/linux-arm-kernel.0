From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 27 Jul 2016 16:43:22 +0200
Subject: [PATCH 1/3 v2] arm: mvebu: Add SPI1 pinctrl defines for Armada XP
In-Reply-To: <20160713094837.25956-1-sr@denx.de> (Stefan Roese's message of
 "Wed, 13 Jul 2016 11:48:35 +0200")
References: <20160713094837.25956-1-sr@denx.de>
Message-ID: <87eg6fnnud.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,
 
 On mer., juil. 13 2016, Stefan Roese <sr@denx.de> wrote:

> This patch defines and uses common Armada XP pinctrl settings in
> armada-xp.dtsi for the SPI1 interface (MPP13,14,16,17).
>
> Signed-off-by: Stefan Roese <sr@denx.de>
> Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>

Applied on mvebu/dt-4.9

Thanks,

Gregory
> ---
> v2:
> - Added to this dts SPI node move patchset. No functional change.
>
>  arch/arm/boot/dts/armada-xp.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
> index 553349c..4033790 100644
> --- a/arch/arm/boot/dts/armada-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-xp.dtsi
> @@ -94,6 +94,8 @@
>  			spi1: spi at 10680 {
>  				compatible = "marvell,armada-xp-spi",
>  						"marvell,orion-spi";
> +				pinctrl-0 = <&spi1_pins>;
> +				pinctrl-names = "default";
>  			};
>  
>  
> @@ -362,6 +364,12 @@
>  		marvell,function = "spi0";
>  	};
>  
> +	spi1_pins: spi1-pins {
> +		marvell,pins = "mpp13", "mpp14",
> +			       "mpp16", "mpp17";
> +		marvell,function = "spi1";
> +	};
> +
>  	uart2_pins: uart2-pins {
>  		marvell,pins = "mpp42", "mpp43";
>  		marvell,function = "uart2";
> -- 
> 2.9.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
