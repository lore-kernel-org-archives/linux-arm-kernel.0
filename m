From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 30 Jul 2018 10:45:19 +0200
Subject: [PATCH] ARM: dts: sun8i: Add initial Orangepi Zero Plus 2 H3
 support
In-Reply-To: <20180727125739.22871-1-diego.rondini@kynetics.com>
References: <20180727125739.22871-1-diego.rondini@kynetics.com>
Message-ID: <20180730084519.iqyhvocxsfuopze7@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 02:57:39PM +0200, Diego Rondini wrote:
> +/dts-v1/;
> +
> +#include "sun8i-h3.dtsi"
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "OrangePi Zero Plus2 H3";
> +	compatible = "xunlong,orangepi-zero-plus2", "allwinner,sun8i-h3";

The H5 version doesn't make that easy, and it's unfortunate, but we
should have a different compatible for the H3 and H5 versions.

What about something like xunlong,orangepi-zero-plus2-h3?

> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
> +	status = "okay";
> +};

I guess it is the BT chip? Which chip is it?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180730/6a698a51/attachment.sig>
