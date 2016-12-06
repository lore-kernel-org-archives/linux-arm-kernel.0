From: ping.bai@nxp.com (Jacky Bai)
Date: Tue, 6 Dec 2016 08:39:06 +0000
Subject: [PATCH 06/11] ARM: dts: imx: Add imx6sll EVK board dts support
In-Reply-To: <CAOMZO5C5-tq-OWTYcmzJt=_57wOyXzNMUes1mctwwyoegwzJyQ@mail.gmail.com>
References: <1480660774-25055-1-git-send-email-ping.bai@nxp.com>
 <1480660774-25055-7-git-send-email-ping.bai@nxp.com>
 <CAOMZO5C5-tq-OWTYcmzJt=_57wOyXzNMUes1mctwwyoegwzJyQ@mail.gmail.com>
Message-ID: <AM3PR04MB5302514027B9CA75B15253287820@AM3PR04MB530.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Please see below.

> Subject: Re: [PATCH 06/11] ARM: dts: imx: Add imx6sll EVK board dts support
> 
> On Fri, Dec 2, 2016 at 4:39 AM, Bai Ping <ping.bai@nxp.com> wrote:
> > Add basic dts support for imx6sll EVK baoard.
> 
> s/baord/board

ok, I will fix this typo.

> 
> > +       battery: max8903 at 0 {
> > +               compatible = "fsl,max8903-charger";
> > +               pinctrl-names = "default";
> > +               dok_input = <&gpio4 13 1>;
> > +               uok_input = <&gpio4 13 1>;
> > +               chg_input = <&gpio4 15 1>;
> > +               flt_input = <&gpio4 14 1>;
> > +               fsl,dcm_always_high;
> > +               fsl,dc_valid;
> > +               fsl,adc_disable;
> 
> These properties do not exist in mainline, please remove them.

ok, thanks for you comment.
> 
> 
> > +               status = "okay";
> > +       };
> > +
> > +       pxp_v4l2_out {
> > +               compatible = "fsl,imx6sl-pxp-v4l2";
> > +               status = "okay";
> > +       };
> 
> We don't have pxp support in mainline kernel, please remove it.

Ok, I will remove it.

> 
> > +
> > +       regulators {
> > +               compatible = "simple-bus";
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> 
> 
> Please remove it and place the regulator nodes directly as below:

ok, I will fix it.

> 
> 
> > +
> > +               reg_usb_otg1_vbus: regulator at 0 {
> > +                       compatible = "regulator-fixed";
> > +                       reg = <0>;
> > +                       regulator-name = "usb_otg1_vbus";
> > +                       regulator-min-microvolt = <5000000>;
> > +                       regulator-max-microvolt = <5000000>;
> > +                       gpio = <&gpio4 0 GPIO_ACTIVE_HIGH>;
> > +                       enable-active-high;
> > +               };
> 
>     reg_usb_otg1_vbus: regulator-usb-otg1-vbus {
>           compatible = "regulator-fixed";
>           regulator-name = "usb_otg1_vbus";
>           regulator-min-microvolt = <5000000>;
>           regulator-max-microvolt = <5000000>;
>           gpio = <&gpio4 0 GPIO_ACTIVE_HIGH>;
>           enable-active-high;
>     };
> 
> > +&cpu0 {
> > +       arm-supply = <&sw1a_reg>;
> > +       soc-supply = <&sw1c_reg>;
> > +};
> 
> This is only for LDO bypass mode, right? We don't support LDO-bypass in
> mainline.
> 

On i.MX6SLL, no internal LDO for ARM and SOC.  We can only use external regulator for DVFS.

> > +&gpc {
> > +       fsl,ldo-bypass = <1>;
> 
> We don't support ldo-bypass in mainline, please remove it.
> 
> > +&pxp {
> > +       status = "okay";
> > +};
> 
> We don't support PXP in mainline, please remove it.

ok I will remove it.

BR
Jacky Bai
