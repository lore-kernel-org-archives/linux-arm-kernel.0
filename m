From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 01 Apr 2016 17:17:16 +0900
Subject: [PATCH 04/11] ARM: dts: exynos: Fix DTC unit name warnings in
 Trats2 board
In-Reply-To: <1459493874-2366-4-git-send-email-k.kozlowski@samsung.com>
References: <1459493874-2366-1-git-send-email-k.kozlowski@samsung.com>
 <1459493874-2366-4-git-send-email-k.kozlowski@samsung.com>
Message-ID: <56FE2E8C.3060107@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01.04.2016 15:57, Krzysztof Kozlowski wrote:
> Fix following DTC warnings in Trats2 board:
> 
> Warning (unit_address_vs_reg): Node /memory has a reg or ranges property, but no unit name
> Warning (unit_address_vs_reg): Node /i2c-gpio-1/max77693 at 66/regulators/ESAFEOUT1 at 1 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /i2c-gpio-1/max77693 at 66/regulators/ESAFEOUT2 at 2 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /i2c-gpio-1/max77693 at 66/regulators/CHARGER at 0 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /thermistor-ap at 0 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /thermistor-battery at 1 has a unit name, but no reg property
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4412-trats2.dts | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos4412-trats2.dts b/arch/arm/boot/dts/exynos4412-trats2.dts
> index 2bf363c3bf62..523627003738 100644
> --- a/arch/arm/boot/dts/exynos4412-trats2.dts
> +++ b/arch/arm/boot/dts/exynos4412-trats2.dts
> @@ -29,7 +29,7 @@
>  		i2c12 = &i2c_max77693_fuel;
>  	};
>  
> -	memory {
> +	mmemory at 40000000 {
>  		reg =  <0x40000000 0x40000000>;
>  	};

Nope, beside obvious typo here, this is bad. This causes creation of
duplicated memory nodes, one coming from skeleton and one from here.

Rob,
How the 'memory' node warning should be fixed?


Best regards,
Krzysztof
