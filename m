From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 16 Nov 2015 11:00:12 +0800
Subject: [linux-sunxi] [PATCH 5/5] ARM: dts: sun8i-h3-orangepi-plus:
 Enable USB host controllers
In-Reply-To: <1447616777-24660-5-git-send-email-hdegoede@redhat.com>
References: <1447616777-24660-1-git-send-email-hdegoede@redhat.com>
 <1447616777-24660-5-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v669Cu6+G=P8yH-g5KbOsWTHBgnYUYf2fGt+jKXbqVAKfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 16, 2015 at 3:46 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> From: Reinder de Haan <patchesrdh@mveas.com>
>
> Enable the 3 pairs of USB host controllers used on the Orange Pi Plus.
>
> Signed-off-by: Reinder de Haan <patchesrdh@mveas.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> index e67df59..e05a409 100644
> --- a/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-orangepi-plus.dts
> @@ -60,6 +60,18 @@
>         };
>  };
>
> +&ehci1 {
> +       status = "okay";
> +};
> +
> +&ehci2 {
> +       status = "okay";
> +};
> +
> +&ehci3 {
> +       status = "okay";
> +};
> +
>  &mmc0 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
> @@ -70,8 +82,24 @@
>         status = "okay";
>  };
>
> +&ohci1 {
> +       status = "okay";
> +};

This controller is connected to a FE1.1s USB 2.0 hub, giving us the
four usable external USB ports. We shouldn't need to enable OHCI.

> +
> +&ohci2 {
> +       status = "okay";
> +};

According to the schematics, this port is never used. Please remove.

> +&ohci3 {
> +       status = "okay";
> +};

This is connected to the GL830 USB-SATA bridge. Again, OHCI isn't
needed.

> +
>  &uart0 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&uart0_pins_a>;
>         status = "okay";
>  };
> +
> +&usbphy {
> +       status = "okay";

And what about power supplies / regulators?


Regards
ChenYu

> +};
> --
> 2.5.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
