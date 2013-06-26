From: jg1.han@samsung.com (Jingoo Han)
Date: Wed, 26 Jun 2013 16:29:27 +0900
Subject: [PATCH 3/4] ARM: dts: exynos4: Add nodes for USB PHY block
In-Reply-To: <1372174706-5459-4-git-send-email-t.figa@samsung.com>
References: <1372174706-5459-1-git-send-email-t.figa@samsung.com>
 <1372174706-5459-4-git-send-email-t.figa@samsung.com>
Message-ID: <001601ce723e$e3f20170$abd60450$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, June 26, 2013 12:38 AM, Tomasz Figa wrote:
> 
> This patch adds device tree nodes for USB OTG PHYs of Exynos4210 and
> Exynos4x12 SoCs.
> 
> Signed-off-by: Tomasz Figa <t.figa@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

It looks good.

Reviewed-by: Jingoo Han <jg1.han@samsung.com>

Best regards,
Jingoo Han


> ---
>  arch/arm/boot/dts/exynos4210.dtsi | 15 +++++++++++++++
>  arch/arm/boot/dts/exynos4x12.dtsi | 15 +++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> index 54710de..3c71ea5 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -114,6 +114,21 @@
>  		interrupts = <2 4>;
>  	};
> 
> +	usbphy at 125B0000 {
> +		compatible = "samsung,exynos4210-usb2phy";
> +		reg = <0x125B0000 0x100>;
> +		clocks = <&clock 305>;
> +		clock-names = "otg";
> +		status = "disabled";
> +		ranges;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		usbphy-sys {
> +			reg = <0x10020704 0x8>;
> +		};
> +	};
> +
>  	g2d at 12800000 {
>  		compatible = "samsung,s5pv210-g2d";
>  		reg = <0x12800000 0x1000>;
> diff --git a/arch/arm/boot/dts/exynos4x12.dtsi b/arch/arm/boot/dts/exynos4x12.dtsi
> index e3380a7..267ed95 100644
> --- a/arch/arm/boot/dts/exynos4x12.dtsi
> +++ b/arch/arm/boot/dts/exynos4x12.dtsi
> @@ -79,4 +79,19 @@
>  		interrupts = <0 89 0>;
>  		status = "disabled";
>  	};
> +
> +	usbphy at 125B0000 {
> +		compatible = "samsung,exynos4x12-usb2phy";
> +		reg = <0x125B0000 0x100>;
> +		clocks = <&clock 305>;
> +		clock-names = "otg";
> +		status = "disabled";
> +		ranges;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		usbphy-sys {
> +			reg = <0x10020704 0x8>;
> +		};
> +	};
>  };
> --
> 1.8.2.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
