From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 22 Sep 2014 15:41:43 +0900
Subject: [PATCH 1/2] ARM: dts: Add rtc_src clk for s3c-rtc on exynos Peach
 boards
In-Reply-To: <1410954633-27025-2-git-send-email-javier.martinez@collabora.co.uk>
References: <1410954633-27025-1-git-send-email-javier.martinez@collabora.co.uk>
 <1410954633-27025-2-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <541FC4A7.3010901@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Javier,

On 09/17/2014 08:50 PM, Javier Martinez Canillas wrote:
> commit 546b117fdf17 ("rtc: s3c: add support for RTC of Exynos3250 SoC")
> added an "rtc_src" DT property for the Samsung's S3C Real Time Clock
> controller that specifies the 32.768 kHz clock that uses the RTC as its
> source clock. In the case of the Peach Pit and Pi machines, the Maxim
> 77802 32kHz AP clock is used as the source clock.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/boot/dts/exynos5420-peach-pit.dts | 5 ++++-
>  arch/arm/boot/dts/exynos5800-peach-pi.dts  | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> index 9a23382..bfd189e 100644
> --- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
> +++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
> @@ -12,6 +12,7 @@
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/clock/maxim,max77802.h>
>  #include "exynos5420.dtsi"
>  
>  / {
> @@ -151,7 +152,7 @@
>  	status = "okay";
>  	clock-frequency = <400000>;
>  
> -	max77802-pmic at 9 {
> +	max77802: max77802-pmic at 9 {
>  		compatible = "maxim,max77802";
>  		interrupt-parent = <&gpx3>;
>  		interrupts = <1 IRQ_TYPE_NONE>;
> @@ -727,6 +728,8 @@
>  
>  &rtc {
>  	status = "okay";
> +	clocks = <&clock CLK_RTC>, <&max77802 MAX77802_CLK_32K_AP>;
> +	clock-names = "rtc", "rtc_src";
>  };
>  
>  &spi_2 {
> diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> index 1d31c81..84ec1ce 100644
> --- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
> +++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
> @@ -12,6 +12,7 @@
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/clock/maxim,max77802.h>
>  #include "exynos5800.dtsi"
>  
>  / {
> @@ -150,7 +151,7 @@
>  	status = "okay";
>  	clock-frequency = <400000>;
>  
> -	max77802-pmic at 9 {
> +	max77802: max77802-pmic at 9 {
>  		compatible = "maxim,max77802";
>  		interrupt-parent = <&gpx3>;
>  		interrupts = <1 IRQ_TYPE_NONE>;
> @@ -715,6 +716,8 @@
>  
>  &rtc {
>  	status = "okay";
> +	clocks = <&clock CLK_RTC>, <&max77802 MAX77802_CLK_32K_AP>;
> +	clock-names = "rtc", "rtc_src";
>  };
>  
>  &spi_2 {
> 

I'm so sorry for delay reply because I'm out of office for vacation (9/5 ~ 9/20).
Looks goot to me for this patch.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
