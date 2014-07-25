From: dianders@chromium.org (Doug Anderson)
Date: Fri, 25 Jul 2014 09:02:56 -0700
Subject: [PATCH v2 3/4] ARM: dts: exynos5250: Fold common ChromeOS parts
 into Snow
In-Reply-To: <1405704009-8430-4-git-send-email-afaerber@suse.de>
References: <1405704009-8430-1-git-send-email-afaerber@suse.de>
 <1405704009-8430-4-git-send-email-afaerber@suse.de>
Message-ID: <CAD=FV=VK0KJknJ2099S7fEDzBnpPCrpSZ36WPkJB156GpcyEfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas,

On Fri, Jul 18, 2014 at 10:20 AM, Andreas F?rber <afaerber@suse.de> wrote:
> The remaining pieces are fairly minor.
>
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v2: New (Doug Anderson)
>
>  arch/arm/boot/dts/exynos5250-cros-common.dtsi | 164 -------------------------
>  arch/arm/boot/dts/exynos5250-snow.dts         | 169 ++++++++++++++++++++++----
>  2 files changed, 148 insertions(+), 185 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/exynos5250-cros-common.dtsi
>
> diff --git a/arch/arm/boot/dts/exynos5250-cros-common.dtsi b/arch/arm/boot/dts/exynos5250-cros-common.dtsi
> deleted file mode 100644
> index e603e9c..0000000
> --- a/arch/arm/boot/dts/exynos5250-cros-common.dtsi
> +++ /dev/null
> @@ -1,164 +0,0 @@
> -/*
> - * Common device tree include for all Exynos 5250 boards based off of Daisy.
> - *
> - * Copyright (c) 2012 Google, Inc
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> -*/
> -
> -/ {
> -       aliases {
> -       };
> -
> -       memory {
> -               reg = <0x40000000 0x80000000>;
> -       };
> -
> -       chosen {
> -       };
> -
> -       pinctrl at 11400000 {
> -               /*
> -                * Disabled pullups since external part has its own pullups and
> -                * double-pulling gets us out of spec in some cases.
> -                */
> -               i2c2_bus: i2c2-bus {
> -                       samsung,pin-pud = <0>;
> -               };
> -       };
> -
> -       i2c at 12C60000 {
> -               status = "okay";
> -               samsung,i2c-sda-delay = <100>;
> -               samsung,i2c-max-bus-freq = <378000>;
> -       };
> -
> -       i2c at 12C70000 {
> -               status = "okay";
> -               samsung,i2c-sda-delay = <100>;
> -               samsung,i2c-max-bus-freq = <378000>;
> -       };
> -
> -       i2c at 12C80000 {
> -               status = "okay";
> -               samsung,i2c-sda-delay = <100>;
> -               samsung,i2c-max-bus-freq = <66000>;
> -
> -               hdmiddc at 50 {
> -                       compatible = "samsung,exynos4210-hdmiddc";
> -                       reg = <0x50>;
> -               };
> -       };
> -
> -       i2c at 12C90000 {
> -               status = "okay";
> -               samsung,i2c-sda-delay = <100>;
> -               samsung,i2c-max-bus-freq = <66000>;
> -       };
> -
> -       i2c at 12CA0000 {
> -               status = "okay";
> -               samsung,i2c-sda-delay = <100>;
> -               samsung,i2c-max-bus-freq = <66000>;
> -       };
> -
> -       i2c at 12CB0000 {
> -               status = "okay";
> -               samsung,i2c-sda-delay = <100>;
> -               samsung,i2c-max-bus-freq = <66000>;
> -       };
> -
> -       i2c at 12CD0000 {
> -               status = "okay";
> -               samsung,i2c-sda-delay = <100>;
> -               samsung,i2c-max-bus-freq = <66000>;
> -       };
> -
> -       i2c at 12CE0000 {
> -               status = "okay";
> -               samsung,i2c-sda-delay = <100>;
> -               samsung,i2c-max-bus-freq = <378000>;
> -
> -               hdmiphy: hdmiphy at 38 {
> -                       compatible = "samsung,exynos4212-hdmiphy";
> -                       reg = <0x38>;
> -               };
> -       };
> -
> -       mmc at 12200000 {
> -               num-slots = <1>;
> -               supports-highspeed;
> -               broken-cd;
> -               card-detect-delay = <200>;
> -               samsung,dw-mshc-ciu-div = <3>;
> -               samsung,dw-mshc-sdr-timing = <2 3>;
> -               samsung,dw-mshc-ddr-timing = <1 2>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4 &sd0_bus8>;
> -
> -               slot at 0 {
> -                       reg = <0>;
> -                       bus-width = <8>;
> -               };
> -       };
> -
> -       mmc at 12220000 {
> -               num-slots = <1>;
> -               supports-highspeed;
> -               card-detect-delay = <200>;
> -               samsung,dw-mshc-ciu-div = <3>;
> -               samsung,dw-mshc-sdr-timing = <2 3>;
> -               samsung,dw-mshc-ddr-timing = <1 2>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
> -
> -               slot at 0 {
> -                       reg = <0>;
> -                       bus-width = <4>;
> -                       wp-gpios = <&gpc2 1 0>;
> -               };
> -       };
> -
> -       mmc at 12230000 {
> -               num-slots = <1>;
> -               supports-highspeed;
> -               broken-cd;
> -               card-detect-delay = <200>;
> -               samsung,dw-mshc-ciu-div = <3>;
> -               samsung,dw-mshc-sdr-timing = <2 3>;
> -               samsung,dw-mshc-ddr-timing = <1 2>;
> -               /* See board-specific dts files for pin setup */
> -
> -               slot at 0 {
> -                       reg = <0>;
> -                       bus-width = <4>;
> -               };
> -       };
> -
> -       spi_1: spi at 12d30000 {
> -               status = "okay";
> -               samsung,spi-src-clk = <0>;
> -               num-cs = <1>;
> -       };
> -
> -       hdmi {
> -               hpd-gpio = <&gpx3 7 0>;
> -               pinctrl-names = "default";
> -               pinctrl-0 = <&hdmi_hpd_irq>;
> -               phy = <&hdmiphy>;
> -               ddc = <&i2c_2>;
> -       };
> -
> -       gpio-keys {
> -               compatible = "gpio-keys";
> -
> -               power {
> -                       label = "Power";
> -                       gpios = <&gpx1 3 1>;
> -                       linux,code = <116>; /* KEY_POWER */
> -                       gpio-key,wakeup;
> -               };
> -       };
> -};
> diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
> index f2b8c41..cdf74c5 100644
> --- a/arch/arm/boot/dts/exynos5250-snow.dts
> +++ b/arch/arm/boot/dts/exynos5250-snow.dts
> @@ -10,7 +10,6 @@
>
>  /dts-v1/;
>  #include "exynos5250.dtsi"
> -#include "exynos5250-cros-common.dtsi"
>
>  / {
>         model = "Google Snow";
> @@ -20,6 +19,13 @@
>                 i2c104 = &i2c_104;
>         };
>
> +       memory {
> +               reg = <0x40000000 0x80000000>;
> +       };
> +
> +       chosen {
> +       };
> +
>         rtc at 101E0000 {
>                 status = "okay";
>         };
> @@ -93,6 +99,13 @@
>         gpio-keys {
>                 compatible = "gpio-keys";
>
> +               power {
> +                       label = "Power";
> +                       gpios = <&gpx1 3 1>;
> +                       linux,code = <116>; /* KEY_POWER */
> +                       gpio-key,wakeup;
> +               };
> +
>                 lid-switch {
>                         label = "Lid";
>                         gpios = <&gpx3 5 1>;
> @@ -226,26 +239,6 @@
>                 };
>         };
>
> -       mmc at 12200000 {
> -               status = "okay";
> -       };
> -
> -       mmc at 12220000 {
> -               status = "okay";
> -       };
> -
> -       /*
> -        * On Snow we've got SIP WiFi and so can keep drive strengths low to
> -        * reduce EMI.
> -        */
> -       mmc at 12230000 {
> -               status = "okay";
> -               slot at 0 {
> -                       pinctrl-names = "default";
> -                       pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4>;
> -               };
> -       };
> -
>         i2c at 12CD0000 {
>                 max98095: codec at 11 {
>                         compatible = "maxim,max98095";
> @@ -314,6 +307,14 @@
>                 samsung,invert-vclk;
>         };
>
> +       hdmi {
> +               hpd-gpio = <&gpx3 7 0>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&hdmi_hpd_irq>;
> +               phy = <&hdmiphy>;
> +               ddc = <&i2c_2>;
> +       };
> +
>         dp-controller at 145B0000 {
>                 status = "okay";
>                 pinctrl-names = "default";
> @@ -345,6 +346,10 @@
>  };
>
>  &i2c_0 {
> +       status = "okay";
> +       samsung,i2c-sda-delay = <100>;
> +       samsung,i2c-max-bus-freq = <378000>;
> +
>         max77686 at 09 {
>                 compatible = "maxim,max77686";
>                 interrupt-parent = <&gpx3>;
> @@ -491,6 +496,10 @@
>  };
>
>  &i2c_1 {
> +       status = "okay";
> +       samsung,i2c-sda-delay = <100>;
> +       samsung,i2c-max-bus-freq = <378000>;
> +
>         trackpad {
>                 reg = <0x67>;
>                 compatible = "cypress,cyapa";
> @@ -500,7 +509,119 @@
>         };
>  };
>
> +&i2c_2 {
> +       status = "okay";
> +       samsung,i2c-sda-delay = <100>;
> +       samsung,i2c-max-bus-freq = <66000>;
> +
> +       hdmiddc at 50 {
> +               compatible = "samsung,exynos4210-hdmiddc";
> +               reg = <0x50>;
> +       };
> +};
> +
> +&i2c_3 {
> +       status = "okay";
> +       samsung,i2c-sda-delay = <100>;
> +       samsung,i2c-max-bus-freq = <66000>;
> +};
> +
> +&i2c_4 {
> +       status = "okay";
> +       samsung,i2c-sda-delay = <100>;
> +       samsung,i2c-max-bus-freq = <66000>;
> +};
> +
> +&i2c_5 {
> +       status = "okay";
> +       samsung,i2c-sda-delay = <100>;
> +       samsung,i2c-max-bus-freq = <66000>;
> +};
> +
> +&i2c_7 {
> +       status = "okay";
> +       samsung,i2c-sda-delay = <100>;
> +       samsung,i2c-max-bus-freq = <66000>;
> +};
> +
> +&i2c_8 {
> +       status = "okay";
> +       samsung,i2c-sda-delay = <100>;
> +       samsung,i2c-max-bus-freq = <378000>;
> +
> +       hdmiphy: hdmiphy at 38 {
> +               compatible = "samsung,exynos4212-hdmiphy";
> +               reg = <0x38>;
> +       };
> +};
> +
> +&mmc_0 {
> +       status = "okay";
> +       num-slots = <1>;
> +       supports-highspeed;
> +       broken-cd;
> +       card-detect-delay = <200>;
> +       samsung,dw-mshc-ciu-div = <3>;
> +       samsung,dw-mshc-sdr-timing = <2 3>;
> +       samsung,dw-mshc-ddr-timing = <1 2>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4 &sd0_bus8>;
> +
> +       slot at 0 {
> +               reg = <0>;
> +               bus-width = <8>;
> +       };
> +};
> +
> +&mmc_2 {
> +       status = "okay";
> +       num-slots = <1>;
> +       supports-highspeed;
> +       card-detect-delay = <200>;
> +       samsung,dw-mshc-ciu-div = <3>;
> +       samsung,dw-mshc-sdr-timing = <2 3>;
> +       samsung,dw-mshc-ddr-timing = <1 2>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
> +
> +       slot at 0 {
> +               reg = <0>;
> +               bus-width = <4>;
> +               wp-gpios = <&gpc2 1 0>;
> +       };
> +};
> +
> +/*
> + * On Snow we've got SIP WiFi and so can keep drive strengths low to
> + * reduce EMI.
> + */
> +&mmc_3 {
> +       status = "okay";
> +       num-slots = <1>;
> +       supports-highspeed;
> +       broken-cd;
> +       card-detect-delay = <200>;
> +       samsung,dw-mshc-ciu-div = <3>;
> +       samsung,dw-mshc-sdr-timing = <2 3>;
> +       samsung,dw-mshc-ddr-timing = <1 2>;
> +
> +       slot at 0 {
> +               reg = <0>;
> +               bus-width = <4>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&sd3_clk &sd3_cmd &sd3_bus4>;

This actually looks like a bug on snow.  I don't think these pinctrl
statements are taking effect and I think they belong at the mmc level,
not the slot level.  That's not a new bug introduced by you, though.
Mind fixing it?  You've already got it right for Spring mmc_1.


> +       };
> +};
> +
>  &pinctrl_0 {
> +       /*
> +        * Disabled pullups since external part has its own pullups and
> +        * double-pulling gets us out of spec in some cases.
> +        */
> +       i2c2_bus: i2c2-bus {
> +               samsung,pin-pud = <0>;
> +       };
> +
>         max77686_irq: max77686-irq {
>                 samsung,pins = "gpx3-2";
>                 samsung,pin-function = <0>;
> @@ -509,4 +630,10 @@
>         };
>  };
>
> +&spi_1 {
> +       status = "okay";
> +       samsung,spi-src-clk = <0>;
> +       num-cs = <1>;
> +};
> +
>  #include "cros-ec-keyboard.dtsi"
> --
> 1.9.3
>
