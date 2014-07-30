From: dianders@google.com (Doug Anderson)
Date: Wed, 30 Jul 2014 09:02:00 -0700
Subject: [PATCHv8 2/5] ARM: dts: exynos: unuse the slot-node and
 deprecated the supports-highspeed for dw-mmc
In-Reply-To: <1406718310-32078-3-git-send-email-jh80.chung@samsung.com>
References: <1406718310-32078-1-git-send-email-jh80.chung@samsung.com>
 <1406718310-32078-3-git-send-email-jh80.chung@samsung.com>
Message-ID: <CAD=FV=X3rZGfKHTTYHj5Va0e3X4Ebteo9GMtVPBYeY=v2yoPww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jaehoon,

On Wed, Jul 30, 2014 at 4:05 AM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
> index d0de1f5..42a3590 100644
> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
> @@ -401,7 +401,6 @@
>         mmc_0: mmc at 12200000 {
>                 status = "okay";
>                 num-slots = <1>;
> -               supports-highspeed;
>                 broken-cd;
>                 card-detect-delay = <200>;
>                 samsung,dw-mshc-ciu-div = <3>;
> @@ -410,17 +409,13 @@
>                 vmmc-supply = <&mmc_reg>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
> -
> -               slot at 0 {
> -                       reg = <0>;
> -                       bus-width = <8>;
> -               };
> +               bus-width = <8>;
> +               cap-mmc-highspeed;
>         };
>
>         mmc_2: mmc at 12220000 {
>                 status = "okay";
>                 num-slots = <1>;
> -               supports-highspeed;
>                 card-detect-delay = <200>;
>                 samsung,dw-mshc-ciu-div = <3>;
>                 samsung,dw-mshc-sdr-timing = <2 3>;
> @@ -428,12 +423,9 @@
>                 vmmc-supply = <&mmc_reg>;
>                 pinctrl-names = "default";
>                 pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
> -
> -               slot at 0 {
> -                       reg = <0>;
> -                       bus-width = <4>;
> -                       disable-wp;
> -               };
> +               bus-width = <4>;
> +               disable-wp;
> +               cap-sd-highspeed;

It seems like you ought to include cap-mmc-highspeed in addition to
cap-sd-highspeed, but I could be wrong.  I know that I have some
full-sized MMC cards (not eMMC) that can be plugged into an SD card
slot.  I know that the SD/MMC slot on this port only has 4 pins on
exynos5250, but I think you can still run MMC highspeed on 4 pins,
right?

-Doug
