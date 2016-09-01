From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 01 Sep 2016 12:59:41 +0200
Subject: [PATCH 5/6] ARM: dts: s3c2416: Use macros for pinctrl
 configuration
In-Reply-To: <1472721715-2833-6-git-send-email-k.kozlowski@samsung.com>
References: <1472721715-2833-1-git-send-email-k.kozlowski@samsung.com>
 <1472721715-2833-6-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1608454.1ZuTJsprje@amdc1976>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Thursday, September 01, 2016 11:21:54 AM Krzysztof Kozlowski wrote:
> Usage of DTS macros instead of hard-coded numbers makes code easier
> to read.  One does not have to remember which value means pull-up/down
> or specific driver strength.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/boot/dts/s3c2416-pinctrl.dtsi | 38 ++++++++++++++++++----------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/s3c2416-pinctrl.dtsi b/arch/arm/boot/dts/s3c2416-pinctrl.dtsi
> index 527e3193817f..6274359fb323 100644
> --- a/arch/arm/boot/dts/s3c2416-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/s3c2416-pinctrl.dtsi
> @@ -8,6 +8,8 @@
>   * published by the Free Software Foundation.
>   */
>  
> +#include <dt-bindings/pinctrl/samsung.h>
> +
>  &pinctrl_0 {
>  	/*
>  	 * Pin banks
> @@ -83,91 +85,91 @@
>  
>  	uart0_data: uart0-data {
>  		samsung,pins = "gph-0", "gph-1";
> -		samsung,pin-function = <2>;
> +		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;

Shouldn't macros that are also used by s3c* be named as
SAMSUNG_PIN_FUNC_2 etc. (s3c* SoCs are not Exynos)?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
