From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Tue, 5 Jul 2016 09:03:02 -0400
Subject: [PATCH] arm64: dts: Fix rtc by providing rtc_src clock
In-Reply-To: <1467713107-15932-1-git-send-email-alim.akhtar@samsung.com>
References: <1467713107-15932-1-git-send-email-alim.akhtar@samsung.com>
Message-ID: <caea8f78-be5e-233f-c475-41c2973761ae@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Alim,

On 07/05/2016 06:05 AM, Alim Akhtar wrote:
> Add rtc source clock as exynos7 needs source (32.768KHz) clock
> for rtc block. Without this currently rtc driver probe is broken
> on this SoC, thats because rtc-s3c driver expect rtc_src clock to
> be provided for _s3c6410-rtc_ type rtc controllers.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> index 03f9cf6..7f48cf0 100644
> --- a/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> +++ b/arch/arm64/boot/dts/exynos/exynos7-espresso.dts
> @@ -12,6 +12,7 @@
>  /dts-v1/;
>  #include "exynos7.dtsi"
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/clock/samsung,s2mps11.h>
>  
>  / {
>  	model = "Samsung Exynos7 Espresso board based on EXYNOS7";
> @@ -44,6 +45,8 @@
>  
>  &rtc {
>  	status = "okay";
> +	clocks = <&clock_ccore PCLK_RTC>, <&s2mps15_osc S2MPS11_CLK_AP>;
> +	clock-names = "rtc", "rtc_src";
>  };
>  
>  &watchdog {
> 

Looks good to me.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
