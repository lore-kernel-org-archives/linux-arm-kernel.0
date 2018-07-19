From: anson.huang@nxp.com (Anson Huang)
Date: Thu, 19 Jul 2018 08:29:58 +0000
Subject: [PATCH] ARM: dts: imx7d: add missing OPP property for cpu0
In-Reply-To: <20180719032002.GT4576@dragon>
References: <1531896889-21377-1-git-send-email-Anson.Huang@nxp.com>
 <20180719032002.GT4576@dragon>
Message-ID: <AM3PR04MB1315A99663BCB53A09733015F5520@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Shawn

Anson Huang
Best Regards!


> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: Thursday, July 19, 2018 11:20 AM
> To: Anson Huang <anson.huang@nxp.com>; Viresh Kumar
> <viresh.kumar@linaro.org>
> Cc: s.hauer at pengutronix.de; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; robh+dt at kernel.org; mark.rutland at arm.com;
> linux-arm-kernel at lists.infradead.org; devicetree at vger.kernel.org;
> linux-kernel at vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [PATCH] ARM: dts: imx7d: add missing OPP property for cpu0
> 
> On Wed, Jul 18, 2018 at 02:54:49PM +0800, Anson Huang wrote:
> > Commit b97872d4eb22 ("ARM: dts: imx: Add missing OPP properties for
> > CPUs") added "operating-points" property for all CPUs, but missed
> > i.MX7D's cpu0, this patch adds it.
> >
> > Fixes: b97872d4eb22 ("ARM: dts: imx: Add missing OPP properties for
> > CPUs")
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> 
> In general, when you send a patch fixing a commit, you should have the author
> of that commit copied.  I added Viresh here.

Thanks, I missed it.

> 
> It looks like a wrong fix to me.  It seems that commit b97872d4eb22 shouldn't
> change imx7d.dtsi at all.  So the correct fix would be reverting the change on
> imx7d.dtsi, @Viresh?

Agreed, I think the arch/arm/boot/dts/imx7d.dtsi should NOT be changed, as it already
had operating-points-v2 on both CPUs, I sent out another new patch with correct fix,
please review it.

Thanks.

Anson.


> 
> Shawn
> 
> > ---
> >  arch/arm/boot/dts/imx7d.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/imx7d.dtsi
> > b/arch/arm/boot/dts/imx7d.dtsi index 9a772fc..30a1a73 100644
> > --- a/arch/arm/boot/dts/imx7d.dtsi
> > +++ b/arch/arm/boot/dts/imx7d.dtsi
> > @@ -9,6 +9,11 @@
> >  / {
> >  	cpus {
> >  		cpu0: cpu at 0 {
> > +			operating-points = <
> > +				/* KHz	uV */
> > +				996000	1075000
> > +				792000	975000
> > +			>;
> >  			clock-frequency = <996000000>;
> >  			operating-points-v2 = <&cpu0_opp_table>;
> >  			#cooling-cells = <2>;
> > --
> > 2.7.4
> >
