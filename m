From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 4 Nov 2015 18:13:38 +0100
Subject: [PATCH 1/2] ARM: at91/dt: remove leftovers clock definition
In-Reply-To: <1446650149-31563-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1446650149-31563-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <563A3CC2.5030007@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 04/11/2015 16:15, Alexandre Belloni a ?crit :
> The clocks group properties and the clock at 0 node are useless, remove them
> to avoid copy pasting in future device trees.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  arch/arm/boot/dts/at91-kizbox.dts           |  9 ---------
>  arch/arm/boot/dts/at91-sama5d2_xplained.dts |  9 ---------
>  arch/arm/boot/dts/at91-sama5d4_xplained.dts |  9 ---------
>  arch/arm/boot/dts/at91-sama5d4ek.dts        |  9 ---------
>  arch/arm/boot/dts/at91rm9200ek.dts          |  9 ---------
>  arch/arm/boot/dts/at91sam9261ek.dts         |  9 ---------
>  arch/arm/boot/dts/at91sam9263ek.dts         |  9 ---------
>  arch/arm/boot/dts/at91sam9g20ek_common.dtsi |  9 ---------
>  arch/arm/boot/dts/at91sam9m10g45ek.dts      |  9 ---------
>  arch/arm/boot/dts/at91sam9n12ek.dts         |  9 ---------
>  arch/arm/boot/dts/at91sam9rlek.dts          |  9 ---------
>  arch/arm/boot/dts/at91sam9x5cm.dtsi         | 11 -----------
>  12 files changed, 110 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91-kizbox.dts b/arch/arm/boot/dts/at91-kizbox.dts
> index bf18ece0c027..1dcd836059ea 100644
> --- a/arch/arm/boot/dts/at91-kizbox.dts
> +++ b/arch/arm/boot/dts/at91-kizbox.dts
> @@ -24,15 +24,6 @@
>  	};
>  
>  	clocks {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges;
> -
> -		main_clock: clock at 0 {
> -			compatible = "atmel,osc", "fixed-clock";
> -			clock-frequency = <18432000>;
> -		};
> -
>  		main_xtal {
>  			clock-frequency = <18432000>;
>  		};
> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> index e07c2b206beb..28eaf41d59da 100644
> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> @@ -59,15 +59,6 @@
>  	};
>  
>  	clocks {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges;
> -
> -		main_clock: clock at 0 {
> -			compatible = "atmel,osc", "fixed-clock";
> -			clock-frequency = <12000000>;
> -		};
> -
>  		slow_xtal {
>  			clock-frequency = <32768>;
>  		};
> diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> index 45371a1b61b3..d3de7565efc3 100644
> --- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> @@ -59,15 +59,6 @@
>  	};
>  
>  	clocks {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges;
> -
> -		main_clock: clock at 0 {
> -			compatible = "atmel,osc", "fixed-clock";
> -			clock-frequency = <12000000>;
> -		};
> -
>  		slow_xtal {
>  			clock-frequency = <32768>;
>  		};
> diff --git a/arch/arm/boot/dts/at91-sama5d4ek.dts b/arch/arm/boot/dts/at91-sama5d4ek.dts
> index 6d272c0125e3..c9d8b73a65ad 100644
> --- a/arch/arm/boot/dts/at91-sama5d4ek.dts
> +++ b/arch/arm/boot/dts/at91-sama5d4ek.dts
> @@ -59,15 +59,6 @@
>  	};
>  
>  	clocks {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges;
> -
> -		main_clock: clock at 0 {
> -			compatible = "atmel,osc", "fixed-clock";
> -			clock-frequency = <12000000>;
> -		};
> -
>  		slow_xtal {
>  			clock-frequency = <32768>;
>  		};
> diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/at91rm9200ek.dts
> index 8dab4b75ca97..f90e1c2d3caa 100644
> --- a/arch/arm/boot/dts/at91rm9200ek.dts
> +++ b/arch/arm/boot/dts/at91rm9200ek.dts
> @@ -21,15 +21,6 @@
>  	};
>  
>  	clocks {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges;
> -
> -		main_clock: clock at 0 {
> -			compatible = "atmel,osc", "fixed-clock";
> -			clock-frequency = <18432000>;
> -		};
> -
>  		slow_xtal {
>  			clock-frequency = <32768>;
>  		};
> diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
> index 2e92ac020f23..f1971f73d7aa 100644
> --- a/arch/arm/boot/dts/at91sam9261ek.dts
> +++ b/arch/arm/boot/dts/at91sam9261ek.dts
> @@ -22,15 +22,6 @@
>  	};
>  
>  	clocks {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges;
> -
> -		main_clock: clock at 0 {
> -			compatible = "atmel,osc", "fixed-clock";
> -			clock-frequency = <18432000>;
> -		};
> -
>  		slow_xtal {
>  			clock-frequency = <32768>;
>  		};
> diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
> index 23381276ffb8..c76e890069fe 100644
> --- a/arch/arm/boot/dts/at91sam9263ek.dts
> +++ b/arch/arm/boot/dts/at91sam9263ek.dts
> @@ -22,15 +22,6 @@
>  	};
>  
>  	clocks {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges;
> -
> -		main_clock: clock at 0 {
> -			compatible = "atmel,osc", "fixed-clock";
> -			clock-frequency = <16367660>;
> -		};
> -
>  		slow_xtal {
>  			clock-frequency = <32768>;
>  		};
> diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
> index 57548a2c5a1e..658d4c1cf7f6 100644
> --- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
> @@ -19,15 +19,6 @@
>  	};
>  
>  	clocks {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges;
> -
> -		main_clock: clock at 0 {
> -			compatible = "atmel,osc", "fixed-clock";
> -			clock-frequency = <18432000>;
> -		};
> -
>  		slow_xtal {
>  			clock-frequency = <32768>;
>  		};
> diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
> index 9d16ef8453c5..865171be739b 100644
> --- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
> +++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
> @@ -24,15 +24,6 @@
>  	};
>  
>  	clocks {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges;
> -
> -		main_clock: clock at 0 {
> -			compatible = "atmel,osc", "fixed-clock";
> -			clock-frequency = <12000000>;
> -		};
> -
>  		slow_xtal {
>  		      clock-frequency = <32768>;
>  		};
> diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
> index acf3451a332d..cb152995b4f3 100644
> --- a/arch/arm/boot/dts/at91sam9n12ek.dts
> +++ b/arch/arm/boot/dts/at91sam9n12ek.dts
> @@ -23,15 +23,6 @@
>  	};
>  
>  	clocks {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges;
> -
> -		main_clock: clock at 0 {
> -			compatible = "atmel,osc", "fixed-clock";
> -			clock-frequency = <16000000>;
> -		};
> -
>  		slow_xtal {
>  			clock-frequency = <32768>;
>  		};
> diff --git a/arch/arm/boot/dts/at91sam9rlek.dts b/arch/arm/boot/dts/at91sam9rlek.dts
> index 558c9f220bed..9eea591e2a16 100644
> --- a/arch/arm/boot/dts/at91sam9rlek.dts
> +++ b/arch/arm/boot/dts/at91sam9rlek.dts
> @@ -22,15 +22,6 @@
>  	};
>  
>  	clocks {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges;
> -
> -		main_clock: clock {
> -			compatible = "atmel,osc", "fixed-clock";
> -			clock-frequency = <12000000>;
> -		};
> -
>  		slow_xtal {
>  			clock-frequency = <32768>;
>  		};
> diff --git a/arch/arm/boot/dts/at91sam9x5cm.dtsi b/arch/arm/boot/dts/at91sam9x5cm.dtsi
> index 26112ebd15fc..b098ad8cd93a 100644
> --- a/arch/arm/boot/dts/at91sam9x5cm.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5cm.dtsi
> @@ -13,17 +13,6 @@
>  	};
>  
>  	clocks {
> -		#address-cells = <1>;
> -		#size-cells = <1>;
> -		ranges;
> -
> -		main_clock: clock at 0 {
> -			compatible = "atmel,osc", "fixed-clock";
> -			clock-frequency = <12000000>;
> -		};
> -	};
> -
> -	clocks {
>  		slow_xtal {
>  			clock-frequency = <32768>;
>  		};
> 


-- 
Nicolas Ferre
