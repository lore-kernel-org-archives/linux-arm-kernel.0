From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 25 May 2017 16:39:50 +0800
Subject: [linux-sunxi] [PATCH 2/2] ARM: sun8i: v3s: add pinmux for LCD
 pins of V3s SoC
In-Reply-To: <20170524111724.28431-2-icenowy@aosc.io>
References: <20170524111724.28431-1-icenowy@aosc.io>
 <20170524111724.28431-2-icenowy@aosc.io>
Message-ID: <CAGb2v65eC7eRn+JP_PZmF0w2e38rat5mta=xj9yamXQfB4mUsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 24, 2017 at 7:17 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> Allwinner V3s SoC features a set of pins that have functionality of RGB
> LCD, the pins are at different pin ban than other SoCs.
>
> Add pinctrl node for them.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  arch/arm/boot/dts/sun8i-v3s.dtsi | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
> index 3a06dc5b3746..81e5406661b4 100644
> --- a/arch/arm/boot/dts/sun8i-v3s.dtsi
> +++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
> @@ -297,6 +297,15 @@
>                                 function = "i2c0";
>                         };
>
> +                       lcd_rgb666_pins: lcd_rgb666 {

Please don't use underscores in the node name. Also, Please end the name
with -pins. The node name should at least have that to indicate what it is.

ChenYu

> +                               pins = "PE0", "PE1", "PE2", "PE3", "PE4",
> +                                      "PE5", "PE6", "PE7", "PE8", "PE9",
> +                                      "PE10", "PE11", "PE12", "PE13", "PE14",
> +                                      "PE15", "PE16", "PE17", "PE18", "PE19",
> +                                      "PE23", "PE24";
> +                               function = "lcd";
> +                       };
> +
>                         uart0_pins_a: uart0 at 0 {
>                                 pins = "PB8", "PB9";
>                                 function = "uart0";
> --
> 2.12.2
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
