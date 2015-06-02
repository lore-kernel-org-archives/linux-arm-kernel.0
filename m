From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 2 Jun 2015 10:01:01 +0800
Subject: [linux-sunxi] [PATCH 2/2] ARM: dts: sun8i: Add usb_clk node for
 a23/a33
In-Reply-To: <1433183008-13086-2-git-send-email-hdegoede@redhat.com>
References: <1433183008-13086-1-git-send-email-hdegoede@redhat.com>
 <1433183008-13086-2-git-send-email-hdegoede@redhat.com>
Message-ID: <CAGb2v66C=a8SSL0miWYcGskymtex8PUoafzBoaCLgSXqHc6fyg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 2, 2015 at 2:23 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Add an usb_clk node for a23/a33.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> index c73d1d1..44dd7155 100644
> --- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> @@ -248,6 +248,16 @@
>                                              "mmc2_output",
>                                              "mmc2_sample";
>                 };
> +
> +               usb_clk: clk at 01c200cc {
> +                       #clock-cells = <1>;
> +                       #reset-cells = <1>;
> +                       compatible = "allwinner,sun8i-a23-usb-clk";
> +                       reg = <0x01c200cc 0x4>;
> +                       clocks = <&osc24M>;
> +                       clock-output-names = "usb_phy0", "usb_phy1", "hsic",
> +                                            "hsic_12m", "usb_ohci0";

Minor nitpicks:

"hsic_12m" should be "hsic_12M". And maybe add the "usb_" prefix
to the hsic clocks as well?

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>


P.S. There's a new linux-clk mailing list that these 2 patches should be
sent to as well.

> +               };
>         };
>
>         soc at 01c00000 {
> --
> 2.4.2
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
