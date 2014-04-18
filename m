From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 18 Apr 2014 09:49:48 +0200
Subject: [PATCH 4/5] ARM: mvebu: remove clock-frequency of serial port
 Device Tree nodes
In-Reply-To: <1397806908-7550-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1397806908-7550-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1397806908-7550-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5350D91C.8070403@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/04/2014 09:41, Thomas Petazzoni wrote:
> Now that the Armada 370/375/38x/XP SoC-level Device Tree files have
> the proper "clocks" property in their UART controllers node, it is no
> longer useful to have the clock-frequency property defined in the
> board-level Device Tree files.
> 
> Therefore, this commit gets rid of all the useless 'clock-frequency'
> properties.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>


Thanks,

Gregory

> ---
>  arch/arm/boot/dts/armada-370-db.dts              | 1 -
>  arch/arm/boot/dts/armada-370-mirabox.dts         | 1 -
>  arch/arm/boot/dts/armada-370-netgear-rn102.dts   | 1 -
>  arch/arm/boot/dts/armada-370-netgear-rn104.dts   | 1 -
>  arch/arm/boot/dts/armada-370-rd.dts              | 1 -
>  arch/arm/boot/dts/armada-375-db.dts              | 1 -
>  arch/arm/boot/dts/armada-385-db.dts              | 1 -
>  arch/arm/boot/dts/armada-385-rd.dts              | 1 -
>  arch/arm/boot/dts/armada-xp-axpwifiap.dts        | 2 --
>  arch/arm/boot/dts/armada-xp-db.dts               | 4 ----
>  arch/arm/boot/dts/armada-xp-gp.dts               | 4 ----
>  arch/arm/boot/dts/armada-xp-matrix.dts           | 4 ----
>  arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts | 2 --
>  13 files changed, 24 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/armada-370-db.dts b/arch/arm/boot/dts/armada-370-db.dts
> index 3383c4b..416f4e5 100644
> --- a/arch/arm/boot/dts/armada-370-db.dts
> +++ b/arch/arm/boot/dts/armada-370-db.dts
> @@ -35,7 +35,6 @@
>  
>  		internal-regs {
>  			serial at 12000 {
> -				clock-frequency = <200000000>;
>  				status = "okay";
>  			};
>  			sata at a0000 {
> diff --git a/arch/arm/boot/dts/armada-370-mirabox.dts b/arch/arm/boot/dts/armada-370-mirabox.dts
> index 2354fe0..097df7d8 100644
> --- a/arch/arm/boot/dts/armada-370-mirabox.dts
> +++ b/arch/arm/boot/dts/armada-370-mirabox.dts
> @@ -47,7 +47,6 @@
>  
>  		internal-regs {
>  			serial at 12000 {
> -				clock-frequency = <200000000>;
>  				status = "okay";
>  			};
>  			timer at 20300 {
> diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
> index 651aeb5..d6d572e 100644
> --- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
> +++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
> @@ -50,7 +50,6 @@
>  
>  		internal-regs {
>  			serial at 12000 {
> -				clock-frequency = <200000000>;
>  				status = "okay";
>  			};
>  
> diff --git a/arch/arm/boot/dts/armada-370-netgear-rn104.dts b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
> index 4e27587..c5fe8b5 100644
> --- a/arch/arm/boot/dts/armada-370-netgear-rn104.dts
> +++ b/arch/arm/boot/dts/armada-370-netgear-rn104.dts
> @@ -50,7 +50,6 @@
>  
>  		internal-regs {
>  			serial at 12000 {
> -				clock-frequency = <200000000>;
>  				status = "okay";
>  			};
>  
> diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
> index 3e2c857..4169f40 100644
> --- a/arch/arm/boot/dts/armada-370-rd.dts
> +++ b/arch/arm/boot/dts/armada-370-rd.dts
> @@ -51,7 +51,6 @@
>  
>  		internal-regs {
>  			serial at 12000 {
> -				clock-frequency = <200000000>;
>  				status = "okay";
>  			};
>  			sata at a0000 {
> diff --git a/arch/arm/boot/dts/armada-375-db.dts b/arch/arm/boot/dts/armada-375-db.dts
> index 0451124..20f1f33 100644
> --- a/arch/arm/boot/dts/armada-375-db.dts
> +++ b/arch/arm/boot/dts/armada-375-db.dts
> @@ -68,7 +68,6 @@
>  			};
>  
>  			serial at 12000 {
> -				clock-frequency = <200000000>;
>  				status = "okay";
>  			};
>  
> diff --git a/arch/arm/boot/dts/armada-385-db.dts b/arch/arm/boot/dts/armada-385-db.dts
> index 6828d77..de778c6 100644
> --- a/arch/arm/boot/dts/armada-385-db.dts
> +++ b/arch/arm/boot/dts/armada-385-db.dts
> @@ -55,7 +55,6 @@
>  			};
>  
>  			serial at 12000 {
> -				clock-frequency = <200000000>;
>  				status = "okay";
>  			};
>  
> diff --git a/arch/arm/boot/dts/armada-385-rd.dts b/arch/arm/boot/dts/armada-385-rd.dts
> index 45250c8..4b39bed 100644
> --- a/arch/arm/boot/dts/armada-385-rd.dts
> +++ b/arch/arm/boot/dts/armada-385-rd.dts
> @@ -51,7 +51,6 @@
>  			};
>  
>  			serial at 12000 {
> -				clock-frequency = <200000000>;
>  				status = "okay";
>  			};
>  
> diff --git a/arch/arm/boot/dts/armada-xp-axpwifiap.dts b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
> index d83d7d6..a55a97a 100644
> --- a/arch/arm/boot/dts/armada-xp-axpwifiap.dts
> +++ b/arch/arm/boot/dts/armada-xp-axpwifiap.dts
> @@ -95,12 +95,10 @@
>  			};
>  
>  			serial at 12000 {
> -				clock-frequency = <250000000>;
>  				status = "okay";
>  			};
>  
>  			serial at 12100 {
> -				clock-frequency = <250000000>;
>  				status = "okay";
>  			};
>  
> diff --git a/arch/arm/boot/dts/armada-xp-db.dts b/arch/arm/boot/dts/armada-xp-db.dts
> index 448373c..2b598ef 100644
> --- a/arch/arm/boot/dts/armada-xp-db.dts
> +++ b/arch/arm/boot/dts/armada-xp-db.dts
> @@ -106,19 +106,15 @@
>  
>  		internal-regs {
>  			serial at 12000 {
> -				clock-frequency = <250000000>;
>  				status = "okay";
>  			};
>  			serial at 12100 {
> -				clock-frequency = <250000000>;
>  				status = "okay";
>  			};
>  			serial at 12200 {
> -				clock-frequency = <250000000>;
>  				status = "okay";
>  			};
>  			serial at 12300 {
> -				clock-frequency = <250000000>;
>  				status = "okay";
>  			};
>  
> diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
> index 61bda68..eb0013f 100644
> --- a/arch/arm/boot/dts/armada-xp-gp.dts
> +++ b/arch/arm/boot/dts/armada-xp-gp.dts
> @@ -104,19 +104,15 @@
>  
>  		internal-regs {
>  			serial at 12000 {
> -				clock-frequency = <250000000>;
>  				status = "okay";
>  			};
>  			serial at 12100 {
> -				clock-frequency = <250000000>;
>  				status = "okay";
>  			};
>  			serial at 12200 {
> -				clock-frequency = <250000000>;
>  				status = "okay";
>  			};
>  			serial at 12300 {
> -				clock-frequency = <250000000>;
>  				status = "okay";
>  			};
>  
> diff --git a/arch/arm/boot/dts/armada-xp-matrix.dts b/arch/arm/boot/dts/armada-xp-matrix.dts
> index c224274..25674fe 100644
> --- a/arch/arm/boot/dts/armada-xp-matrix.dts
> +++ b/arch/arm/boot/dts/armada-xp-matrix.dts
> @@ -37,19 +37,15 @@
>  
>  		internal-regs {
>  			serial at 12000 {
> -				clock-frequency = <250000000>;
>  				status = "okay";
>  			};
>  			serial at 12100 {
> -				clock-frequency = <250000000>;
>  				status = "okay";
>  			};
>  			serial at 12200 {
> -				clock-frequency = <250000000>;
>  				status = "okay";
>  			};
>  			serial at 12300 {
> -				clock-frequency = <250000000>;
>  				status = "okay";
>  			};
>  
> diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
> index 985948c..cf26d13 100644
> --- a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
> +++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
> @@ -72,11 +72,9 @@
>  
>  		internal-regs {
>  			serial at 12000 {
> -				clock-frequency = <250000000>;
>  				status = "okay";
>  			};
>  			serial at 12100 {
> -				clock-frequency = <250000000>;
>  				status = "okay";
>  			};
>  			pinctrl {
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
