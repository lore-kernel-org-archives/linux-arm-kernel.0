From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 27 May 2015 12:04:34 +0200
Subject: [PATCH 3/3] ARM: mvebu: use improved armada spi device tree
 compatible name for each SoC
In-Reply-To: <1432633484-18758-4-git-send-email-gregory.clement@free-electrons.com>
References: <1432633484-18758-1-git-send-email-gregory.clement@free-electrons.com>
 <1432633484-18758-4-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <556596B2.4060300@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 26/05/2015 11:44, Gregory CLEMENT wrote:
> Use the new compatible introduced in rder to beneficiate of a wider
> and more accurate range of baud rates to be used.
> 

As the driver part was applied, I applied this patch
on mvebu/dt
Thanks,

Gregory


> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi | 2 --
>  arch/arm/boot/dts/armada-370.dtsi    | 4 ++++
>  arch/arm/boot/dts/armada-375.dtsi    | 6 ++++--
>  arch/arm/boot/dts/armada-38x.dtsi    | 6 ++++--
>  arch/arm/boot/dts/armada-39x.dtsi    | 6 ++++--
>  arch/arm/boot/dts/armada-xp.dtsi     | 8 ++++++++
>  6 files changed, 24 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> index ec96f0b36346..7f0252c580e4 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -149,7 +149,6 @@
>  			};
>  
>  			spi0: spi at 10600 {
> -				compatible = "marvell,armada-370-spi", "marvell,orion-spi";
>  				reg = <0x10600 0x28>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> @@ -160,7 +159,6 @@
>  			};
>  
>  			spi1: spi at 10680 {
> -				compatible = "marvell,armada-370-spi", "marvell,orion-spi";
>  				reg = <0x10680 0x28>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
> index 00b50db57c9c..3f036bd635f4 100644
> --- a/arch/arm/boot/dts/armada-370.dtsi
> +++ b/arch/arm/boot/dts/armada-370.dtsi
> @@ -139,11 +139,15 @@
>  			 * board level if a different configuration is used.
>  			 */
>  			spi0: spi at 10600 {
> +				compatible = "marvell,armada-370-spi",
> +						"marvell,orion-spi";
>  				pinctrl-0 = <&spi0_pins1>;
>  				pinctrl-names = "default";
>  			};
>  
>  			spi1: spi at 10680 {
> +				compatible = "marvell,armada-370-spi",
> +						"marvell,orion-spi";
>  				pinctrl-0 = <&spi1_pins>;
>  				pinctrl-names = "default";
>  			};
> diff --git a/arch/arm/boot/dts/armada-375.dtsi b/arch/arm/boot/dts/armada-375.dtsi
> index f076ff856d8b..67a0ab0f71e0 100644
> --- a/arch/arm/boot/dts/armada-375.dtsi
> +++ b/arch/arm/boot/dts/armada-375.dtsi
> @@ -238,7 +238,8 @@
>  			};
>  
>  			spi0: spi at 10600 {
> -				compatible = "marvell,orion-spi";
> +				compatible = "marvell,armada-375-spi",
> +						"marvell,orion-spi";
>  				reg = <0x10600 0x50>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> @@ -249,7 +250,8 @@
>  			};
>  
>  			spi1: spi at 10680 {
> -				compatible = "marvell,orion-spi";
> +				compatible = "marvell,armada-375-spi",
> +						"marvell,orion-spi";
>  				reg = <0x10680 0x50>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
> index 218a2acd36e5..eace85db7c8c 100644
> --- a/arch/arm/boot/dts/armada-38x.dtsi
> +++ b/arch/arm/boot/dts/armada-38x.dtsi
> @@ -167,7 +167,8 @@
>  			};
>  
>  			spi0: spi at 10600 {
> -				compatible = "marvell,orion-spi";
> +				compatible = "marvell,armada-380-spi",
> +						"marvell,orion-spi";
>  				reg = <0x10600 0x50>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> @@ -178,7 +179,8 @@
>  			};
>  
>  			spi1: spi at 10680 {
> -				compatible = "marvell,orion-spi";
> +				compatible = "marvell,armada-380-spi",
> +						"marvell,orion-spi";
>  				reg = <0x10680 0x50>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> diff --git a/arch/arm/boot/dts/armada-39x.dtsi b/arch/arm/boot/dts/armada-39x.dtsi
> index ecd1318109ba..fc9864f85fc2 100644
> --- a/arch/arm/boot/dts/armada-39x.dtsi
> +++ b/arch/arm/boot/dts/armada-39x.dtsi
> @@ -128,7 +128,8 @@
>  			};
>  
>  			spi0: spi at 10600 {
> -				compatible = "marvell,orion-spi";
> +				compatible = "marvell,armada-390-spi",
> +						"marvell,orion-spi";
>  				reg = <0x10600 0x50>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> @@ -139,7 +140,8 @@
>  			};
>  
>  			spi1: spi at 10680 {
> -				compatible = "marvell,orion-spi";
> +				compatible = "marvell,armada-390-spi",
> +						"marvell,orion-spi";
>  				reg = <0x10680 0x50>;
>  				#address-cells = <1>;
>  				#size-cells = <0>;
> diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
> index 013d63f69e36..e78ce4ab6b75 100644
> --- a/arch/arm/boot/dts/armada-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-xp.dtsi
> @@ -85,10 +85,18 @@
>  			};
>  
>  			spi0: spi at 10600 {
> +				compatible = "marvell,armada-xp-spi",
> +						"marvell,orion-spi";
>  				pinctrl-0 = <&spi0_pins>;
>  				pinctrl-names = "default";
>  			};
>  
> +			spi1: spi at 10680 {
> +				compatible = "marvell,armada-xp-spi",
> +						"marvell,orion-spi";
> +			};
> +
> +
>  			i2c0: i2c at 11000 {
>  				compatible = "marvell,mv78230-i2c", "marvell,mv64xxx-i2c";
>  				reg = <0x11000 0x100>;
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
