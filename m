From: dongas86@gmail.com (Dong Aisheng)
Date: Tue, 9 Jan 2018 10:17:04 +0800
Subject: [PATCH 2/2] ARM: dts: imx7s: add snvs rtc clock
In-Reply-To: <AM3PR04MB131588945BE9C5504C6EC0E8F5100@AM3PR04MB1315.eurprd04.prod.outlook.com>
References: <1515078402-22135-1-git-send-email-Anson.Huang@nxp.com>
 <1515078402-22135-2-git-send-email-Anson.Huang@nxp.com>
 <20180108103915.GD32635@b29396-OptiPlex-7040>
 <AM3PR04MB131588945BE9C5504C6EC0E8F5100@AM3PR04MB1315.eurprd04.prod.outlook.com>
Message-ID: <20180109021704.GG32635@b29396-OptiPlex-7040>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 01:43:25AM +0000, Anson Huang wrote:
> 
> 
> Best Regards!
> Anson Huang
> 
> 
> > -----Original Message-----
> > From: Dong Aisheng [mailto:dongas86 at gmail.com]
> > Sent: 2018-01-08 6:39 PM
> > To: Anson Huang <anson.huang@nxp.com>
> > Cc: linux-arm-kernel at lists.infradead.org; linux-clk at vger.kernel.org; linux-
> > kernel at vger.kernel.org; devicetree at vger.kernel.org; dl-linux-imx <linux-
> > imx at nxp.com>; shawnguo at kernel.org; kernel at pengutronix.de; Fabio
> > Estevam <fabio.estevam@nxp.com>; mturquette at baylibre.com;
> > sboyd at codeaurora.org; robh+dt at kernel.org; mark.rutland at arm.com;
> > stefan at agner.ch; linux at armlinux.org.uk
> > Subject: Re: [PATCH 2/2] ARM: dts: imx7s: add snvs rtc clock
> > 
> > On Thu, Jan 04, 2018 at 11:06:42PM +0800, Anson Huang wrote:
> > > Add i.MX7 SNVS RTC clock.
> > >
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > 
> > If this clock IMX7D_SNVS_CLK is used for all SNVS sub modules, then
> > snvs_poweroff and snvs_pwrkey should also rely on it, right?
> > 
> > How about add them all in one time?
> > 
> > BTW, syscon-poweroff seems still not introduce clock support and fsl,sec-v4.0-
> > pwrkey also does not handle clock, they may need to be added later.
> > 
> > Regards
> > Dong Aisheng
> 
> Yes, I thought about it before sending patch, but currently the poweroff and pwrkey driver do NOT
> handle clocks, so I plan to add them later, including handling clocks in driver and dtb.
> 

SNVS RTC binding doc does not claim a optional clock support, you probably may
need update the binding doc as well.

BTW, Should mx6 platforms need the same fixes?
If yes, we'd better fix them all.

Regards
Dong Aisheng

> Anson
> 
> > 
> > > ---
> > >  arch/arm/boot/dts/imx7s.dtsi | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/imx7s.dtsi
> > > b/arch/arm/boot/dts/imx7s.dtsi index e718fd2..f9b97f3 100644
> > > --- a/arch/arm/boot/dts/imx7s.dtsi
> > > +++ b/arch/arm/boot/dts/imx7s.dtsi
> > > @@ -534,6 +534,8 @@
> > >  					offset = <0x34>;
> > >  					interrupts = <GIC_SPI 19
> > IRQ_TYPE_LEVEL_HIGH>,
> > >  						     <GIC_SPI 20
> > IRQ_TYPE_LEVEL_HIGH>;
> > > +					clocks = <&clks IMX7D_SNVS_CLK>;
> > > +					clock-names = "snvs-rtc";
> > >  				};
> > >
> > >  				snvs_poweroff: snvs-poweroff {
> > > --
> > > 1.9.1
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-clk"
> > > in the body of a message to majordomo at vger.kernel.org More majordomo
> > > info at
> > > https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fvger
> > > .kernel.org%2Fmajordomo-
> > info.html&data=02%7C01%7CAnson.Huang%40nxp.com
> > > %7Cd10ff23b822b4cd16c2708d5568417c6%7C686ea1d3bc2b4c6fa92cd99c5c30
> > 1635
> > > %7C0%7C0%7C636510047707248763&sdata=FMx22hfKxs7YA%2F1zCVeYCnVX
> > 9Ck4MmB9
> > > GuolA51V2eg%3D&reserved=0
