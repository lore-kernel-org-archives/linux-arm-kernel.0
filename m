From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 23 Oct 2018 09:28:44 -0300
Subject: [PATCH V2 7/8] dts: fsl: add imx7ulp evk support
In-Reply-To: <1540295058-26090-8-git-send-email-aisheng.dong@nxp.com>
References: <1540295058-26090-1-git-send-email-aisheng.dong@nxp.com>
 <1540295058-26090-8-git-send-email-aisheng.dong@nxp.com>
Message-ID: <CAOMZO5C3Fv+s-bLeHGZ6LEB=ZqRxf=gXuzbtwfNS=PvQeVJ1Ag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2018 at 8:56 AM A.s. Dong <aisheng.dong@nxp.com> wrote:

> +/ {
> +       model = "NXP i.MX7ULP EVK";
> +       compatible = "fsl,imx7ulp-evk", "fsl,imx7ulp", "Generic DT based system";

This "Generic DT based system" should be removed.

> +       chosen {
> +               stdout-path = &lpuart4;
> +       };
> +
> +       memory at 60000000 {

       device_type = "memory";
> +               reg = <0x60000000 0x40000000>;
> +       };

> +&iomuxc1 {
> +       pinctrl_lpuart4: lpuart4grp {
> +               pinmux = <
> +                       IMX7ULP_PAD_PTC3__LPUART4_RX
> +                       IMX7ULP_PAD_PTC2__LPUART4_TX
> +               >;
> +               bias-pull-up;

Please change the mx7ulp pinctrl driver to accept the "old" notation
and change the dts to use:

IMX7ULP_PAD_PTC3__LPUART4_RX 0x3

This way we use the same method for all i.MX devices.
