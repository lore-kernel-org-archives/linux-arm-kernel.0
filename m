From: anson.huang@nxp.com (Anson Huang)
Date: Wed, 28 Nov 2018 09:06:27 +0000
Subject: [PATCH 4/4] ARM64: dts: imx: add i.MX8QXP system controller RTC
 support
In-Reply-To: <20181128100420.0c9a721a@karo-electronics.de>
References: <1543311334-8807-1-git-send-email-Anson.Huang@nxp.com>
 <1543311334-8807-5-git-send-email-Anson.Huang@nxp.com>
 <20181128100420.0c9a721a@karo-electronics.de>
Message-ID: <DB3PR0402MB3916FFD700313BF684CF32AAF5D10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Lothar

Best Regards!
Anson Huang

> -----Original Message-----
> From: Lothar Wa?mann [mailto:LW at KARO-electronics.de]
> Sent: 2018?11?28? 17:04
> To: Anson Huang <anson.huang@nxp.com>
> Cc: a.zummo at towertech.it; alexandre.belloni at bootlin.com;
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
> Hi,
> 
> On Tue, 27 Nov 2018 09:41:46 +0000 Anson Huang wrote:
> > Add i.MX8QXP system controller RTC support.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > index 9155d45..ef57db6 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > @@ -433,4 +433,8 @@
> >  		#size-cells = <1>;
> >  		ranges = <0x5f000000 0x0 0x5f000000 0x1000000>;
> >  	};
> > +
> > +	rtc: rtc {
> > +		compatible = "nxp,imx8qxp-sc-rtc";
> > +	};
> >  };
> IMO this should be disabled by default.

This module is NOT depending on any board design, should it be enabled by default in soc dtsi?
Like wdog etc..

Anson.

> 
> 
> Lothar Wa?mann
