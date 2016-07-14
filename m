From: marex@denx.de (Marek Vasut)
Date: Thu, 14 Jul 2016 17:46:59 +0200
Subject: [PATCH 3/4] ARM: dts: at91: sama5d4_ma5d4: fix regulator names
In-Reply-To: <1468363508-23843-3-git-send-email-alexandre.belloni@free-electrons.com>
References: <1468363508-23843-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1468363508-23843-3-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <13a55675-36cb-5952-a3c9-5995776dcffa@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13/2016 12:45 AM, Alexandre Belloni wrote:
> vcc_3v3_reg and vcc_mmc1_reg are fixed regulators and don't need a
> reg property. Remove their unit-address.
>
> Solves:
> Warning (unit_address_vs_reg): Node /fixedregulator at 0 has a unit name, but no reg property
> Warning (unit_address_vs_reg): Node /fixedregulator at 1 has a unit name, but no reg property
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Reviewed-by: Marek Vasut <marex@denx.de>

> ---
> Cc: Marek Vasut <marex@denx.de>
>  arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi b/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
> index e7b2109fc85a..d9ca7f214677 100644
> --- a/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
> +++ b/arch/arm/boot/dts/at91-sama5d4_ma5d4.dtsi
> @@ -106,7 +106,7 @@
>  		};
>  	};
>
> -	vcc_3v3_reg: fixedregulator at 0 {
> +	vcc_3v3_reg: fixedregulator_3v3 {
>  		compatible = "regulator-fixed";
>  		regulator-name = "VCC 3V3";
>  		regulator-min-microvolt = <3300000>;
> @@ -115,7 +115,7 @@
>  		regulator-always-on;
>  	};
>
> -	vcc_mmc0_reg: fixedregulator at 1 {
> +	vcc_mmc0_reg: fixedregulator_mmc0 {
>  		compatible = "regulator-fixed";
>  		gpio = <&pioE 15 GPIO_ACTIVE_HIGH>;
>  		regulator-name = "RST_n MCI0";
>


-- 
Best regards,
Marek Vasut
