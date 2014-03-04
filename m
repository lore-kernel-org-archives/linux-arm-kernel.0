From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 3 Mar 2014 22:05:22 -0500
Subject: [PATCH 3/3] ARM: Kirkwood: DT: Add missing vendor prefix
In-Reply-To: <1393773855-9592-3-git-send-email-andrew@lunn.ch>
References: <1393773855-9592-1-git-send-email-andrew@lunn.ch>
 <1393773855-9592-3-git-send-email-andrew@lunn.ch>
Message-ID: <20140304030522.GZ1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

Couple of stupid questions:

 - I haven't seen 0/1 nor 1/1 show up anywhere (dt, lakml, inbox), am I
   missing something?

With that in mind:

On Sun, Mar 02, 2014 at 04:24:15PM +0100, Andrew Lunn wrote:
> Add vendor prefixes to compatible strings where they are missing.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/boot/dts/kirkwood-b3.dts              | 2 +-
>  arch/arm/boot/dts/kirkwood-cloudbox.dts        | 2 +-
>  arch/arm/boot/dts/kirkwood-dreamplug.dts       | 2 +-
>  arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts | 2 +-
>  arch/arm/boot/dts/kirkwood-ns2-common.dtsi     | 2 +-
>  arch/arm/boot/dts/kirkwood-nsa310.dts          | 2 +-
>  arch/arm/boot/dts/kirkwood-nsa310a.dts         | 2 +-
>  arch/arm/boot/dts/kirkwood-openblocks_a6.dts   | 2 +-
>  arch/arm/boot/dts/kirkwood-openblocks_a7.dts   | 2 +-
>  9 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-b3.dts b/arch/arm/boot/dts/kirkwood-b3.dts
> index 40791053106b..6becedebaa4e 100644
> --- a/arch/arm/boot/dts/kirkwood-b3.dts
> +++ b/arch/arm/boot/dts/kirkwood-b3.dts
> @@ -75,7 +75,7 @@
>  			m25p16 at 0 {
>  				#address-cells = <1>;
>  				#size-cells = <1>;
> -				compatible = "m25p16";
> +				compatible = "st,m25p16";

Have you checked that the drivers for each of these changes already
support the new compatible strings?

thx,

Jason.

>  				reg = <0>;
>  				spi-max-frequency = <40000000>;
>  				mode = <0>;
> diff --git a/arch/arm/boot/dts/kirkwood-cloudbox.dts b/arch/arm/boot/dts/kirkwood-cloudbox.dts
> index 0e06fd3cee4d..3b62aeeaa3a2 100644
> --- a/arch/arm/boot/dts/kirkwood-cloudbox.dts
> +++ b/arch/arm/boot/dts/kirkwood-cloudbox.dts
> @@ -46,7 +46,7 @@
>  			flash at 0 {
>  				#address-cells = <1>;
>  				#size-cells = <1>;
> -				compatible = "mx25l4005a";
> +				compatible = "mxicy,mx25l4005a";
>  				reg = <0>;
>  				spi-max-frequency = <20000000>;
>  				mode = <0>;
> diff --git a/arch/arm/boot/dts/kirkwood-dreamplug.dts b/arch/arm/boot/dts/kirkwood-dreamplug.dts
> index ef3463e0ae19..28b3ee369778 100644
> --- a/arch/arm/boot/dts/kirkwood-dreamplug.dts
> +++ b/arch/arm/boot/dts/kirkwood-dreamplug.dts
> @@ -43,7 +43,7 @@
>  			m25p40 at 0 {
>  				#address-cells = <1>;
>  				#size-cells = <1>;
> -				compatible = "mx25l1606e";
> +				compatible = "mxicy,mx25l1606e";
>  				reg = <0>;
>  				spi-max-frequency = <50000000>;
>  				mode = <0>;
> diff --git a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
> index 2cb0dc529165..32c6fb4a1162 100644
> --- a/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
> +++ b/arch/arm/boot/dts/kirkwood-mv88f6281gtw-ge.dts
> @@ -56,7 +56,7 @@
>  			flash at 0 {
>  				#address-cells = <1>;
>  				#size-cells = <1>;
> -				compatible = "mx25l12805d";
> +				compatible = "mxicy,mx25l12805d";
>  				reg = <0>;
>  				spi-max-frequency = <50000000>;
>  				mode = <0>;
> diff --git a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
> index 743152f31a81..594bad0e386e 100644
> --- a/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
> +++ b/arch/arm/boot/dts/kirkwood-ns2-common.dtsi
> @@ -32,7 +32,7 @@
>  			flash at 0 {
>  				#address-cells = <1>;
>  				#size-cells = <1>;
> -				compatible = "mx25l4005a";
> +				compatible = "mxicy,mx25l4005a";
>  				reg = <0>;
>  				spi-max-frequency = <20000000>;
>  				mode = <0>;
> diff --git a/arch/arm/boot/dts/kirkwood-nsa310.dts b/arch/arm/boot/dts/kirkwood-nsa310.dts
> index 03fa24cf3344..0a07af9d8e58 100644
> --- a/arch/arm/boot/dts/kirkwood-nsa310.dts
> +++ b/arch/arm/boot/dts/kirkwood-nsa310.dts
> @@ -104,7 +104,7 @@
>  			status = "okay";
>  
>  			adt7476: adt7476a at 2e {
> -				compatible = "adt7476";
> +				compatible = "adi,adt7476";
>  				reg = <0x2e>;
>  			};
>  		};
> diff --git a/arch/arm/boot/dts/kirkwood-nsa310a.dts b/arch/arm/boot/dts/kirkwood-nsa310a.dts
> index a5e779452867..27ca6a79c48a 100644
> --- a/arch/arm/boot/dts/kirkwood-nsa310a.dts
> +++ b/arch/arm/boot/dts/kirkwood-nsa310a.dts
> @@ -94,7 +94,7 @@
>  			status = "okay";
>  
>  			lm85: lm85 at 2e {
> -				compatible = "lm85";
> +				compatible = "national,lm85";
>  				reg = <0x2e>;
>  			};
>  		};
> diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
> index b88da9392c32..0650beafc1de 100644
> --- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
> +++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
> @@ -40,7 +40,7 @@
>  			pinctrl-names = "default";
>  
>  			s35390a: s35390a at 30 {
> -				compatible = "s35390a";
> +				compatible = "sii,s35390a";
>  				reg = <0x30>;
>  			};
>  		};
> diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a7.dts b/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
> index b2f7cae06839..895506743e4d 100644
> --- a/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
> +++ b/arch/arm/boot/dts/kirkwood-openblocks_a7.dts
> @@ -52,7 +52,7 @@
>  			pinctrl-names = "default";
>  
>  			s24c02: s24c02 at 50 {
> -				compatible = "24c02";
> +				compatible = "at,24c02";
>  				reg = <0x50>;
>  			};
>  		};
> -- 
> 1.8.5.3
> 
