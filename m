From: tony@atomide.com (Tony Lindgren)
Date: Mon, 14 Sep 2015 10:26:25 -0700
Subject: [PATCH 1/2] ARM: dts: am335x-phycore-som: Fix mpu voltage
In-Reply-To: <1441281607-35457-1-git-send-email-t.remmet@phytec.de>
References: <1441281607-35457-1-git-send-email-t.remmet@phytec.de>
Message-ID: <20150914172625.GR4215@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Teresa Remmet <t.remmet@phytec.de> [150903 05:03]:
> Fix the mpu voltage as it is set to low for the silicon
> revision 2.1.
> 
> Signed-off-by: Teresa Remmet <t.remmet@phytec.de>

Applying this one into omap-for-v4.3/fixes thanks.

Tony

> ---
>  arch/arm/boot/dts/am335x-phycore-som.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
> index 4d28fc3..5dd084f 100644
> --- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
> +++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
> @@ -252,10 +252,10 @@
>  		};
>  
>  		vdd1_reg: regulator at 2 {
> -			/* VDD_MPU voltage limits 0.95V - 1.26V with +/-4% tolerance */
> +			/* VDD_MPU voltage limits 0.95V - 1.325V with +/-4% tolerance */
>  			regulator-name = "vdd_mpu";
>  			regulator-min-microvolt = <912500>;
> -			regulator-max-microvolt = <1312500>;
> +			regulator-max-microvolt = <1378000>;
>  			regulator-boot-on;
>  			regulator-always-on;
>  		};
> -- 
> 1.9.1
> 
