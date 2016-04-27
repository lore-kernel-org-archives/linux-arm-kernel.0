From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 26 Apr 2016 23:46:49 -0400
Subject: [PATCH 2/2] ARM: dts: imx6ul-pico-hobbit: Add initial support
In-Reply-To: <1460985138-6271-2-git-send-email-fabio.estevam@nxp.com>
References: <1460985138-6271-1-git-send-email-fabio.estevam@nxp.com>
 <1460985138-6271-2-git-send-email-fabio.estevam@nxp.com>
Message-ID: <CABxcv=mOTFWz89_6EhB40OPcYSRbfbimzYYMwaed6V62PL3RFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Fabio,

On Mon, Apr 18, 2016 at 9:12 AM, Fabio Estevam <fabio.estevam@nxp.com> wrote:

[snip]

> +
> +&i2c1 {
> +       clock-frequency = <100000>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_i2c1>;
> +       status = "okay";
> +
> +       pmic: pfuze3000 at 08 {
> +               compatible = "fsl,pfuze3000";
> +               reg = <0x08>;
> +
> +               regulators {
> +                       sw1a_reg: sw1a {
> +                               regulator-min-microvolt = <700000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                               regulator-ramp-delay = <6250>;
> +                       };
> +
> +                       /* VDD_ARM_SOC_IN*/
> +                       sw1b_reg: sw1b {
> +                               regulator-min-microvolt = <700000>;
> +                               regulator-max-microvolt = <1475000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                               regulator-ramp-delay = <6250>;
> +                       };
> +
> +                       sw2_reg: sw2 {
> +                               regulator-min-microvolt = <2500000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                       };
> +
> +                       /* DRAM */
> +                       sw3a_reg: sw3 {
> +                               regulator-min-microvolt = <900000>;
> +                               regulator-max-microvolt = <1650000>;
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                       };
> +
> +                       /* DRAM */
> +                       vref_reg: vrefddr {
> +                               regulator-boot-on;
> +                               regulator-always-on;
> +                       };
> +
> +                       vgen1_reg: vldo1 {
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       vgen2_reg: vldo2 {
> +                               regulator-min-microvolt = <800000>;
> +                               regulator-max-microvolt = <1550000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       vgen3_reg: vccsd {
> +                               regulator-min-microvolt = <2850000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       vgen4_reg: v33 {
> +                               regulator-min-microvolt = <2850000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       vgen5_reg: vldo3 {
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-always-on;
> +                       };
> +
> +                       vgen6_reg: vldo4 {
> +                               regulator-min-microvolt = <1800000>;
> +                               regulator-max-microvolt = <3300000>;
> +                               regulator-always-on;
> +                       };
> +               };
> +       };
> +};

Do all these regulators really need to be marked as always-on?

I see that these are not used by any device, so I guess that are
either unused or a dependency is missing in the DT. I think it's
better to only add the regulators that are really needed for now (i.e:
DRAM, VDD_ARM_SOC_IN, etc) and leave the ones that are not going to be
needed until the consumer devices are added.

Best regards,
Javier
