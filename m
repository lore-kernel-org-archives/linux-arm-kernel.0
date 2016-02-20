From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 20 Feb 2016 12:11:14 -0200
Subject: [PATCH 4/4] ARM: dts: imx6ul-geam: Add Engicam IMX6UL GEA M6UL
 initial support
In-Reply-To: <1455963652-24618-5-git-send-email-michael@amarulasolutions.com>
References: <1455963652-24618-1-git-send-email-michael@amarulasolutions.com>
 <1455963652-24618-5-git-send-email-michael@amarulasolutions.com>
Message-ID: <CAOMZO5AmePs3aE2zRSXcSS8iKQ0m2kvTAezsfHS13e-Zv1HCrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 20, 2016 at 8:20 AM, Michael Trimarchi
<michael@amarulasolutions.com> wrote:

> +       reg_1p8v: regulator-1p8v {
> +               compatible = "regulator-fixed";
> +               regulator-name = "1P8V";
> +               regulator-min-microvolt = <1800000>;
> +               regulator-max-microvolt = <1800000>;
> +               regulator-boot-on;
> +               regulator-always-on;

These last two properties can be removed.

> +       };
> +
> +       reg_3p3v: regulator-3p3v {
> +               compatible = "regulator-fixed";
> +               regulator-name = "3P3V";
> +               regulator-min-microvolt = <3300000>;
> +               regulator-max-microvolt = <3300000>;
> +               regulator-boot-on;
> +               regulator-always-on;

Ditto.

> +       pinctrl_spi4: spi4grp {
> +               fsl,pins = <
> +                       MX6UL_PAD_BOOT_MODE0__GPIO5_IO10        0x70a1
> +                       MX6UL_PAD_BOOT_MODE1__GPIO5_IO11        0x70a1
> +                       MX6UL_PAD_SNVS_TAMPER7__GPIO5_IO07      0x70a1
> +                       MX6UL_PAD_SNVS_TAMPER8__GPIO5_IO08      0x80000000
> +               >;
> +       };

pinctrl_spi4 seems to be unused.
