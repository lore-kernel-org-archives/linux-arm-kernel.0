From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 28 Nov 2018 10:19:43 +0100
Subject: [PATCH 4/4] ARM64: dts: imx: add i.MX8QXP system controller RTC
 support
In-Reply-To: <DB3PR0402MB3916FFD700313BF684CF32AAF5D10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1543311334-8807-1-git-send-email-Anson.Huang@nxp.com>
 <1543311334-8807-5-git-send-email-Anson.Huang@nxp.com>
 <20181128100420.0c9a721a@karo-electronics.de>
 <DB3PR0402MB3916FFD700313BF684CF32AAF5D10@DB3PR0402MB3916.eurprd04.prod.outlook.com>
Message-ID: <20181128091943.GB8952@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/11/2018 09:06:27+0000, Anson Huang wrote:
> > > diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > > index 9155d45..ef57db6 100644
> > > --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > > +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> > > @@ -433,4 +433,8 @@
> > >  		#size-cells = <1>;
> > >  		ranges = <0x5f000000 0x0 0x5f000000 0x1000000>;
> > >  	};
> > > +
> > > +	rtc: rtc {
> > > +		compatible = "nxp,imx8qxp-sc-rtc";
> > > +	};
> > >  };
> > IMO this should be disabled by default.
> 
> This module is NOT depending on any board design, should it be enabled by default in soc dtsi?
> Like wdog etc..
> 

I guess the point is that you may not want it enabled, even if it should
always be working. enabling it by default would affect the RTC ordering
for example.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
