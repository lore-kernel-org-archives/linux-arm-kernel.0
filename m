From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 13 Dec 2014 10:06:04 +0800
Subject: [PATCHv3 5/5] ARM: sunxi: dts: Add note ps2 pins conflict with
 hdmi
In-Reply-To: <1418408748-9797-6-git-send-email-vishnupatekar0510@gmail.com>
References: <1418408748-9797-1-git-send-email-vishnupatekar0510@gmail.com>
 <1418408748-9797-6-git-send-email-vishnupatekar0510@gmail.com>
Message-ID: <CAGb2v65xpUhiMzSKu_1+JGNbg3oFdpw2EQ+JGUYkivCtG2O6gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Dec 13, 2014 at 2:25 AM, VishnuPatekar
<vishnupatekar0510@gmail.com> wrote:
> 1. Please note that ps20 pins conflict with HDMI on Lime2 Board
> so, by deault ps20 and ps21 are disabled for Lime2 Board.
> There is no on board ps2 connector and these pins can be used
> for different purpose.
>
> Signed-off-by: VishnuPatekar <vishnupatekar0510@gmail.com>
> ---
>  arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> index ed364d5..951b615 100644
> --- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> +++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
> @@ -112,7 +112,11 @@
>                         pinctrl-0 = <&uart0_pins_a>;
>                         status = "okay";
>                 };
> -
> +
> +               /* PS2 0 and PS2 1 are disabled by default; Please note that
> +               ps20 pins conflict with HDMI on Lime2 Board
> +               */
> +

Multi-line comments should be:

/*
 * line 1
 * line 2
 * ...
 */

And why is there a delete and insert for an empty line?
Weird... though git seems to ignore it when applying.

ChenYu

>                 i2c0: i2c at 01c2ac00 {
>                         pinctrl-names = "default";
>                         pinctrl-0 = <&i2c0_pins_a>;
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
