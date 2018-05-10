From: liviu.dudau@arm.com (Liviu Dudau)
Date: Thu, 10 May 2018 10:45:18 +0100
Subject: [PATCH 2/3] arm64: dts: juno: replace '_' with '-' in node names
In-Reply-To: <1525884291-18851-2-git-send-email-sudeep.holla@arm.com>
References: <1525884291-18851-1-git-send-email-sudeep.holla@arm.com>
 <1525884291-18851-2-git-send-email-sudeep.holla@arm.com>
Message-ID: <20180510094518.GQ1027@e110455-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2018 at 05:44:50PM +0100, Sudeep Holla wrote:
> The latest DTC throws warnings for character '_' in the node names.
> 
> Warning (node_name_chars_strict): /thermal-zones/big_cluster: Character '_' not recommended in node name
> Warning (node_name_chars_strict): /thermal-zones/little_cluster: Character '_' not recommended in node name
> Warning (node_name_chars_strict): /smb at 8000000/motherboard/gpio_keys: Character '_' not recommended in node name
> Warning (node_name_chars_strict): /pmu_a57: Character '_' not recommended in node name
> Warning (node_name_chars_strict): /pmu_a53: Character '_' not recommended in node name
> 
> The general recommendation is to use character '-' for all the node names.
> This patch fixes the warnings following the recommendation.
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  arch/arm64/boot/dts/arm/juno-base.dtsi        | 4 ++--
>  arch/arm64/boot/dts/arm/juno-motherboard.dtsi | 2 +-
>  arch/arm64/boot/dts/arm/juno-r1.dts           | 4 ++--
>  arch/arm64/boot/dts/arm/juno-r2.dts           | 4 ++--
>  arch/arm64/boot/dts/arm/juno.dts              | 4 ++--
>  5 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
> index b2fedaab3fcc..b74e462c6658 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -572,14 +572,14 @@
>  			thermal-sensors = <&scpi_sensors0 3>;
>  		};
>  
> -		big_cluster_thermal_zone: big_cluster {
> +		big_cluster_thermal_zone: big-cluster {
>  			polling-delay = <1000>;
>  			polling-delay-passive = <100>;
>  			thermal-sensors = <&scpi_sensors0 21>;
>  			status = "disabled";
>  		};
>  
> -		little_cluster_thermal_zone: little_cluster {
> +		little_cluster_thermal_zone: little-cluster {
>  			polling-delay = <1000>;
>  			polling-delay-passive = <100>;
>  			thermal-sensors = <&scpi_sensors0 22>;
> diff --git a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> index 4b38195a8bea..70e3409d86a3 100644
> --- a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
> @@ -54,7 +54,7 @@
>  				regulator-always-on;
>  			};
>  
> -			gpio_keys {
> +			gpio-keys {
>  				compatible = "gpio-keys";
>  
>  				power-button {
> diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
> index c52c5c40dede..2c5db03f226c 100644
> --- a/arch/arm64/boot/dts/arm/juno-r1.dts
> +++ b/arch/arm64/boot/dts/arm/juno-r1.dts
> @@ -201,7 +201,7 @@
>  		};
>  	};
>  
> -	pmu_a57 {
> +	pmu-a57 {
>  		compatible = "arm,cortex-a57-pmu";
>  		interrupts = <GIC_SPI 02 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 06 IRQ_TYPE_LEVEL_HIGH>;
> @@ -209,7 +209,7 @@
>  				     <&A57_1>;
>  	};
>  
> -	pmu_a53 {
> +	pmu-a53 {
>  		compatible = "arm,cortex-a53-pmu";
>  		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
> diff --git a/arch/arm64/boot/dts/arm/juno-r2.dts b/arch/arm64/boot/dts/arm/juno-r2.dts
> index a90982ceda35..c51950f4a1b6 100644
> --- a/arch/arm64/boot/dts/arm/juno-r2.dts
> +++ b/arch/arm64/boot/dts/arm/juno-r2.dts
> @@ -201,7 +201,7 @@
>  		};
>  	};
>  
> -	pmu_a72 {
> +	pmu-a72 {
>  		compatible = "arm,cortex-a72-pmu";
>  		interrupts = <GIC_SPI 02 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 06 IRQ_TYPE_LEVEL_HIGH>;
> @@ -209,7 +209,7 @@
>  				     <&A72_1>;
>  	};
>  
> -	pmu_a53 {
> +	pmu-a53 {
>  		compatible = "arm,cortex-a53-pmu";
>  		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
> diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
> index c9236c4b967d..2b2bf39c30ef 100644
> --- a/arch/arm64/boot/dts/arm/juno.dts
> +++ b/arch/arm64/boot/dts/arm/juno.dts
> @@ -200,7 +200,7 @@
>  		};
>  	};
>  
> -	pmu_a57 {
> +	pmu-a57 {
>  		compatible = "arm,cortex-a57-pmu";
>  		interrupts = <GIC_SPI 02 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 06 IRQ_TYPE_LEVEL_HIGH>;
> @@ -208,7 +208,7 @@
>  				     <&A57_1>;
>  	};
>  
> -	pmu_a53 {
> +	pmu-a53 {
>  		compatible = "arm,cortex-a53-pmu";
>  		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>,
>  			     <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>,
> -- 
> 2.7.4
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
