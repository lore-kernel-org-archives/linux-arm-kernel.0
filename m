From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 13 Jun 2014 12:15:21 -0300
Subject: [PATCH 1/2] ARM: i.MX: Migrate Freescale i.MX27 IP Camera board
 to devicetree
In-Reply-To: <1402642578-2456-1-git-send-email-shc_work@mail.ru>
References: <1402642578-2456-1-git-send-email-shc_work@mail.ru>
Message-ID: <CAOMZO5A7xVYNMCMnSjvhXCCU28ADXFq9idbRkFBvcs3U4jssGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 13, 2014 at 3:56 AM, Alexander Shiyan <shc_work@mail.ru> wrote:

> +       regulators {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               reg_5v0: regulator at 0 {
> +                       compatible = "regulator-fixed";
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&pinctrl_reg5v0>;
> +                       reg = <0>;
> +                       regulator-name = "5V0";
> +                       regulator-min-microvolt = <5000000>;
> +                       regulator-max-microvolt = <5000000>;
> +                       gpio = <&gpio6 9 GPIO_ACTIVE_HIGH>;
> +                       regulator-always-on;
> +               };

I don't see this reg_5v0 regulator being referenced anywhere.

Anyway, I am fine if you simply drop the board support file for the mx27 ipcam.

No need to add a dts for it, as I don't have access to this board anymore.
