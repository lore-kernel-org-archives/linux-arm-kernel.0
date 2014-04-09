From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 09 Apr 2014 13:10:33 +0200
Subject: [PATCH v4 2/5] dt: exynos5420: Enable support for USB 3.0 PHY
 controller
In-Reply-To: <1396967803-28868-3-git-send-email-gautam.vivek@samsung.com>
References: <1396967803-28868-1-git-send-email-gautam.vivek@samsung.com>
 <1396967803-28868-3-git-send-email-gautam.vivek@samsung.com>
Message-ID: <53452AA9.2090002@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.04.2014 16:36, Vivek Gautam wrote:
> Add device tree nodes for USB 3.0 PHY present alongwith
> USB 3.0 controller Exynos 5420 SoC. This phy driver is
> based on generic phy framework.
>
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
>   arch/arm/boot/dts/exynos5420.dtsi |   20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
> index 8db792b..a6efb52 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -652,4 +652,24 @@
>   		clocks = <&clock 319>, <&clock 318>;
>   		clock-names = "tmu_apbif", "tmu_triminfo_apbif";
>   	};
> +
> +	usbdrd_phy0: phy at 12100000 {
> +		compatible = "samsung,exynos5420-usbdrd-phy";
> +		reg = <0x12100000 0x100>;
> +		clocks = <&clock 366>, <&clock 1>, <&clock 152>;
> +		clock-names = "phy", "ref", "usb30_sclk_100m";

As I mentioned in another reply, please make sure that "usb30_sclk_100m" 
isn't simply a gate clock for "ref" clock.

Otherwise,

Reviewed-by: Tomasz Figa <t.figa@samsung.com>

--
Best regards,
Tomasz
