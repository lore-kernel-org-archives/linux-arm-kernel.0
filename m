From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 31 May 2016 15:36:04 -0400
Subject: [PATCH 5/6] ARM: dts: exynos: Configure PWM, usb3503, PMIC and
 thermal on Odroid XU board
In-Reply-To: <1464719945-3417-5-git-send-email-krzk@kernel.org>
References: <1464719945-3417-1-git-send-email-krzk@kernel.org>
 <1464719945-3417-5-git-send-email-krzk@kernel.org>
Message-ID: <1ec0f7fc-f6e0-e4d6-e424-43289bf31b16@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/31/2016 02:39 PM, Krzysztof Kozlowski wrote:
> Extend the DTS for Exynos5410-based Odroid XU board with:
> 1. Proper PWM outputs,
> 2. usb3503 USB HUB (with integrated LAN9730 ethernet adapter (smsc95xx)),
> 3. Maxim 77802 PMIC (regulators, 32 kHz clocks, RTC),
> 4. CPU thermal (trip points are the same as in Odroid XU3/XU4 but
>    cooling maps are different as there is no CPU freq and only one
>    cluster available for now),
> 5. Regulator supplies for USB 3.0.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> ---
> 

[snip]

> +
> +			ldo10_reg: LDO10 {
> +				regulator-name = "vdd18_mipi";
> +				regulator-min-microvolt = <1800000>;
> +				regulator-max-microvolt = <1800000>;
> +				regulator-always-on;
> +			};
> +

[snip]

> +
> +			ldo12_reg: LDO12 {
> +				regulator-name = "vdd33_usb3";
> +				regulator-min-microvolt = <3300000>;
> +				regulator-max-microvolt = <3300000>;
> +				regulator-always-on;
> +			};
> +

[snip]

> +
> +			ldo15_reg: LDO15 {
> +				regulator-name = "vdd10_usb3";
> +				regulator-min-microvolt = <1000000>;
> +				regulator-max-microvolt = <1000000>;
> +				regulator-always-on;
> +			};
> +

I see that LDO 10, 12 and 15 are used by still marked as always-on. Did
you try not marking as always-on those or that also causes issues like
in the other regulators were you added comments about being always-on?

Besides that, patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
