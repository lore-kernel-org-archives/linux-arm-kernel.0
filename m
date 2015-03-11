From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 11 Mar 2015 18:52:27 +0100
Subject: [PATCH] ARM: Kirkwood: remove leds-netxbig.h include from nas2big
 DTS
In-Reply-To: <1426068221-29025-1-git-send-email-simon.guinot@sequanux.org>
References: <1426068221-29025-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <550080DB.70007@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,



On 11/03/2015 11:03, Simon Guinot wrote:
> This patch fixes the following build error introduced by the patch
> a9e58557e998 ("ARM: Kirkwood: add DT description for nas2big"):
> 
>   DTC     arch/arm/boot/dts/kirkwood-nas2big.dtb
> /home/simon/workspace/lacie-nas.org/src/linux-lacie.git/arch/arm/boot/dts/kirkwood-nas2big.dts:16:
> fatal error: dt-bindings/leds/leds-netxbig.h: No such file or directory
> compilation terminated.
> scripts/Makefile.lib:292: recipe for target
> 'arch/arm/boot/dts/kirkwood-nas2big.dtb' failed
> 
> Since the leds-netxbig DT binding is not merged yet, the
> dt-bindings/leds/leds-netxbig.h header can't be used. Moreover there is
> no point in including leds-netxbig.h from the nas2big DTS anyway: since
> the LEDs characteristics are shared between all the netxbig boards, the
> LED node will be added in the kirkwood-netxbig DTSI file.
> 
> This patch fixes the build error by removing the useless leds-netxbig.h
> include.


I squashed it in the previous commit (a9e58557e998 ("ARM: Kirkwood: add DT
description for nas2big") in mvebu/dt and merged this branch in mvebu/for-next.
So the build would be OK in next-20150312.


Thanks,

Gregory


> 
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> ---
>  arch/arm/boot/dts/kirkwood-nas2big.dts | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-nas2big.dts b/arch/arm/boot/dts/kirkwood-nas2big.dts
> index d459c94fd1d4..7427ec50b829 100644
> --- a/arch/arm/boot/dts/kirkwood-nas2big.dts
> +++ b/arch/arm/boot/dts/kirkwood-nas2big.dts
> @@ -12,7 +12,6 @@
>  
>  /dts-v1/;
>  
> -#include <dt-bindings/leds/leds-netxbig.h>
>  #include "kirkwood-netxbig.dtsi"
>  
>  / {
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
