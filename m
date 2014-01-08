From: bcm@fixthebug.org (Christian Daudt)
Date: Wed, 8 Jan 2014 15:38:49 -0800
Subject: [RESEND PATCH] ARM: dts: bcm28155-ap: Fix Card Detection GPIO
In-Reply-To: <1389120821-12007-1-git-send-email-tim.kryger@linaro.org>
References: <1389120821-12007-1-git-send-email-tim.kryger@linaro.org>
Message-ID: <CAEPRUYo0r5YcRTYdgSNLqedVV4D0bsor7USBoxRRpBXRs7wpbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 7, 2014 at 10:53 AM, Tim Kryger <tim.kryger@linaro.org> wrote:
> The board schematic states that the "SD_CARD_DET_N gets pulled to GND
> when card is inserted" so the polarity has been updated to active low.
>
> Polarity is now specified with a GPIO define instead of a magic number.
>
> Signed-off-by: Tim Kryger <tim.kryger@linaro.org>
> Reviewed-by: Matt Porter <matt.porter@linaro.org>
> ---
>  arch/arm/boot/dts/bcm28155-ap.dts | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/bcm28155-ap.dts b/arch/arm/boot/dts/bcm28155-ap.dts
> index 08e47c2..27dd110 100644
> --- a/arch/arm/boot/dts/bcm28155-ap.dts
> +++ b/arch/arm/boot/dts/bcm28155-ap.dts
> @@ -13,6 +13,8 @@
>
>  /dts-v1/;
>
> +#include <dt-bindings/gpio/gpio.h>
> +
>  #include "bcm11351.dtsi"
>
>  / {
> @@ -40,7 +42,7 @@
>
>         sdio4: sdio at 3f1b0000 {
>                 max-frequency = <48000000>;
> -               cd-gpios = <&gpio 14 0>;
> +               cd-gpios = <&gpio 14 GPIO_ACTIVE_LOW>;
>                 status = "okay";
>         };
>  };
> --
> 1.8.0.1
>
Tim,
 Does bcm11351-brt not also suffer from the same bug? If it does can
you pls update the patch to also fix it?

 Thanks,
   csd
