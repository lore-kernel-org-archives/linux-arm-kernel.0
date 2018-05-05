From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 5 May 2018 08:56:07 -0300
Subject: [PATCH V6 7/7] ARM: dts: imx6sx-sabreauto: add egalax touch
 screen support
In-Reply-To: <1525508963-7986-7-git-send-email-Anson.Huang@nxp.com>
References: <1525508963-7986-1-git-send-email-Anson.Huang@nxp.com>
 <1525508963-7986-7-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5D1H4+w=FGh+8icBziunDzM4jN7peA=mirGb9RBHHqMsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

On Sat, May 5, 2018 at 5:29 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> Add egalax touch screen support on i2c2 bus.
>
> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>

Is Haibo the author of this patch? If so, his name should appear in
the From field.

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> changes since V5:
>         improve pinctrl node name and touchscreen node name.
>  arch/arm/boot/dts/imx6sx-sabreauto.dts | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/arch/arm/boot/dts/imx6sx-sabreauto.dts b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> index 1dc5b58..3fe41d3 100644
> --- a/arch/arm/boot/dts/imx6sx-sabreauto.dts
> +++ b/arch/arm/boot/dts/imx6sx-sabreauto.dts
> @@ -122,6 +122,12 @@
>  };
>
>  &iomuxc {
> +       pinctrl_egalax_int: egalax-intgrp {
> +               fsl,pins = <
> +                       MX6SX_PAD_SD4_RESET_B__GPIO6_IO_22      0x80000000
> +               >;
> +       };
> +
>         pinctrl_enet1: enet1grp {
>                 fsl,pins = <
>                         MX6SX_PAD_ENET1_MDIO__ENET1_MDIO        0xa0b1
> @@ -264,6 +270,16 @@
>         pinctrl-0 = <&pinctrl_i2c2>;
>         status = "okay";
>
> +       egalax_touchscreen at 4 {

Should be touchscreen at 4.
