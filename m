From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 26 Apr 2016 11:19:59 +0800
Subject: [PATCH] ARM: dts: imx53-qsb: Fix regulator constraints
In-Reply-To: <1461089705-8270-1-git-send-email-fabio.estevam@nxp.com>
References: <1461089705-8270-1-git-send-email-fabio.estevam@nxp.com>
Message-ID: <20160426031959.GE8870@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2016 at 03:15:05PM -0300, Fabio Estevam wrote:
> Currently the imx53-qsb board with a Dialog DA9053 PMIC fails to boot:
> 
> [    0.397546] LDO3: Bringing 3300000uV into 1800000-1800000uV
> 
> The LDO3 voltage constraints passed in the device tree do not match
> the valid range according to the datasheet, so fix this accordingly to
> allow the board booting again.

So you are saying this is a regression?  If so, please provide the
commit that introduces the regression.

Shawn

> 
> While at that, fix the other voltage constraints as well.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
>  arch/arm/boot/dts/imx53-qsb.dts | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
> index dec4b07..3799396 100644
> --- a/arch/arm/boot/dts/imx53-qsb.dts
> +++ b/arch/arm/boot/dts/imx53-qsb.dts
> @@ -64,8 +64,8 @@
>  			};
>  
>  			ldo3_reg: ldo3 {
> -				regulator-min-microvolt = <600000>;
> -				regulator-max-microvolt = <1800000>;
> +				regulator-min-microvolt = <1725000>;
> +				regulator-max-microvolt = <3300000>;
>  				regulator-always-on;
>  			};
>  
> @@ -76,8 +76,8 @@
>  			};
>  
>  			ldo5_reg: ldo5 {
> -				regulator-min-microvolt = <1725000>;
> -				regulator-max-microvolt = <3300000>;
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <3600000>;
>  				regulator-always-on;
>  			};
>  
> @@ -100,14 +100,14 @@
>  			};
>  
>  			ldo9_reg: ldo9 {
> -				regulator-min-microvolt = <1200000>;
> +				regulator-min-microvolt = <1250000>;
>  				regulator-max-microvolt = <3600000>;
>  				regulator-always-on;
>  			};
>  
>  			ldo10_reg: ldo10 {
> -				regulator-min-microvolt = <1250000>;
> -				regulator-max-microvolt = <3650000>;
> +				regulator-min-microvolt = <1200000>;
> +				regulator-max-microvolt = <3600000>;
>  				regulator-always-on;
>  			};
>  		};
> -- 
> 1.9.1
> 
> 
