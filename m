From: ping.bai@nxp.com (Jacky Bai)
Date: Wed, 7 Feb 2018 03:00:35 +0000
Subject: [PATCH v3 1/2] Document: dt: binding: imx: update pinctrl doc for
 imx6sll
In-Reply-To: <CAOMZO5BTFpQzTS0cLoG2W2V9zgV5G3-=3k3UWa+L+HFPSBu06A@mail.gmail.com>
References: <1517969226-13076-1-git-send-email-ping.bai@nxp.com>
 <CAOMZO5BTFpQzTS0cLoG2W2V9zgV5G3-=3k3UWa+L+HFPSBu06A@mail.gmail.com>
Message-ID: <HE1PR04MB31134AF5EA0EB3CBB3FB3FF287FC0@HE1PR04MB3113.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCH v3 1/2] Document: dt: binding: imx: update pinctrl doc for
> imx6sll
> 
> On Wed, Feb 7, 2018 at 12:07 AM, Bai Ping <ping.bai@nxp.com> wrote:
> 
> > +Examples:
> > +#include "imx7ulp-pinfunc.h"
> 
> No need for including a imx7ulp header file here :-)
> 

Sorry, it is my mistake. Will fix it.

> > +
> > +/* Pin Controller Node */
> > +
> > +iomuxc: iomuxc at 020e0000 {
> > +               compatible = "fsl,imx6sll-iomuxc";
> > +               reg = <0x020e0000 0x4000>;
> > +
> > +       /* Pin configuration Node */
> > +       pinctrl_uart1: uart1grp {
> > +               pinmux = <
> > +                       MX6SLL_PAD_UART1_TXD__UART1_DCE_TX
> > +                       MX6SLL_PAD_UART1_RXD__UART1_DCE_RX
> > +               >;
> > +               slew-rate = <0x1>;
> > +               drive-strength = <0x6>;
> > +               fsl,pin-speed = <0x2>;
> > +               bias-pull-up = <0x2>;
> > +               input-schmitt-enable;
> > +       };
> > +};
> > diff --git a/arch/arm/boot/dts/imx6sll-pinfunc.h
> b/arch/arm/boot/dts/imx6sll-pinfunc.h
> > new file mode 100644
> > index 0000000..5a3700b
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6sll-pinfunc.h
> > @@ -0,0 +1,882 @@
> > +/*
> > + * Copyright 2016 Freescale Semiconductor, Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> 
> You could use SPDX line instead.

OK. Thanks for review.

BR
Jacky Bai
