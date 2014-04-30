From: arunkk.samsung@gmail.com (Arun Kumar K)
Date: Wed, 30 Apr 2014 15:55:14 +0530
Subject: [PATCH 3/4] ARM: dts: Add usb2phy support on exynos5420
In-Reply-To: <1398848110-6152-4-git-send-email-gautam.vivek@samsung.com>
References: <1398848110-6152-1-git-send-email-gautam.vivek@samsung.com>
 <1398848110-6152-4-git-send-email-gautam.vivek@samsung.com>
Message-ID: <5360CF8A.5010809@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek,

On 04/30/14 14:25, Vivek Gautam wrote:
> Add required device node for usb2phy to let enable USB 2.0
> support.
> 
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi |   10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index cfa3755..16b860a 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -737,4 +737,14 @@
>  		clock-names = "secss";
>  		samsung,power-domain = <&g2d_pd>;
>  	};
> +
> +	phy at 12130000 {

As we will be changing over to reference-based updation of nodes in the
board dts files, it would be good to add node reference also while
adding new nodes. Like : usb_phy: phy at 12130000 {

Regards
Arun

> +		compatible = "samsung,exynos5250-usb2-phy";
> +		reg = <0x12130000 0x100>;
> +		clocks = <&clock CLK_USBH20>, <&clock CLK_SCLK_USBPHY300>;
> +		clock-names = "phy", "ref";
> +		#phy-cells = <1>;
> +		samsung,sysreg-phandle = <&sysreg_system_controller>;
> +		samsung,pmureg-phandle = <&pmu_system_controller>;
> +	};
>  };
> 
