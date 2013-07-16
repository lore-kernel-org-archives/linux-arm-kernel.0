From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Tue, 16 Jul 2013 16:51:13 +0300
Subject: [PATCH V2] ARM: tegra: enable palmas device for dalmore
In-Reply-To: <1373441852-27176-1-git-send-email-ldewangan@nvidia.com>
References: <1373441852-27176-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <51E54FD1.1010404@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10/2013 10:37 AM, Laxman Dewangan wrote:
> Make the entry of Dalmore Power Management Unit device TPS65913
> in dalmore DTS file. The Palma driver support this device.
>
> Enable following submodule of the TPS65913:
> - GPIO driver
> - RTC driver.
> - Power regulator driver.
>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> ---
> Changes from V1:
> - renames nodes from palams_* to simple as gpio, rtc, pmic etc.
> - Added line gap properly.
> - Remove comment for palams-gpio reference as the entry itself explain.
> - Remove unit address for tps65913.
>
>   arch/arm/boot/dts/tegra114-dalmore.dts |  184 +++++++++++++++++++++++++++++++-
>   1 files changed, 183 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
> index a42bfa4..7bdad77 100644
> --- a/arch/arm/boot/dts/tegra114-dalmore.dts
> +++ b/arch/arm/boot/dts/tegra114-dalmore.dts
> @@ -791,7 +791,7 @@
>   					regulator-boot-on;
>   				};
>
> -				dcdc3 {
> +				tps65090_dcdc3_reg: dcdc3 {
>   					regulator-name = "vdd-ao";
>   					regulator-always-on;
>   					regulator-boot-on;
> @@ -836,6 +836,178 @@
>   				};
>   			};
>   		};
> +
> +		palmas: tps65913 {
> +			compatible = "ti,palmas";
> +			reg = <0x58>;
> +			interrupts = <0 86 0x4>;
> +
> +			#interrupt-cells = <2>;
> +			interrupt-controller;
> +
> +			palmas_gpio: gpio {
> +				compatible = "ti,palmas-gpio";
> +				gpio-controller;
> +				#gpio-cells = <2>;
> +			};

I don't think the palmas-gpio driver ever gets probed since it doesn't
have device tree compability strings?

> ...
