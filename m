From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 7 Nov 2016 19:44:11 +0200
Subject: [PATCH 6/6] ARM: dts: Extend the S3C RTC node with rtc_src clock
In-Reply-To: <1478513376-14307-7-git-send-email-pankaj.dubey@samsung.com>
References: <1478513376-14307-1-git-send-email-pankaj.dubey@samsung.com>
 <1478513376-14307-7-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20161107174411.GC4865@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 07, 2016 at 03:39:36PM +0530, Pankaj Dubey wrote:
> Extend the S3C RTC node with rtc_src clock so it could be operational.
> The rtc_src clock is provided by MAX8997.
> 
> CC: Rob Herring <robh+dt@kernel.org>
> CC: devicetree at vger.kernel.org
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/boot/dts/exynos4210-origen.dts | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/exynos4210-origen.dts b/arch/arm/boot/dts/exynos4210-origen.dts
> index 6c7ef4e..4cac9b6 100644
> --- a/arch/arm/boot/dts/exynos4210-origen.dts
> +++ b/arch/arm/boot/dts/exynos4210-origen.dts
> @@ -18,6 +18,7 @@
>  #include "exynos4210.dtsi"
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/clock/maxim,max8997.h>

Just a nit: put the system-wide includes in alphabetical order, so
clock, gpio and finally input. It helps reducing conflicting changes
(when more people add includes in the same time).

Beside that, looks good, but it requires a dt-bindings in separate patch
so I could pull it.

Best regards,
Krzysztof
