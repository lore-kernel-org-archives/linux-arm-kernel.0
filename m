From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 22 May 2014 14:50:47 +0200
Subject: [PATCH 2/2] ARM: shmobile: marzen dts: Remove superfluous include
In-Reply-To: <1400761997-13512-3-git-send-email-geert+renesas@glider.be>
References: <1400761997-13512-1-git-send-email-geert+renesas@glider.be>
 <1400761997-13512-3-git-send-email-geert+renesas@glider.be>
Message-ID: <2352184.UXetcfavus@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

Thank you for the patch.

On Thursday 22 May 2014 14:33:17 Geert Uytterhoeven wrote:
> <dt-bindings/interrupt-controller/irq.h> is already included by
> r8a7779.dtsi.

Isn't it better, like with C code, to explicitly include headers that provide 
the macros you need, instead of relying on implicit #include's that could 
change later ? OK, in this specific case, it's very unlikely that r8a7779.dtsi 
would stop including <dt-bindings/interrupt-controller/irq.h>, but in the 
general case I believe explicit includes to be good practice.

> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  arch/arm/boot/dts/r8a7779-marzen.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts
> b/arch/arm/boot/dts/r8a7779-marzen.dts index 321290828eee..649129906d6f
> 100644
> --- a/arch/arm/boot/dts/r8a7779-marzen.dts
> +++ b/arch/arm/boot/dts/r8a7779-marzen.dts
> @@ -12,7 +12,6 @@
>  /dts-v1/;
>  #include "r8a7779.dtsi"
>  #include <dt-bindings/gpio/gpio.h>
> -#include <dt-bindings/interrupt-controller/irq.h>
> 
>  / {
>  	model = "marzen";

-- 
Regards,

Laurent Pinchart
