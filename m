From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 27 Apr 2015 13:28:04 +0200
Subject: [PATCH v2] ARM: mvebu: Fix the main PLL frequency on Armada 375,
 38x and 39x SoCs
In-Reply-To: <1430117718-11818-1-git-send-email-gregory.clement@free-electrons.com>
References: <1430117718-11818-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20150427112804.GC2394@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 27, 2015 at 08:55:18AM +0200, Gregory CLEMENT wrote:
> Whereas for Armada 370 and XP the main PLL frequency was 2GHz for the
> Armada 375, 38x and 39x, the frequency is 1GHz. When writing support
> for these last SoCs, there was no official value for the PLL. Now that
> we have it, this patch fixes it in the device tree.
> 
> This value is currently only used by the NAND driver for the setting
> the NAND timing. Fortunately it is not actually used: all the mainline
> board with a NAND flash comes with a NAND device tree node using the
> "marvell,nand-keep-config" property. With this property the timings
> are not modified in the kernel driver and are kept from the
> bootloader.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> Hi,
> 
> The only change for this patch is the spell fixes and it was also
> rebased onto v4.1-rc1. Unless there is any objection I will apply it
> on mvebu/fixes for 4.1.

Hi Gregory

No objection. Without access to the data sheet or hardware, there is
little any of us can say against this.

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew

> 
> Thanks,
> 
> Gregroy
> 
>  arch/arm/boot/dts/armada-375.dtsi | 2 +-
>  arch/arm/boot/dts/armada-38x.dtsi | 2 +-
>  arch/arm/boot/dts/armada-39x.dtsi | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
> index c675257f2377..f076ff856d8b 100644
> --- a/arch/arm/boot/dts/armada-375.dtsi
> +++ b/arch/arm/boot/dts/armada-375.dtsi
> @@ -69,7 +69,7 @@
>  		mainpll: mainpll {
>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
> -			clock-frequency = <2000000000>;
> +			clock-frequency = <1000000000>;
>  		};
>  		/* 25 MHz reference crystal */
>  		refclk: oscillator {
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index ed2dd8ba4080..218a2acd36e5 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -585,7 +585,7 @@
>  		mainpll: mainpll {
>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
> -			clock-frequency = <2000000000>;
> +			clock-frequency = <1000000000>;
>  		};
>  
>  		/* 25 MHz reference crystal */
> diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/armada-39x.dtsi
> index 0e85fc15ceda..ecd1318109ba 100644
> --- a/arch/arm/boot/dts/armada-39x.dtsi
> +++ b/arch/arm/boot/dts/armada-39x.dtsi
> @@ -502,7 +502,7 @@
>  		mainpll: mainpll {
>  			compatible = "fixed-clock";
>  			#clock-cells = <0>;
> -			clock-frequency = <2000000000>;
> +			clock-frequency = <1000000000>;
>  		};
>  	};
>  };
> -- 
> 2.1.0
> 
