From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 24 Apr 2014 18:09:45 +0200
Subject: [PATCH 2/4] ARM: dts: exynos4: add exynos_usbphy node
In-Reply-To: <1397479700-15864-3-git-send-email-chanho61.park@samsung.com>
References: <1397479700-15864-1-git-send-email-chanho61.park@samsung.com>
 <1397479700-15864-3-git-send-email-chanho61.park@samsung.com>
Message-ID: <53593749.5020009@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanho,

On 14.04.2014 14:48, Chanho Park wrote:
> This patch enables a exynos_usbphy node for exynos4 SoCs.
> A exynos4x12 usb phy node is almost same with 4210's one
> except compatible string and pmu syscon.
>
> Cc: Tomasz Figa <t.figa@samsung.com>
> Cc: Kamil Debski <k.debski@samsung.com>
> Signed-off-by: Chanho Park <chanho61.park@samsung.com>
> ---
>   arch/arm/boot/dts/exynos4.dtsi    | 10 ++++++++++
>   arch/arm/boot/dts/exynos4x12.dtsi |  5 +++++
>   2 files changed, 15 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
> index e565b86..0e32d7f 100644
> --- a/arch/arm/boot/dts/exynos4.dtsi
> +++ b/arch/arm/boot/dts/exynos4.dtsi
> @@ -278,6 +278,16 @@
>   		status = "disabled";
>   	};
>
> +	exynos_usbphy: exynos-usbphy at 125B0000 {
> +		compatible = "samsung,exynos4210-usb2-phy";
> +		reg = <0x125B0000 0x100>;
> +		samsung,pmureg-phandle = <&pmu_reg>;
> +		clocks = <&clock 305>, <&clock 2>;

Please use clock macros from include/dt-bindings instead of numbers 
directly.

Best regards,
Tomasz
