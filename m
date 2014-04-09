From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 09 Apr 2014 13:11:26 +0200
Subject: [PATCH V4 4/5] dt: exynos5250: Enable support for generic USB DRD
 phy
In-Reply-To: <1396967803-28868-5-git-send-email-gautam.vivek@samsung.com>
References: <1396967803-28868-1-git-send-email-gautam.vivek@samsung.com>
 <1396967803-28868-5-git-send-email-gautam.vivek@samsung.com>
Message-ID: <53452ADE.2000609@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.04.2014 16:36, Vivek Gautam wrote:
> Add device tree node for new usbdrd-phy driver, which
> is based on generic phy framework.
>
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
>   arch/arm/boot/dts/exynos5250.dtsi |   10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index b7dec41..92c6fcd 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -530,6 +530,16 @@
>   		};
>   	};
>
> +	usbdrd_phy: phy at 12100000 {
> +		compatible = "samsung,exynos5250-usbdrd-phy";
> +		reg = <0x12100000 0x100>;
> +		clocks = <&clock 286>, <&clock 1>;
> +		clock-names = "phy", "ref";
> +		samsung,syscon-phandle = <&pmu_system_controller>;
> +		samsung,pmu-offset = <0x704>;
> +		#phy-cells = <1>;
> +	};
> +
>   	usb at 12110000 {
>   		compatible = "samsung,exynos4210-ehci";
>   		reg = <0x12110000 0x100>;
>

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

--
Best regards,
Tomasz
