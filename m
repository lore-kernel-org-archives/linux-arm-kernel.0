From: michael@amarulasolutions.com (Michael Trimarchi)
Date: Wed, 25 Nov 2015 19:14:13 +0100
Subject: [PATCH V3] ARM: dts: imx6q-icore-rqs: Add Engicam IMX6 Q7 initial
 support
In-Reply-To: <20151118151030.GA11558@panicking>
References: <1447584853-12560-1-git-send-email-michael@amarulasolutions.com>
 <1447665552.3144.6.camel@pengutronix.de>
 <20151116112931.GA10464@panicking>
 <1447673895.3144.16.camel@pengutronix.de>
 <20151116114127.GB10464@panicking>
 <1447674695.3144.21.camel@pengutronix.de>
 <20151116115421.GC10464@panicking> <20151116172318.GA513@panicking>
 <1447752697.3144.47.camel@pengutronix.de>
 <20151118151030.GA11558@panicking>
Message-ID: <CAOf5uw=q7fwh93w7LUQaAV3-+YLDwzL65wB1WB5L2BKUe+Vtpg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn

On Wed, Nov 18, 2015 at 4:10 PM, Michael Trimarchi
<michael@amarulasolutions.com> wrote:
> www.engicam.com/en/products/embedded/som/standard/i-core-rqs-m6s-dl-d-q
>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
> I'm not quite sure how ethernet tuning parameter
> are working in other setup and this seems the
> correct way to use it
>

As you can see my way to connect the ethernet phy is different. I have
seen that most of the boards put all the tuning under fec but unfortunately
this does not work. I don't know if people check if their value are correctly
written to the phy.

> +
> +&fec {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_enet_3>;
> +       phy-handle = <&eth_phy>;
> +       phy-mode = "rgmii";
> +       status = "okay";
> +       mdio {
> +               eth_phy: ethernet-phy {
> +                       rxc-skew-ps = <1140>;
> +                       txc-skew-ps = <1140>;
> +                       txen-skew-ps = <600>;
> +                       rxdv-skew-ps = <240>;
> +                       rxd0-skew-ps = <420>;
> +                       rxd1-skew-ps = <600>;
> +                       rxd2-skew-ps = <420>;
> +                       rxd3-skew-ps = <240>;
> +                       txd0-skew-ps = <60>;
> +                       txd1-skew-ps = <60>;
> +                       txd2-skew-ps = <60>;
> +                       txd3-skew-ps = <240>;
> +               };
> +       };
> +};
> +

Michael


> +&i2c1 {
> +       status = "okay";
> +       clock-frequency = <100000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c1_1>;
> +};
> +
> +&i2c2 {
> +       clock-frequency = <100000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c2_2>;
> +       status = "okay";
> +};
> +
> +&i2c3 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c3_4>;
> +       status = "okay";
> +};
> +
> +&pcie {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_pcie>;
> +       reset-gpio = <&gpio3 29 GPIO_ACTIVE_LOW>;
> +       status = "okay";
> +};
> +
> +&ssi1 {
> +       fsl,mode = "i2s-slave";
> +       status = "okay";
> +};
> +
> +&uart4 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_uart4_1>;
> +       status = "okay";
> +};
> +
> +&usbh1 {
> +       vbus-supply = <&reg_usb_h1_vbus>;
> +       disable-over-current;
> +       clocks = <&clks IMX6QDL_CLK_USBOH3>;
> +       status = "okay";
> +};
> +
> +&usbotg {
> +       vbus-supply = <&reg_usb_otg_vbus>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_usbotg_2>;
> +       disable-over-current;
> +       status = "okay";
> +};
> +
> +&usdhc1 {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_usdhc1_1>;
> +       no-1-8-v;
> +       status = "okay";
> +};
> +
> +&usdhc3 {
> +       pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +       pinctrl-0 = <&pinctrl_usdhc3_2>;
> +       pinctrl-1 = <&pinctrl_usdhc3_2_100mhz>;
> +       pinctrl-2 = <&pinctrl_usdhc3_2_200mhz>;
> +       vmcc-supply = <&reg_sd3_vmmc>;
> +       cd-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
> +       bus-witdh=<4>;
> +       no-1-8-v;
> +       status = "okay";
> +};
> +
> +&usdhc4 {
> +       pinctrl-names = "default", "state_100mhz", "state_200mhz";
> +       pinctrl-0 = <&pinctrl_usdhc4_1>;
> +       pinctrl-1 = <&pinctrl_usdhc4_1_100mhz>;
> +       pinctrl-2 = <&pinctrl_usdhc4_1_200mhz>;
> +       vmcc-supply = <&reg_sd4_vmmc>;
> +       bus-witdh=<8>;
> +       no-1-8-v;
> +       non-removable;
> +       status = "okay";
> +};
> --
> 2.6.3
>
> --
> | Michael Nazzareno Trimarchi                     Amarula Solutions BV |
> | COO  -  Founder                                      Cruquiuskade 47 |
> | +31(0)851119172                                 Amsterdam 1018 AM NL |
> |                  [`as] http://www.amarulasolutions.com               |



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
