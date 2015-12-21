From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 21 Dec 2015 13:58:22 +0800
Subject: [PATCH 3/5] ARM: dts: sun4i: Add touchscreen node to inet97fv2
 dts file
In-Reply-To: <1450611782-9494-3-git-send-email-hdegoede@redhat.com>
References: <1450611782-9494-1-git-send-email-hdegoede@redhat.com>
 <1450611782-9494-3-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v67yDOwWWw=qK7tjw3Bf0UrGADPUDdH4UVBiuRG=-zjvug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 20, 2015 at 7:43 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Add a node describing the focaltech ft5306de4 touchscreen found on
> inet97fv2 tablets.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun4i-a10-inet97fv2.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
> index 77c31da..74dd458 100644
> --- a/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-inet97fv2.dts
> @@ -48,6 +48,7 @@
>
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
>
>  / {
>         model = "INet-97F Rev 02";
> @@ -93,6 +94,16 @@
>         pinctrl-names = "default";
>         pinctrl-0 = <&i2c2_pins_a>;
>         status = "okay";
> +
> +       ft5406ee8: touchscreen at 38 {
> +               compatible = "edt,edt-ft5406";
> +               reg = <0x38>;
> +               interrupt-parent = <&pio>;
> +               interrupts = <7 21 IRQ_TYPE_EDGE_FALLING>;
> +               pinctrl-names = "default";

Name only and no references?

ChenYu

> +               touchscreen-size-x = <800>;
> +               touchscreen-size-y = <480>;
> +       };
>  };
>
>  &lradc {
> --
> 2.5.0
>
