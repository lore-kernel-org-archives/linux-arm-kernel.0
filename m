From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 20 Nov 2014 09:36:39 +0530
Subject: [2/2] ARM: dts: Add missing irq pinctrl for max77686 on smdk5250
In-Reply-To: <1416312509-11530-2-git-send-email-yadi.brar@samsung.com>
References: <1416312509-11530-2-git-send-email-yadi.brar@samsung.com>
Message-ID: <546D68CF.1080103@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tuesday 18 November 2014 05:38 PM, Yadwinder Singh Brar wrote:
> This patch adds pinctrl configuration for using configuring gpx3-2 as an
> external interrupt from max77686. Though max77686 RTC is enabled and gets
> probed by default, it doesnt work as its unable to get interrupt.
>
> This patch makes max77686 RTC work and also configures it as wakeup source.
>
> Signed-off-by: Yadwinder Singh Brar <yadi.brar@samsung.com>
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
>

Tested this on SMDK5250, and with this PMIC RTC is working fine.

Tested-by: Pankaj Dubey <pankaj.dubey@samsung.com>

Thanks,
Pankaj Dubey
> ---
> arch/arm/boot/dts/exynos5250-smdk5250.dts |   12 ++++++++++++
>   1 files changed, 12 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index 95b5b51..19cd918 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -131,6 +131,9 @@
>   		reg = <0x09>;
>   		interrupt-parent = <&gpx3>;
>   		interrupts = <2 IRQ_TYPE_NONE>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&max77686_irq>;
> +		wakeup-source;
>
>   		voltage-regulators {
>   			ldo1_reg: LDO1 {
> @@ -411,3 +414,12 @@
>   		};
>   	};
>   };
> +
> +&pinctrl_0 {
> +	max77686_irq: max77686-irq {
> +		samsung,pins = "gpx3-2";
> +		samsung,pin-function = <0xf>;
> +		samsung,pin-pud = <0>;
> +		samsung,pin-drv = <0>;
> +	};
> +};
>
