From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 05 Sep 2013 11:55:52 +0200
Subject: [PATCH 2/2] arm: dt: Exynos5420: populate cpu node enteries to 8
 cpus
In-Reply-To: <1378373086-30676-3-git-send-email-chander.kashyap@linaro.org>
References: <1378373086-30676-1-git-send-email-chander.kashyap@linaro.org>
 <1378373086-30676-3-git-send-email-chander.kashyap@linaro.org>
Message-ID: <3875313.jvPsk6a1oV@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chander,

On Thursday 05 of September 2013 14:54:46 Chander Kashyap wrote:
> Exynos5420 is octacore SoC from samsung.
> Hence populate all the cpu node enteries.
> 
> Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
> ---
>  arch/arm/boot/dts/exynos5420.dtsi |   28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos5420.dtsi
> b/arch/arm/boot/dts/exynos5420.dtsi index e97c87b..59489f6 100644
> --- a/arch/arm/boot/dts/exynos5420.dtsi
> +++ b/arch/arm/boot/dts/exynos5420.dtsi
> @@ -57,6 +57,34 @@
>  			reg = <0x3>;
>  			clock-frequency = <1800000000>;
>  		};
> +
> +		cpu4: cpu at 4 {

I believe this is a typo. The @unit-address suffix should match the value 
of reg property.

> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x100>;
> +			clock-frequency = <1000000000>;
> +		};
> +
> +		cpu5: cpu at 5 {

Ditto.

> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x101>;
> +			clock-frequency = <1000000000>;
> +		};
> +
> +		cpu6: cpu at 6 {

Ditto.

> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x102>;
> +			clock-frequency = <1000000000>;
> +		};
> +
> +		cpu7: cpu at 7 {

Ditto.

> +			device_type = "cpu";
> +			compatible = "arm,cortex-a7";
> +			reg = <0x103>;
> +			clock-frequency = <1000000000>;
> +		};
>  	};

Best regards,
Tomasz
