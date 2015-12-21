From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 21 Dec 2015 13:57:51 +0800
Subject: [PATCH 1/5] ARM: dts: sun4i: Add touchscreen node to inet9f-rev03
 tablet dts file
In-Reply-To: <1450611782-9494-1-git-send-email-hdegoede@redhat.com>
References: <1450611782-9494-1-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v67tBGSZTwVk4uQ97tqah3x83xFEPJn=rM-dBV9xgyFMAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 20, 2015 at 7:42 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> Add a node describing the focaltech ft5406ee8 touchscreen found on
> inet-9f-rev03 / qware qw tb-g100 tablets.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
> index ca49b0d..d39067e 100644
> --- a/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-inet9f-rev03.dts
> @@ -253,6 +253,16 @@
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
