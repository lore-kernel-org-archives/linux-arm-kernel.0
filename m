From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 3 Dec 2013 16:42:10 +0800
Subject: [PATCH] ARM: dts: i.MX51: Move include "imx51-pinfunc.h" into
 "imx51-pingrp.h"
In-Reply-To: <1385793344-24837-1-git-send-email-shc_work@mail.ru>
References: <1385793344-24837-1-git-send-email-shc_work@mail.ru>
Message-ID: <20131203084209.GH10840@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 30, 2013 at 10:35:44AM +0400, Alexander Shiyan wrote:
> Pin function definitions are used for pin groups definitions,
> so move the header in the "imx51-pingrp.h".

I'd like to see the same change for other IMX SoCs in one patch.

Shawn

> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/boot/dts/imx51-pingrp.h | 2 ++
>  arch/arm/boot/dts/imx51.dtsi     | 1 -
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx51-pingrp.h b/arch/arm/boot/dts/imx51-pingrp.h
> index 550d0d1..f63267b 100644
> --- a/arch/arm/boot/dts/imx51-pingrp.h
> +++ b/arch/arm/boot/dts/imx51-pingrp.h
> @@ -10,6 +10,8 @@
>  #ifndef __DTS_IMX51_PINGRP_H
>  #define __DTS_IMX51_PINGRP_H
>  
> +#include "imx51-pinfunc.h"
> +
>  #define MX51_AUDMUX_PINGRP1 \
>  	MX51_PAD_AUD3_BB_TXD__AUD3_TXD			0x80000000 \
>  	MX51_PAD_AUD3_BB_RXD__AUD3_RXD			0x80000000 \
> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> index cad5a56..61a2552 100644
> --- a/arch/arm/boot/dts/imx51.dtsi
> +++ b/arch/arm/boot/dts/imx51.dtsi
> @@ -11,7 +11,6 @@
>   */
>  
>  #include "skeleton.dtsi"
> -#include "imx51-pinfunc.h"
>  #include "imx51-pingrp.h"
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/clock/imx5-clock.h>
> -- 
> 1.8.3.2
> 
