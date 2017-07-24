From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 24 Jul 2017 09:49:56 -0300
Subject: [PATCH 1/2] ARM: dts: imx6qdl-sabrelite: fix USB PHY reset
In-Reply-To: <20170724085005.22101-2-gary.bisson@boundarydevices.com>
References: <20170724085005.22101-1-gary.bisson@boundarydevices.com>
 <20170724085005.22101-2-gary.bisson@boundarydevices.com>
Message-ID: <CAOMZO5C2kzvT7UYw8Zw8ztr1w6_C=MjcFPgU1Wfgjrag=dVwbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gary,

On Mon, Jul 24, 2017 at 5:50 AM, Gary Bisson
<gary.bisson@boundarydevices.com> wrote:

> +
> +               reg_usb_h1_vbus: regulator at 7 {
> +                       compatible = "regulator-fixed";
> +                       reg = <7>;
> +                       pinctrl-names = "default";
> +                       pinctrl-0 = <&pinctrl_usbh1>;
> +                       regulator-name = "usb_h1_vbus";
> +                       regulator-min-microvolt = <3300000>;
> +                       regulator-max-microvolt = <3300000>;
> +                       gpio = <&gpio7 12 GPIO_ACTIVE_HIGH>;
> +                       enable-active-high;
> +                       regulator-always-on;

As this regulator is controlled via GPIO I believe you should remove
the ' regulator-always-on' property.

Same applies to 2/2/
