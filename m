From: cooloney@gmail.com (Bryan Wu)
Date: Fri, 31 May 2013 10:37:08 -0700
Subject: [PATCH] ARM: ux500: register LP5521 LEDs in the device tree
In-Reply-To: <1369210331-18545-1-git-send-email-linus.walleij@stericsson.com>
References: <1369210331-18545-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAK5ve-+oJL0fbtM=5xRSBjCztX1fP-fcwUvZurnj42hiXR5X+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 1:12 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> Based on pending device tree support in the LP55xx drivers
> we can add the correct LED and channel configuration from the
> ux500 device tree for all HREF variants.
>
> Cc: Milo Kim <Milo.Kim@ti.com>
> Cc: Bryan Wu <cooloney@gmail.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/boot/dts/href.dtsi | 38 ++++++++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/boot/dts/href.dtsi b/arch/arm/boot/dts/href.dtsi
> index 62523f6..e315429 100644
> --- a/arch/arm/boot/dts/href.dtsi
> +++ b/arch/arm/boot/dts/href.dtsi
> @@ -63,16 +63,42 @@
>                 };
>
>                 i2c at 80128000 {
> -                       lp5521 at 0x33 {
> -                               compatible = "lp5521";
> +                       lp5521 at 33 {

Is this right, I guess it should be still "lp5521 at 0x33", although it's
just a name.

-Bryan

> +                               compatible = "national,lp5521";
>                                 reg = <0x33>;
> +                               label = "lp5521_pri";
> +                               clock-mode = /bits/ 8 <2>;
> +                               chan0 {
> +                                       led-cur = /bits/ 8 <0x2f>;
> +                                       max-cur = /bits/ 8 <0x5f>;
> +                               };
> +                               chan1 {
> +                                       led-cur = /bits/ 8 <0x2f>;
> +                                       max-cur = /bits/ 8 <0x5f>;
> +                               };
> +                               chan2 {
> +                                       led-cur = /bits/ 8 <0x2f>;
> +                                       max-cur = /bits/ 8 <0x5f>;
> +                               };
>                         };
> -
> -                       lp5521 at 0x34 {
> -                               compatible = "lp5521";
> +                       lp5521 at 34 {
> +                               compatible = "national,lp5521";
>                                 reg = <0x34>;
> +                               label = "lp5521_sec";
> +                               clock-mode = /bits/ 8 <2>;
> +                               chan0 {
> +                                       led-cur = /bits/ 8 <0x2f>;
> +                                       max-cur = /bits/ 8 <0x5f>;
> +                               };
> +                               chan1 {
> +                                       led-cur = /bits/ 8 <0x2f>;
> +                                       max-cur = /bits/ 8 <0x5f>;
> +                               };
> +                               chan2 {
> +                                       led-cur = /bits/ 8 <0x2f>;
> +                                       max-cur = /bits/ 8 <0x5f>;
> +                               };
>                         };
> -
>                         bh1780 at 0x29 {
>                                 compatible = "rohm,bh1780gli";
>                                 reg = <0x33>;
> --
> 1.7.11.3
>
