From: anson.huang@nxp.com (Anson Huang)
Date: Wed, 28 Nov 2018 09:21:56 +0000
Subject: [PATCH 4/4] ARM64: dts: imx: add i.MX8QXP system controller RTC
 support
In-Reply-To: <20181128091943.GB8952@piout.net>
References: <1543311334-8807-1-git-send-email-Anson.Huang@nxp.com>
 <1543311334-8807-5-git-send-email-Anson.Huang@nxp.com>
 <20181128100420.0c9a721a@karo-electronics.de>
 <DB3PR0402MB3916FFD700313BF684CF32AAF5D10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
 <20181128091943.GB8952@piout.net>
Message-ID: <DB3PR0402MB39168AC8DB69B81C51CE63C2F5D10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Best Regards!
Anson Huang

> -----Original Message-----
> From: Alexandre Belloni [mailto:alexandre.belloni at bootlin.com]
> Sent: 2018?11?28? 17:20
> To: Anson Huang <anson.huang@nxp.com>
> Cc: Lothar Wa?mann <LW@KARO-electronics.de>; a.zummo at towertech.it;
> robh+dt at kernel.org; mark.rutland at arm.com; catalin.marinas at arm.com;
> will.deacon at arm.com; Aisheng DONG <aisheng.dong@nxp.com>; Andy Gross
> <andy.gross@linaro.org>; arnd at arndb.de; horms+renesas at verge.net.au;
> heiko at sntech.de; bjorn.andersson at linaro.org; enric.balletbo at collabora.com;
> amit.kucheria at linaro.org; ezequiel at collabora.com; olof at lixom.net;
> shawnguo at kernel.org; linux-rtc at vger.kernel.org; devicetree at vger.kernel.org;
> linux-kernel at vger.kernel.org; linux-arm-kernel at lists.infradead.org;
> dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH 4/4] ARM64: dts: imx: add i.MX8QXP system controller
> RTC support
> 
> On 28/11/2018 09:06:27+0000, Anson Huang wrote:
> > > > diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > > b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > > > index 9155d45..ef57db6 100644
> > > > --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > > > +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > > > @@ -433,4 +433,8 @@
> > > >  		#size-cells = <1>;
> > > >  		ranges = <0x5f000000 0x0 0x5f000000 0x1000000>;
> > > >  	};
> > > > +
> > > > +	rtc: rtc {
> > > > +		compatible = "nxp,imx8qxp-sc-rtc";
> > > > +	};
> > > >  };
> > > IMO this should be disabled by default.
> >
> > This module is NOT depending on any board design, should it be enabled by
> default in soc dtsi?
> > Like wdog etc..
> >
> 
> I guess the point is that you may not want it enabled, even if it should always
> be working. enabling it by default would affect the RTC ordering for example.

i.MX SoCs ONLY have 1 RTC. And RTC are always enabled by default for all i.MX
SoCs, so do we have to disable it here and enable it in board dts?

Anson.

> 
> 
> --
> Alexandre Belloni, Bootlin
> Embedded Linux and Kernel engineering
> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fbootl
> in.com&amp;data=02%7C01%7Canson.huang%40nxp.com%7C0586fd10d6ff4
> 5d03f4308d65512a864%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C636789935951215703&amp;sdata=Hs1AXXoZMMKl8inOXFs8xXNXQ9EJG
> gtphyTNhFvMiTE%3D&amp;reserved=0
