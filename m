From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 20 Oct 2016 17:04:46 +0800
Subject: [RESEND PATCH v3 2/2] ARM: dts: imx6ul: Add DTS for liteBoard
In-Reply-To: <20160930093626.3843-2-m.niestroj@grinn-global.com>
References: <20160930093626.3843-1-m.niestroj@grinn-global.com>
 <20160930093626.3843-2-m.niestroj@grinn-global.com>
Message-ID: <CAJBJ56K53ua4htobTUQN2eQgvdqwtCjpmEXOWEr1YDn-BUmmSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 30, 2016 at 5:36 PM, Marcin Niestroj
<m.niestroj@grinn-global.com> wrote:
> +       regulators {
> +               compatible = "simple-bus";
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               reg_usb_otg1_vbus: usb_otg1_regulator {
> +                       compatible = "regulator-fixed";
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&pinctrl_usb_otg1_vbus>;
> +                       regulator-name = "usb_otg1_vbus";
> +                       regulator-min-microvolt = <5000000>;
> +                       regulator-max-microvolt = <5000000>;
> +                       gpio = <&gpio2 8 GPIO_ACTIVE_LOW>;
> +               };
> +       };

Please put it directly under root in the following naming schema to
save that fake simple-bus container node.

        reg_xxx: regulator-xxx {
                ...
        }

Note: underscore is in label name, while hyphen is in node name.

Shawn

> +};
