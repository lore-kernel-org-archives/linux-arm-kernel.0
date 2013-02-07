From: anilkumar.v@ti.com (Kumar, Anil)
Date: Thu, 7 Feb 2013 05:49:39 +0000
Subject: [PATCH 2/5] ARM: dts: exynos5250-arndale: Add PMIC node entry
In-Reply-To: <1360214129-4096-2-git-send-email-tushar.behera@linaro.org>
References: <1360214129-4096-1-git-send-email-tushar.behera@linaro.org>
 <1360214129-4096-2-git-send-email-tushar.behera@linaro.org>
Message-ID: <F3DBB1B3EF102E4994C89758CFCA32412C4DE1@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 07, 2013 at 10:45:26, Tushar Behera wrote:
> From: Amit Daniel Kachhap <amit.daniel@samsung.com>
> 
> Added S5M8767 PMIC DT nodes to Arndale board.
> 
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> ---
>  arch/arm/boot/dts/exynos5250-arndale.dts |  213 +++++++++++++++++++++++++++++-
>  1 files changed, 212 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
> index 9ce40df..b40a02f 100644
> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
> @@ -25,7 +25,218 @@
>  	};
>  
>  	i2c at 12C60000 {
> -		status = "disabled";
> +		status = "okay";

Is there any need to change status "okay" here as in dtsi file it is
by default okay ?   

> +		samsung,i2c-sda-delay = <100>;
> +		samsung,i2c-max-bus-freq = <20000>;
> +		samsung,i2c-slave-addr = <0x66>;
> +		gpios = <&gpb3 0 2 3 0>,
> +			<&gpb3 1 2 3 0>;
> +
> +		s5m8767_pmic at 66 {
> +			compatible = "samsung,s5m8767-pmic";
> +			reg = <0x66>;
> +
> +			s5m8767,pmic-buck2-dvs-voltage = <1300000>;
> +			s5m8767,pmic-buck3-dvs-voltage = <1100000>;
> +			s5m8767,pmic-buck4-dvs-voltage = <1200000>;
> +			s5m8767,pmic-buck-dvs-gpios = <&gpd1 0 1 0 0>,
> +							<&gpd1 1 1 0 0>,
> +							<&gpd1 2 1 0 0>;
> +			s5m8767,pmic-buck-ds-gpios = <&gpx2 3 1 0 0>,
> +							<&gpx2 4 1 0 0>,
> +							<&gpx2 5 1 0 0>;
> +			regulators {
> +				ldo1_reg: LDO1 {
> +					regulator-name = "VDD_ALIVE_1.0V";
> +					regulator-min-microvolt = <1100000>;
> +					regulator-max-microvolt = <1100000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +					op_mode = <1>;
> +				};
> +
> +				ldo2_reg: LDO2 {
> +					regulator-name = "VDD_28IO_DP_1.35V";
> +					regulator-min-microvolt = <1200000>;
> +					regulator-max-microvolt = <1200000>;
> +					regulator-always-on;
> +					op_mode = <1>;
> +				};
> +
> +				ldo3_reg: LDO3 {
> +					regulator-name = "VDD_COMMON1_1.8V";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
> +					op_mode = <1>;
> +				};
> +
> +				ldo4_reg: LDO4 {
> +					regulator-name = "VDD_IOPERI_1.8V";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
> +					op_mode = <1>;
> +				};
> +
> +				ldo5_reg: LDO5 {
> +					regulator-name = "VDD_EXT_1.8V";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
> +					op_mode = <1>;
> +				};
> +
> +				ldo6_reg: LDO6 {
> +					regulator-name = "VDD_MPLL_1.1V";
> +					regulator-min-microvolt = <1100000>;
> +					regulator-max-microvolt = <1100000>;
> +					regulator-always-on;
> +					op_mode = <1>;
> +				};
> +
> +				ldo7_reg: LDO7 {
> +					regulator-name = "VDD_XPLL_1.1V";
> +					regulator-min-microvolt = <1100000>;
> +					regulator-max-microvolt = <1100000>;
> +					regulator-always-on;
> +					op_mode = <1>;
> +				};
> +
> +				ldo8_reg: LDO8 {
> +					regulator-name = "VDD_COMMON2_1.0V";
> +					regulator-min-microvolt = <1000000>;
> +					regulator-max-microvolt = <1000000>;
> +					regulator-always-on;
> +					op_mode = <1>;
> +				};
> +
> +				ldo9_reg: LDO9 {
> +					regulator-name = "VDD_33ON_3.0V";
> +					regulator-min-microvolt = <3000000>;
> +					regulator-max-microvolt = <3000000>;
> +					regulator-always-on;
> +					op_mode = <1>;
> +				};
> +
> +				ldo10_reg: LDO10 {
> +					regulator-name = "VDD_COMMON3_1.8V";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
> +					op_mode = <1>;
> +				};
> +
> +				ldo11_reg: LDO11 {
> +					regulator-name = "VDD_ABB2_1.8V";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
> +					op_mode = <1>;
> +				};
> +
> +				ldo12_reg: LDO12 {
> +					regulator-name = "VDD_USB_3.0V";
> +					regulator-min-microvolt = <3000000>;
> +					regulator-max-microvolt = <3000000>;
> +					regulator-always-on;
> +					op_mode = <1>;
> +				};
> +
> +				ldo13_reg: LDO13 {
> +					regulator-name = "VDDQ_C2C_W_1.8V";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
> +					op_mode = <1>;
> +				};
> +
> +				ldo14_reg: LDO14 {
> +					regulator-name = "VDD18_ABB0_3_1.8V";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
> +					op_mode = <1>;
> +				};
> +
> +				ldo15_reg: LDO15 {
> +					regulator-name = "VDD10_COMMON4_1.0V";
> +					regulator-min-microvolt = <1000000>;
> +					regulator-max-microvolt = <1000000>;
> +					regulator-always-on;
> +					op_mode = <1>;
> +				};
> +
> +				ldo16_reg: LDO16 {
> +					regulator-name = "VDD18_HSIC_1.8V";
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
> +					op_mode = <1>;
> +				};
> +
> +				ldo17_reg: LDO17 {
> +					regulator-name = "VDDQ_MMC2_3_2.8V";
> +					regulator-min-microvolt = <2800000>;
> +					regulator-max-microvolt = <2800000>;
> +					regulator-always-on;
> +					op_mode = <1>;
> +				};
> +
> +				ldo18_reg: LDO18 {
> +					regulator-name = "VDD_33ON_2.8V";
> +					regulator-min-microvolt = <2800000>;
> +					regulator-max-microvolt = <2800000>;
> +					regulator-always-on;
> +					op_mode = <1>;
> +				};
> +
> +				buck1_reg: BUCK1 {
> +					regulator-name = "VDD_MIF_1.2V";
> +					regulator-min-microvolt = <950000>;
> +					regulator-max-microvolt = <1200000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +					op_mode = <1>;
> +				};
> +
> +				buck2_reg: BUCK2 {
> +					regulator-name = "vdd_arm";
> +					regulator-min-microvolt = <925000>;
> +					regulator-max-microvolt = <1300000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +					op_mode = <1>;
> +				};
> +
> +				buck3_reg: BUCK3 {
> +					regulator-name = "VDD_INT_1.0V";
> +					regulator-min-microvolt = <900000>;
> +					regulator-max-microvolt = <1200000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +					op_mode = <1>;
> +				};
> +
> +				buck4_reg: BUCK4 {
> +					regulator-name = "VDD_G3D_1.0V";
> +					regulator-min-microvolt = <1000000>;
> +					regulator-max-microvolt = <1000000>;
> +					regulator-always-on;
> +					op_mode = <1>;
> +				};
> +
> +				buck5_reg: BUCK5 {
> +					regulator-name = "VDD_MEM_1.35V";
> +					regulator-min-microvolt = <750000>;
> +					regulator-max-microvolt = <1355000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +					op_mode = <1>;
> +				};
> +
> +			};
> +		};
>  	};
>  
>  	i2c at 12C70000 {
> -- 
> 1.7.4.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
