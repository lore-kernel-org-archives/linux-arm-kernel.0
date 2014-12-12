From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 12 Dec 2014 07:52:35 +0100
Subject: [PATCH 3/4] arm64: dts: Add mediatek MT8173 SoC and evaluation
 board dts and Makefile
In-Reply-To: <20141211180245.GE28150@leverpostej>
References: <1418208602-35584-1-git-send-email-eddie.huang@mediatek.com>
 <1418208602-35584-4-git-send-email-eddie.huang@mediatek.com>
 <20141211180245.GE28150@leverpostej>
Message-ID: <20141212065235.GK30369@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 11, 2014 at 06:02:46PM +0000, Mark Rutland wrote:
> Hi,
> 
> On Wed, Dec 10, 2014 at 10:50:01AM +0000, Eddie Huang wrote:
> > Add device tree support for MT8173 SoC and evalutaion board based on it.
> > 
> > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/Makefile       |   1 +
> >  arch/arm64/boot/dts/mt8173-evb.dts |  31 +++++++
> >  arch/arm64/boot/dts/mt8173.dtsi    | 164 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 196 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/mt8173-evb.dts
> >  create mode 100644 arch/arm64/boot/dts/mt8173.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
> > index f8001a6..db7661e 100644
> > --- a/arch/arm64/boot/dts/Makefile
> > +++ b/arch/arm64/boot/dts/Makefile
> > @@ -1,3 +1,4 @@
> > +dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
> >  dtb-$(CONFIG_ARCH_THUNDER) += thunder-88xx.dtb
> >  dtb-$(CONFIG_ARCH_VEXPRESS) += rtsm_ve-aemv8a.dtb foundation-v8.dtb
> >  dtb-$(CONFIG_ARCH_XGENE) += apm-mustang.dtb
> > diff --git a/arch/arm64/boot/dts/mt8173-evb.dts b/arch/arm64/boot/dts/mt8173-evb.dts
> > new file mode 100644
> > index 0000000..adf26dd
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/mt8173-evb.dts
> > @@ -0,0 +1,31 @@
> > +/*
> > + * Copyright (c) 2014 MediaTek Inc.
> > + * Author: Eddie Huang <eddie.huang@mediatek.com>
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +/dts-v1/;
> > +#include "mt8173.dtsi"
> > +
> > +/ {
> > +	model = "mediatek,mt8173-evb";
> > +
> > +	aliases {
> > +		serial0 = &uart0;
> > +		serial1 = &uart1;
> > +		serial2 = &uart2;
> > +		serial3 = &uart3;
> 
> Do any of these support earlycon?
> 
> > +	};
> > +
> > +	memory {
> 
> Nit: should be memory at 40000000 (and you'll need to add device_type =
> "memory").

skeleton.dtsi already has a /memory node with device_type = "memory".
Shouldn't that be used?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
