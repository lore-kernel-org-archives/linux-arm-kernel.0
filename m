From: tony@atomide.com (Tony Lindgren)
Date: Wed, 8 May 2013 17:16:07 -0700
Subject: [PATCH v3,2/3] ARM: dts: AM33XX: Add GPMC node
In-Reply-To: <2645efefa3d36388ff1d4b64255d880b6587770f.1359007746.git.avinashphilip@ti.com>
References: <2645efefa3d36388ff1d4b64255d880b6587770f.1359007746.git.avinashphilip@ti.com>
Message-ID: <20130509001606.GZ32546@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Gupta, Pekon <pekon@ti.com> [130502 02:49]:
> From: "Philip, Avinash" <avinashphilip@ti.com>
> 
> Add GPMC data node to AM33XX device tree file.
> 
> Signed-off-by: Philip Avinash <avinashphilip@ti.com>
> Acked-by: Peter Korsgaard <jacmet@sunsite.dk>
> Signed-off-by: Pekon Gupta <pekon@ti.com>

Thanks adding into omap-for-v3.10/dt-fixes.

Tony
 
> ---
> Changes in v2:
> 	- Change number of chip select to 7
> 
>  arch/arm/boot/dts/am33xx.dtsi |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
> index 24fc835..1048795 100644
> --- a/arch/arm/boot/dts/am33xx.dtsi
> +++ b/arch/arm/boot/dts/am33xx.dtsi
> @@ -407,5 +407,17 @@
>  			ti,hwmods = "elm";
>  			status = "disabled";
>  		};
> +
> +		gpmc: gpmc at 50000000 {
> +			compatible = "ti,am3352-gpmc";
> +			ti,hwmods = "gpmc";
> +			reg = <0x50000000 0x2000>;
> +			interrupts = <100>;
> +			num-cs = <7>;
> +			num-waitpins = <2>;
> +			#address-cells = <2>;
> +			#size-cells = <1>;
> +			status = "disabled";
> +		};
>  	};
>  };
