From: marvin24@gmx.de (Marc Dietrich)
Date: Wed, 27 Jun 2012 23:59:33 +0200
Subject: [PATCH V2] ARM: dt: tegra: paz00: add regulators
In-Reply-To: <1340757060-27232-1-git-send-email-swarren@wwwdotorg.org>
References: <1340757060-27232-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <9938329.yDzqmf1yu1@ax5200p>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 June 2012 18:31:00 Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The Toshiba AC100/PAZ00 uses a TPS6586x regulator. Instantiate this.
> 
> [...]
> 
> Cc: Marc Dietrich <marvin24@gmx.de>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

I tested this on paz00 using linux-next and found no issues, so feel free to 
add ...

Tested-By: Marc Dietrich <marvin24@gmx.de>

> ---
> v2:
> * Made all constraints specify a single voltage rather than different
>   min/max, per description above.
> * Removed vin-supply properties from LDO nodes; the driver and binding
>   need to be updated to support specifying the parent regulators before
>   we can put these into DT.
> ---
>  arch/arm/boot/dts/tegra20-paz00.dts |  130
> +++++++++++++++++++++++++++++++++++ 1 files changed, 130 insertions(+), 0
> deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra20-paz00.dts
> b/arch/arm/boot/dts/tegra20-paz00.dts index 684a9e1..dccc8b4 100644
> --- a/arch/arm/boot/dts/tegra20-paz00.dts
> +++ b/arch/arm/boot/dts/tegra20-paz00.dts
> @@ -272,12 +272,142 @@
>  		status = "okay";
>  		clock-frequency = <400000>;
> 
> +		pmic: tps6586x at 34 {
> +			compatible = "ti,tps6586x";
> +			reg = <0x34>;
> +			interrupts = <0 86 0x4>;
> +
> +			#gpio-cells = <2>;
> +			gpio-controller;
> +
> +			regulators {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				regulator at 0 {
> +					reg = <0>;
> +					regulator-compatible = "sm0";
> +					regulator-name = "+1.2vs_sm0";
> +					regulator-min-microvolt = <1200000>;
> +					regulator-max-microvolt = <1200000>;
> +					regulator-always-on;
> +				};
> +
> +				regulator at 1 {
> +					reg = <1>;
> +					regulator-compatible = "sm1";
> +					regulator-name = "+1.0vs_sm1";
> +					regulator-min-microvolt = <1000000>;
> +					regulator-max-microvolt = <1000000>;
> +					regulator-always-on;
> +				};
> +
> +				regulator at 2 {
> +					reg = <2>;
> +					regulator-compatible = "sm2";
> +					regulator-name = "+3.7vs_sm2";
> +					regulator-min-microvolt = <3700000>;
> +					regulator-max-microvolt = <3700000>;
> +					regulator-always-on;
> +				};
> +
> +				regulator at 3 {
> +					reg = <3>;
> +					regulator-compatible = "ldo0";
> +					regulator-name = "+3.3vs_ldo0";
> +					regulator-min-microvolt = <3300000>;
> +					regulator-max-microvolt = <3300000>;
> +				};
> +
> +				regulator at 4 {
> +					reg = <4>;
> +					regulator-compatible = "ldo1";
> +					regulator-name = "+1.1vs_ldo1";
> +					regulator-min-microvolt = <1100000>;
> +					regulator-max-microvolt = <1100000>;
> +					regulator-always-on;
> +				};
> +
> +				regulator at 5 {
> +					reg = <5>;
> +					regulator-compatible = "ldo2";
> +					regulator-name = "+1.2vs_ldo2";
> +					regulator-min-microvolt = <1200000>;
> +					regulator-max-microvolt = <1200000>;
> +				};
> +
> +				regulator at 6 {
> +					reg = <6>;
> +					regulator-compatible = "ldo3";
> +					regulator-name = "+3.3vs_ldo3";
> +					regulator-min-microvolt = <3300000>;
> +					regulator-max-microvolt = <3300000>;
> +					regulator-always-on;
> +				};
> +
> +				regulator at 7 {
> +					reg = <7>;
> +					regulator-compatible = "ldo4";
> +					regulator-name = "+1.8vs_ldo4";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
> +				};
> +
> +				regulator at 8 {
> +					reg = <8>;
> +					regulator-compatible = "ldo5";
> +					regulator-name = "+2.85vs_ldo5";
> +					regulator-min-microvolt = <2850000>;
> +					regulator-max-microvolt = <2850000>;
> +					regulator-always-on;
> +				};
> +
> +				regulator at 9 {
> +					reg = <9>;
> +					regulator-compatible = "ldo6";
> +					regulator-name = "+2.85vs_ldo6";
> +					regulator-min-microvolt = <2850000>;
> +					regulator-max-microvolt = <2850000>;
> +				};
> +
> +				regulator at 10 {
> +					reg = <10>;
> +					regulator-compatible = "ldo7";
> +					regulator-name = "+3.3vs_ldo7";
> +					regulator-min-microvolt = <3300000>;
> +					regulator-max-microvolt = <3300000>;
> +				};
> +
> +				regulator at 11 {
> +					reg = <11>;
> +					regulator-compatible = "ldo8";
> +					regulator-name = "+1.8vs_ldo8";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +				};
> +
> +				regulator at 12 {
> +					reg = <12>;
> +					regulator-compatible = "ldo9";
> +					regulator-name = "+2.85vs_ldo9";
> +					regulator-min-microvolt = <2850000>;
> +					regulator-max-microvolt = <2850000>;
> +					regulator-always-on;
> +				};
> +			};
> +		};
> +
>  		adt7461 at 4c {
>  			compatible = "adi,adt7461";
>  			reg = <0x4c>;
>  		};
>  	};
> 
> +	pmc {
> +		nvidia,invert-interrupt;
> +	};
> +
>  	usb at c5000000 {
>  		status = "okay";
>  	};
