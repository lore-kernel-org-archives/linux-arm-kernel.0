From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 16 Nov 2015 10:41:45 +0800
Subject: [linux-sunxi] [PATCH 3/5] ARM: dts: sun8i: Add support for H3 usb
 clocks
In-Reply-To: <1447616777-24660-3-git-send-email-hdegoede@redhat.com>
References: <1447616777-24660-1-git-send-email-hdegoede@redhat.com>
 <1447616777-24660-3-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v65H0FbyeX4KuymuCQpYEZsv=GfigVkD4bA0_OGxyX2gVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 3:46 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> From: Reinder de Haan <patchesrdh@mveas.com>
>
> Add a node describing the usb-clks found on the H3.
>
> Signed-off-by: Reinder de Haan <patchesrdh@mveas.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>

(Also updated Mike's email in my reply.)

> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index c18b5f7..22ff593 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -266,6 +266,18 @@
>                                              "mmc2_sample";
>                 };
>
> +               usb_clk: clk at 01c200cc {
> +                       #clock-cells = <1>;
> +                       #reset-cells = <1>;
> +                       compatible = "allwinner,sun8i-h3-usb-clk";
> +                       reg = <0x01c200cc 0x4>;
> +                       clocks = <&osc24M>;
> +                       clock-output-names = "usb_phy0", "usb_phy1",
> +                                            "usb_phy2", "usb_phy3",
> +                                            "usb_ohci0", "usb_ohci1",
> +                                            "usb_ohci2", "usb_ohci3";
> +               };
> +
>                 mbus_clk: clk at 01c2015c {
>                         #clock-cells = <0>;
>                         compatible = "allwinner,sun8i-a23-mbus-clk";
> --
> 2.5.0
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
