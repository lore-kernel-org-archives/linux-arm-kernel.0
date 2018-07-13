From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 13 Jul 2018 15:08:14 -0300
Subject: [PATCH] ARM: dts: imx6sx-udoo-neo: enable i2c-2 and i2c-4 for
 onboard sensors
In-Reply-To: <20180713171151.24699-1-pbrobinson@gmail.com>
References: <20180713171151.24699-1-pbrobinson@gmail.com>
Message-ID: <CAOMZO5B+1atjr3Ur7EGMJSEbqT8zqWdKZWNHrkyCGvgGM4nJFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On Fri, Jul 13, 2018 at 2:11 PM, Peter Robinson <pbrobinson@gmail.com> wrote:

> +&i2c4 { /* Onboard Motion sensors */
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c4>;
> +       clock-frequency = <100000>;
> +       status = "okay";
> +};

Would it be possible to add i2c4 to the common dtsi file instead?

I haven't checked the schematics, but if it is only the
imx6sx-udoo-neo-basic.dts that does not have the i2c4 node, then
maybe you could add i2c4 to the dtsi and disable it inside
imx6sx-udoo-neo-basic.dts?
