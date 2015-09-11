From: Wenyou.Yang@atmel.com (Yang, Wenyou)
Date: Fri, 11 Sep 2015 00:40:04 +0000
Subject: [PATCH] ARM: at91/dt: sama5d3 xplained: disable pmic
In-Reply-To: <1441897131-6686-1-git-send-email-nicolas.ferre@atmel.com>
References: <1441897131-6686-1-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <B256D81BAE5131468A838E5D7A243641C9FA3D5B@penmbx01>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Nicolas Ferre [mailto:nicolas.ferre at atmel.com]
> Sent: 2015?9?10? 22:59
> To: Yang, Wenyou; Alexandre Belloni; Jean-Christophe PLAGNIOL-VILLARD
> Cc: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Ferre,
> Nicolas
> Subject: [PATCH] ARM: at91/dt: sama5d3 xplained: disable pmic
> 
> As PMIC act8865 can disturb communication on i2c1, and as it should be setup
> correctly then its i2c interface disabled by bootloader, we simply disregard it in DT.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Indeed,

Acked-by: Wenyou Yang <wenyou.yang@atmel.com>

> ---
>  arch/arm/boot/dts/at91-sama5d3_xplained.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-
> sama5d3_xplained.dts
> index d81474e0bcd6..8488ac53d22d 100644
> --- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
> @@ -76,7 +76,7 @@
>  				pmic: act8865 at 5b {
>  					compatible = "active-semi,act8865";
>  					reg = <0x5b>;
> -					status = "okay";
> +					status = "disabled";
> 
>  					regulators {
>  						vcc_1v8_reg: DCDC_REG1 {
> --
> 2.1.3

Best Regards,
Wenyou Yang
