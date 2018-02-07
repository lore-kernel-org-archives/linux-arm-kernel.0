From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 7 Feb 2018 14:41:48 +0530
Subject: [PATCH v2 15/15] ARM: dts: dra7: Add high speed modes capability
 to MMC1/MMC2 dt node
In-Reply-To: <20180206125806.19350-16-kishon@ti.com>
References: <20180206125806.19350-1-kishon@ti.com>
 <20180206125806.19350-16-kishon@ti.com>
Message-ID: <210939ed-67fc-fa37-b4f2-c1faefcc4642@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kishon,

On Tuesday 06 February 2018 06:28 PM, Kishon Vijay Abraham I wrote:
> Add UHS/HS200/DDR speed mode capability to MMC1 and MMC2 dt nodes.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

Along with this, dont we need to have

	/delete-property/ mmc-hs200-1_8v;

for eMMC on Beagle x15 which does not support HS200?

Or are you planning to depend on lack of pinctrl entries for HS200 to
take care of that?

Thanks,
Sekhar


> ---
>  arch/arm/boot/dts/dra7.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 7bf33d522b14..feb496e7c5ef 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -1073,7 +1073,13 @@
>  			status = "disabled";
>  			pbias-supply = <&pbias_mmc_reg>;
>  			max-frequency = <192000000>;
> +			sd-uhs-sdr104;
> +			sd-uhs-sdr50;
> +			sd-uhs-ddr50;
> +			sd-uhs-sdr25;
> +			sd-uhs-sdr12;
>  			cap-sd-highspeed;
> +			mmc-ddr-1_8v;
>  			cap-mmc-highspeed;
>  		};
>  
> @@ -1092,6 +1098,10 @@
>  			status = "disabled";
>  			max-frequency = <192000000>;
>  			cap-sd-highspeed;
> +			sd-uhs-sdr25;
> +			sd-uhs-sdr12;
> +			mmc-hs200-1_8v;
> +			mmc-ddr-1_8v;
>  			cap-mmc-highspeed;
>  		};
>  
> -- 
> 2.11.0
> 
