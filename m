From: marex@denx.de (Marek Vasut)
Date: Thu, 14 Jul 2016 17:47:07 +0200
Subject: [PATCH 4/4] ARM: dts: at91: sama5d4_ma5d4evk: fix regulator names
In-Reply-To: <1468363508-23843-4-git-send-email-alexandre.belloni@free-electrons.com>
References: <1468363508-23843-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1468363508-23843-4-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <35bca3f8-30b9-8ae7-495e-4c0a2d371f10@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13/2016 12:45 AM, Alexandre Belloni wrote:
> vcc_mmc1_reg is a fixed regulators and doesn't need a reg property. Remove
> its unit-address.
>
> Solves:
> Warning (unit_address_vs_reg): Node /fixedregulator at 2 has a unit name, but no reg property
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Reviewed-by: Marek Vasut <marex@denx.de>

> ---
> Cc: Marek Vasut <marex@denx.de>
>  arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts b/arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts
> index abaaba58fbec..eac4ea2744cc 100644
> --- a/arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts
> +++ b/arch/arm/boot/dts/at91-sama5d4_ma5d4evk.dts
> @@ -159,7 +159,7 @@
>  		};
>  	};
>
> -	vcc_mmc1_reg: fixedregulator at 2 {
> +	vcc_mmc1_reg: fixedregulator_mmc1 {
>  		compatible = "regulator-fixed";
>  		gpio = <&pioE 17 GPIO_ACTIVE_LOW>;
>  		regulator-name = "VDD MCI1";
>


-- 
Best regards,
Marek Vasut
