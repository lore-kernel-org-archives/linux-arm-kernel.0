From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 30 Apr 2015 13:46:55 -0300
Subject: [PATCH] ARM: dts: Gateworks GW5510 support (i.MX6)
In-Reply-To: <1430409691-15963-1-git-send-email-tharvey@gateworks.com>
References: <1430409691-15963-1-git-send-email-tharvey@gateworks.com>
Message-ID: <CAOMZO5Aa67XvmgBU0ABVZSE36V_=Hj2PMsW=TDbxzNr4Ka_GsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tim,

On Thu, Apr 30, 2015 at 1:01 PM, Tim Harvey <tharvey@gateworks.com> wrote:

> +++ b/arch/arm/boot/dts/imx6dl-gw551x.dts
> @@ -0,0 +1,19 @@
> +/*
> + * Copyright 2014 Gateworks Corporation
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */

The recommendation for new dts files is to use a dual-license type scheme.

Please check imx6sl-warp for an example.

> +       regulators {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               reg_5p0v: regulator at 0 {
> +                       compatible = "regulator-fixed";
> +                       reg = <0>;
> +                       regulator-name = "5P0V";
> +                       regulator-min-microvolt = <5000000>;
> +                       regulator-max-microvolt = <5000000>;
> +                       regulator-always-on;

This ' regulator-always-on' can be removed. Same applies to the other
occurrences.
