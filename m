From: tushar.behera@linaro.org (Tushar Behera)
Date: Fri, 25 Apr 2014 11:57:05 +0530
Subject: [PATCH v5 1/9] dt: exynos5420: Enable support for USB 3.0 PHY
 controller
In-Reply-To: <1398263451-18023-2-git-send-email-gautam.vivek@samsung.com>
References: <1398263451-18023-1-git-send-email-gautam.vivek@samsung.com>
 <1398263451-18023-2-git-send-email-gautam.vivek@samsung.com>
Message-ID: <535A0039.3040307@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/23/2014 08:00 PM, Vivek Gautam wrote:
> Add device tree nodes for USB 3.0 PHY present alongwith
> USB 3.0 controller Exynos 5420 SoC. This phy driver is
> based on generic phy framework.
> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index c3a9a66..f69745f 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -732,4 +732,24 @@
>  		clock-names = "secss";
>  		samsung,power-domain = <&g2d_pd>;
>  	};
> +
> +	usbdrd_phy0: phy at 12100000 {
> +		compatible = "samsung,exynos5420-usbdrd-phy";
> +		reg = <0x12100000 0x100>;
> +		clocks = <&clock CLK_USBD300>, <&clock CLK_SCLK_USBPHY300>;
> +		clock-names = "phy", "ref";
> +		samsung,pmu-syscon = <&pmu_system_controller>;

Should the property name be samsung,syscon-phandle as used elsewhere?

samsung,syscon-phandle = <&pmu_system_controller>;

> +		samsung,pmu-offset = <0x704>;
> +		#phy-cells = <1>;
> +	};
> +
> +	usbdrd_phy1: phy at 12500000 {
> +		compatible = "samsung,exynos5420-usbdrd-phy";
> +		reg = <0x12500000 0x100>;
> +		clocks = <&clock CLK_USBD301>, <&clock CLK_SCLK_USBPHY301>;
> +		clock-names = "phy", "ref";
> +		samsung,pmu-syscon = <&pmu_system_controller>;

ditto

> +		samsung,pmu-offset = <0x708>;
> +		#phy-cells = <1>;
> +	};
>  };
> 


-- 
Tushar Behera
