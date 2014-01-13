From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 13 Jan 2014 12:50:30 +0800
Subject: [PATCH] ARM: dts: i.MX51: Switch to use standard definitions for
 input subsystem
In-Reply-To: <1389423259-28870-1-git-send-email-shc_work@mail.ru>
References: <1389423259-28870-1-git-send-email-shc_work@mail.ru>
Message-ID: <20140113045028.GN23525@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 11, 2014 at 10:54:19AM +0400, Alexander Shiyan wrote:
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Applied, thanks.

Shawn

> ---
>  arch/arm/boot/dts/imx51-babbage.dts | 34 ++++++++++++++++++----------------
>  arch/arm/boot/dts/imx51.dtsi        |  3 ++-
>  2 files changed, 20 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
> index 483178a..587ee58 100644
> --- a/arch/arm/boot/dts/imx51-babbage.dts
> +++ b/arch/arm/boot/dts/imx51-babbage.dts
> @@ -388,21 +388,23 @@
>  &kpp {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_kpp>;
> -	linux,keymap = <0x00000067	/* KEY_UP */
> -			0x0001006c	/* KEY_DOWN */
> -			0x00020072	/* KEY_VOLUMEDOWN */
> -			0x00030066	/* KEY_HOME */
> -			0x0100006a	/* KEY_RIGHT */
> -			0x01010069	/* KEY_LEFT */
> -			0x0102001c	/* KEY_ENTER */
> -			0x01030073	/* KEY_VOLUMEUP */
> -			0x02000040	/* KEY_F6 */
> -			0x02010042	/* KEY_F8 */
> -			0x02020043	/* KEY_F9 */
> -			0x02030044	/* KEY_F10 */
> -			0x0300003b	/* KEY_F1 */
> -			0x0301003c	/* KEY_F2 */
> -			0x0302003d	/* KEY_F3 */
> -			0x03030074>;	/* KEY_POWER */
> +	linux,keymap = <
> +		MATRIX_KEY(0, 0, KEY_UP)
> +		MATRIX_KEY(0, 1, KEY_DOWN)
> +		MATRIX_KEY(0, 2, KEY_VOLUMEDOWN)
> +		MATRIX_KEY(0, 3, KEY_HOME)
> +		MATRIX_KEY(1, 0, KEY_RIGHT)
> +		MATRIX_KEY(1, 1, KEY_LEFT)
> +		MATRIX_KEY(1, 2, KEY_ENTER)
> +		MATRIX_KEY(1, 3, KEY_VOLUMEUP)
> +		MATRIX_KEY(2, 0, KEY_F6)
> +		MATRIX_KEY(2, 1, KEY_F8)
> +		MATRIX_KEY(2, 2, KEY_F9)
> +		MATRIX_KEY(2, 3, KEY_F10)
> +		MATRIX_KEY(3, 0, KEY_F1)
> +		MATRIX_KEY(3, 1, KEY_F2)
> +		MATRIX_KEY(3, 2, KEY_F3)
> +		MATRIX_KEY(3, 3, KEY_POWER)
> +		>;
>  	status = "okay";
>  };
> diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
> index 61a2552..bced7bc 100644
> --- a/arch/arm/boot/dts/imx51.dtsi
> +++ b/arch/arm/boot/dts/imx51.dtsi
> @@ -12,9 +12,10 @@
>  
>  #include "skeleton.dtsi"
>  #include "imx51-pingrp.h"
> -#include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/clock/imx5-clock.h>
>  #include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
>  
>  / {
>  	aliases {
> -- 
> 1.8.3.2
> 
