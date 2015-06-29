From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 29 Jun 2015 15:04:56 +0200
Subject: [PATCH v2 2/3] ARM: mvebu: update Ethernet compatible string
 for Armada XP
In-Reply-To: <1434547162-6275-3-git-send-email-simon.guinot@sequanux.org>
References: <1434547162-6275-1-git-send-email-simon.guinot@sequanux.org>
 <1434547162-6275-3-git-send-email-simon.guinot@sequanux.org>
Message-ID: <55914278.5070106@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

> This patch updates the Ethernet DT nodes for Armada XP SoCs with the
> compatible string "marvell,armada-xp-neta".
> 
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> Cc: <stable@vger.kernel.org> # v3.8+

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-370-xp.dtsi     |  2 --
>  arch/arm/boot/dts/armada-370.dtsi        |  8 ++++++++
>  arch/arm/boot/dts/armada-xp-mv78260.dtsi |  2 +-
>  arch/arm/boot/dts/armada-xp-mv78460.dtsi |  2 +-
>  arch/arm/boot/dts/armada-xp.dtsi         | 10 +++++++++-
>  5 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
> index ec96f0b36346..06a2f2ae9d1e 100644
> --- a/arch/arm/boot/dts/armada-370-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-370-xp.dtsi
> @@ -270,7 +270,6 @@
>  			};
>  
>  			eth0: ethernet at 70000 {
> -				compatible = "marvell,armada-370-neta";
>  				reg = <0x70000 0x4000>;
>  				interrupts = <8>;
>  				clocks = <&gateclk 4>;
> @@ -286,7 +285,6 @@
>  			};
>  
>  			eth1: ethernet at 74000 {
> -				compatible = "marvell,armada-370-neta";
>  				reg = <0x74000 0x4000>;
>  				interrupts = <10>;
>  				clocks = <&gateclk 3>;
> diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
> index 00b50db57c9c..ca4257b2f77d 100644
> --- a/arch/arm/boot/dts/armada-370.dtsi
> +++ b/arch/arm/boot/dts/armada-370.dtsi
> @@ -307,6 +307,14 @@
>  					dmacap,memset;
>  				};
>  			};
> +
> +			ethernet at 70000 {
> +				compatible = "marvell,armada-370-neta";
> +			};
> +
> +			ethernet at 74000 {
> +				compatible = "marvell,armada-370-neta";
> +			};
>  		};
>  	};
>  };
> diff --git a/arch/arm/boot/dts/armada-xp-mv78260.dtsi b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
> index 8479fdc9e9c2..c5fdc99f0dbe 100644
> --- a/arch/arm/boot/dts/armada-xp-mv78260.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-mv78260.dtsi
> @@ -318,7 +318,7 @@
>  			};
>  
>  			eth3: ethernet at 34000 {
> -				compatible = "marvell,armada-370-neta";
> +				compatible = "marvell,armada-xp-neta";
>  				reg = <0x34000 0x4000>;
>  				interrupts = <14>;
>  				clocks = <&gateclk 1>;
> diff --git a/arch/arm/boot/dts/armada-xp-mv78460.dtsi b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
> index 661d54c81580..0e24f1a38540 100644
> --- a/arch/arm/boot/dts/armada-xp-mv78460.dtsi
> +++ b/arch/arm/boot/dts/armada-xp-mv78460.dtsi
> @@ -356,7 +356,7 @@
>  			};
>  
>  			eth3: ethernet at 34000 {
> -				compatible = "marvell,armada-370-neta";
> +				compatible = "marvell,armada-xp-neta";
>  				reg = <0x34000 0x4000>;
>  				interrupts = <14>;
>  				clocks = <&gateclk 1>;
> diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
> index 013d63f69e36..8fdd6d7c0ab1 100644
> --- a/arch/arm/boot/dts/armada-xp.dtsi
> +++ b/arch/arm/boot/dts/armada-xp.dtsi
> @@ -177,7 +177,7 @@
>  			};
>  
>  			eth2: ethernet at 30000 {
> -				compatible = "marvell,armada-370-neta";
> +				compatible = "marvell,armada-xp-neta";
>  				reg = <0x30000 0x4000>;
>  				interrupts = <12>;
>  				clocks = <&gateclk 2>;
> @@ -220,6 +220,14 @@
>  				};
>  			};
>  
> +			ethernet at 70000 {
> +				compatible = "marvell,armada-xp-neta";
> +			};
> +
> +			ethernet at 74000 {
> +				compatible = "marvell,armada-xp-neta";
> +			};
> +
>  			xor at f0900 {
>  				compatible = "marvell,orion-xor";
>  				reg = <0xF0900 0x100
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
