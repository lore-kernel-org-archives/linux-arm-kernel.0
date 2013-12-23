From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 23 Dec 2013 11:30:51 +0800
Subject: [PATCH] ARM: dts: imx6q-sabrelite: PHY reset is active-low
In-Reply-To: <1387553117-30936-1-git-send-email-p.zabel@pengutronix.de>
References: <1387553117-30936-1-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20131223033049.GA26070@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 20, 2013 at 04:25:17PM +0100, Philipp Zabel wrote:
> Note that the fec driver code currently hard-codes an active-low
> reset, regardless of the flags in the device tree.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

The patch does not apply to my branch because of the sabrelite patches
from Troy Kisky recently.  But it's not hard for me to rebase and apply
it, so done so.

Shawn

> ---
>  arch/arm/boot/dts/imx6q-sabrelite.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
> index f004913..338d558 100644
> --- a/arch/arm/boot/dts/imx6q-sabrelite.dts
> +++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
> @@ -12,6 +12,7 @@
>  
>  /dts-v1/;
>  #include "imx6q.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
>  
>  / {
>  	model = "Freescale i.MX6 Quad SABRE Lite Board";
> @@ -89,7 +90,7 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_enet_1>;
>  	phy-mode = "rgmii";
> -	phy-reset-gpios = <&gpio3 23 0>;
> +	phy-reset-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
>  	status = "okay";
>  };
>  
> -- 
> 1.8.5.1
> 
