From: carlo@caione.org (Carlo Caione)
Date: Mon, 12 Oct 2015 21:15:42 +0200
Subject: [PATCH 1/1] ARM: meson: Add status LED for Odroid-C1
In-Reply-To: <1444401430-4396-2-git-send-email-edward.cragg@codethink.co.uk>
References: <1444401430-4396-1-git-send-email-edward.cragg@codethink.co.uk>
 <1444401430-4396-2-git-send-email-edward.cragg@codethink.co.uk>
Message-ID: <CAOQ7t2b050HE10hdPprWwnpbCkx5b4APxexwtsSWtJ7zcX_exw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 9, 2015 at 4:37 PM, Edward Cragg
<edward.cragg@codethink.co.uk> wrote:
> Add the blue status LED to the Hardkernel Odroid C1 board DTS.
> This is the only programmable LED on the board.
>
> Signed-off-by: Edward Cragg <edward.cragg@codethink.co.uk>
> ---
>  arch/arm/boot/dts/meson8b-odroidc1.dts | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
> index a8e2911..3b03523 100644
> --- a/arch/arm/boot/dts/meson8b-odroidc1.dts
> +++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
> @@ -1,6 +1,8 @@
>  /*
>   * Copyright 2015 Endless Mobile, Inc.
>   * Author: Carlo Caione <carlo@endlessm.com>
> + * Copyright 2015 Codethink Ltd.
> + * Author: Edward Cragg <edward.cragg@codethink.co.uk>

Usually we do not add a copyright line for each small addition to the DTS.

>   *
>   * This file is dual-licensed: you can use it either under the terms
>   * of the GPL or the X11 license, at your option. Note that this dual
> @@ -46,6 +48,7 @@
>
>  /dts-v1/;
>  #include "meson8b.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
>
>  / {
>         model = "Hardkernel ODROID-C1";
> @@ -58,6 +61,16 @@
>         memory {
>                 reg = <0x40000000 0x40000000>;
>         };
> +
> +       leds {
> +               compatible = "gpio-leds";
> +               blue {
> +                       label = "c1:blue:alive";
> +                       gpios = <&gpio_ao GPIOAO_13 GPIO_ACTIVE_LOW>;
> +                       linux,default-trigger = "heartbeat";
> +                       default-state = "off";
> +               };
> +       };
>  };

otherwise Acked-by: Carlo Caione <carlo@endlessm.com>

-- 
Carlo Caione
