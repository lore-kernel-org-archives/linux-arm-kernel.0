From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 25 Apr 2018 18:46:13 -0300
Subject: [PATCH V4 3/6] ARM: dts: imx6sx-sabreauto: add IO expander
 max7310 support
In-Reply-To: <1524634571-5914-3-git-send-email-Anson.Huang@nxp.com>
References: <1524634571-5914-1-git-send-email-Anson.Huang@nxp.com>
 <1524634571-5914-3-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5Dm6rcEe=zAJ9_nqKce3g2tdyWPqb=Uv-N5nfc_96jc-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 2:36 AM, Anson Huang <Anson.Huang@nxp.com> wrote:

> +&i2c3 {
> +       clock-frequency = <100000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c3_2>;
> +       status = "okay";
> +
> +       max7310_a: gpio at 30 {
> +               compatible = "maxim,max7310";
> +               reg = <0x30>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +       };
> +
> +       max7310_b: gpio at 32 {
> +               compatible = "maxim,max7310";
> +               reg = <0x32>;
> +               gpio-controller;
> +               #gpio-cells = <2>;
> +       };

Please also add the users for the MAX7310 pins, such as Ethernet PHY.
