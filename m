From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 13 Apr 2017 19:20:13 -0300
Subject: [PATCH 6/8] ARM: dts: imx7d-sdb: Add GPIO expander node
In-Reply-To: <20170413133242.5068-7-andrew.smirnov@gmail.com>
References: <20170413133242.5068-1-andrew.smirnov@gmail.com>
 <20170413133242.5068-7-andrew.smirnov@gmail.com>
Message-ID: <CAOMZO5A9u9bjbFa=0LQ_gnwFry4wm2HGD8xncThb3ta1TaZ1aw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrey,

On Thu, Apr 13, 2017 at 10:32 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:

> diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
> index 5be01a1..e0ff276 100644
> --- a/arch/arm/boot/dts/imx7d-sdb.dts
> +++ b/arch/arm/boot/dts/imx7d-sdb.dts
> @@ -52,6 +52,30 @@
>                 reg = <0x80000000 0x80000000>;
>         };
>
> +       spi4 {

Here you use spi4 label...

> +               compatible = "spi-gpio";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_spi1>;

and here spi1, which is a bit confusing.

> +               status = "okay";
> +               gpio-sck = <&gpio1 13 0>;
> +               gpio-mosi = <&gpio1 9 0>;
> +               cs-gpios = <&gpio1 12 0>;

You could use GPIO_ACTIVE_HIGH flag for better readability.
