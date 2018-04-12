From: cphealy@gmail.com (Chris Healy)
Date: Thu, 12 Apr 2018 07:15:36 -0700
Subject: [PATCH 3/3] ARM: dts: imx6: RDU2: add eGalax touchscreen
In-Reply-To: <20180412131556.11073-3-l.stach@pengutronix.de>
References: <20180412131556.11073-1-l.stach@pengutronix.de>
 <20180412131556.11073-3-l.stach@pengutronix.de>
Message-ID: <CAFXsbZqxoSTKcP+P8jFw8TG68coJ2w2C_BCDrPAiRHkTQLgYWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested-by: Chris Healy <cphealy@gmail.com>


On Thu, Apr 12, 2018 at 6:15 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> This touchscreen is present instead of the RMI4 touch on some SKUs of
> the RDU2. Keep it disabled by default, the bootloader will enable it
> instead of the RMI4 touch when running on one of those units.
>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> index 4bc14b8e9a66..4aade2bca670 100644
> --- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
> @@ -573,6 +573,17 @@
>                 };
>         };
>
> +       touchscreen at 2a {
> +               compatible = "eeti,egalax_ts";
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&pinctrl_ts>;
> +               reg = <0x2a>;
> +               interrupt-parent = <&gpio1>;
> +               interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
> +               wakeup-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
> +               status = "disabled";
> +       };
> +
>         hpa1: amp at 60 {
>                 compatible = "ti,tpa6130a2";
>                 pinctrl-names = "default";
> --
> 2.16.3
>
