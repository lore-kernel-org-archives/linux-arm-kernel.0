From: lukma@denx.de (Lukasz Majewski)
Date: Wed, 4 Apr 2018 09:48:26 +0200
Subject: [PATCH v2] ARM: dts: tpc: Device tree description of the iMX6Q
 TPC board
In-Reply-To: <CAOMZO5BMWtWo6O_qKOsA_27xaReGDGczrujqRW8k23pkwscvDA@mail.gmail.com>
References: <20180403165945.3981-1-lukma@denx.de>
 <CAOMZO5BMWtWo6O_qKOsA_27xaReGDGczrujqRW8k23pkwscvDA@mail.gmail.com>
Message-ID: <20180404094826.36b2b998@jawa>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

Thanks for the feedback,

> Hi Lukasz,
> 
> On Tue, Apr 3, 2018 at 1:59 PM, Lukasz Majewski <lukma@denx.de> wrote:
> 
> > diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt
> > b/Documentation/devicetree/bindings/vendor-prefixes.txt index
> > ae850d6c0ad3..8ff7eadc8bef 100644 ---
> > a/Documentation/devicetree/bindings/vendor-prefixes.txt +++
> > b/Documentation/devicetree/bindings/vendor-prefixes.txt @@ -181,6
> > +181,7 @@ karo        Ka-Ro electronics GmbH keithkoep      Keith &
> > Koep GmbH keymile        Keymile GmbH
> >  khadas Khadas
> > +kiebackpeter    Kieback & Peter GmbH  
> 
> This should be a separate patch.

Ok.

> 
> >  kinetic Kinetic Technologies
> >  kingnovel      Kingnovel Technology Co., Ltd.
> >  kosagi Sutajio Ko-Usagi PTE Ltd.
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index ade7a38543dc..c148c4cf28f2 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -459,6 +459,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
> >         imx6q-icore-ofcap10.dtb \
> >         imx6q-icore-ofcap12.dtb \
> >         imx6q-icore-rqs.dtb \
> > +       imx6q-kp-tpc.dtb \
> >         imx6q-marsboard.dtb \
> >         imx6q-mccmon6.dtb \
> >         imx6q-nitrogen6x.dtb \
> > diff --git a/arch/arm/boot/dts/imx6q-kp-tpc.dts
> > b/arch/arm/boot/dts/imx6q-kp-tpc.dts new file mode 100644
> > index 000000000000..b5646040b516
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6q-kp-tpc.dts
> > @@ -0,0 +1,23 @@
> > +/*
> > + * Copyright 2018
> > + * Lukasz Majewski, DENX Software Engineering, lukma at denx.de
> > + *
> > + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)  
> 
> This line should be the first one and start with //

Ok.

> 
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "imx6q-kp.dtsi"
> > +
> > +/ {
> > +       model = "Freescale i.MX6 Qwuad K+P TPC Board";
> > +       compatible = "kiebackpeter,imx6q-tpc", "fsl,imx6q";
> > +
> > +       memory: memory at 10000000 {  
> 
> Only memory at 10000000 is enough.

Ok.

> 
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6q-kp.dtsi
> > @@ -0,0 +1,460 @@
> > +/*
> > + * Copyright 2018
> > + * Lukasz Majewski, DENX Software Engineering, lukma at denx.de
> > + *
> > + * SPDX-License-Identifier: (GPL-2.0+ OR MIT)  
> 
> Same here.
> 
> > +       beeper {
> > +               compatible = "pwm-beeper";
> > +               pwms = <&pwm2 0 500000>; //2kHz  
> 
> No // style comments, please.
> 
> > +       lcd_panel: lcd-panel {
> > +               compatible = "auo,g070vvn01";  
> 
> I don't see this compatible string in linux-next.

I've sent support for this display yesterday.

[PATCH] display: panel: Add AUO g070vvn01 display support (800x480)


> 
> > +&i2c1 {
> > +       clock-frequency = <400000>;
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_i2c1>;
> > +       status = "okay";
> > +
> > +       goodix_ts at 5d {
> > +               compatible = "goodix,gt911";
> > +               reg = <0x5d>;
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&pinctrl_ts>;
> > +               interrupt-parent = <&gpio1>;
> > +               interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
> > +               irq-gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
> > +               reset-gpios = <&gpio5 2 GPIO_ACTIVE_HIGH>;
> > +       };
> > +
> > +       rx8025 at 32 {
> > +               compatible = "dallas,rx8025";  
> 
> I don't see this compatible string in linux-next.

Ach... it should be "dallas,ds1307" as it supports also this chip. I
will fix it in v2.


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 488 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180404/f292cb17/attachment.sig>
