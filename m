From: anson.huang@nxp.com (Yongcai Huang)
Date: Mon, 29 Aug 2016 06:02:56 +0000
Subject: [PATCH] ARM: imx6: enable WAIT mode hardware workaround for imx6sx
In-Reply-To: <20160829054418.GB31367@tiger>
References: <1471885400-9140-1-git-send-email-Anson.Huang@nxp.com>
 <20160829054418.GB31367@tiger>
Message-ID: <AM3PR04MB131571D6D08243A7C44AE1E7F5E10@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Best Regards!
Anson Huang



> -----Original Message-----
> From: Shawn Guo [mailto:shawnguo at kernel.org]
> Sent: 2016-08-29 1:44 PM
> To: Yongcai Huang <anson.huang@nxp.com>
> Cc: linux-arm-kernel at lists.infradead.org; Fabio Estevam
> <fabio.estevam@nxp.com>; Peter Chen <peter.chen@nxp.com>;
> kernel at pengutronix.de
> Subject: Re: [PATCH] ARM: imx6: enable WAIT mode hardware workaround for
> imx6sx
> 
> On Tue, Aug 23, 2016 at 01:03:20AM +0800, Anson Huang wrote:
> > Need to enable INT_MEM_CLK_LPM bit in CCM_CGPR for WAIT mode,
> without
> > this bit set, if there is pending interrupt during ARM platform
> > entering WAIT mode without power gating, cache data will be corrupted,
> > this is a hardware workaround for WAIT mode and must be enabled.
> >
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> >  arch/arm/mach-imx/cpuidle-imx6sx.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/mach-imx/cpuidle-imx6sx.c
> > b/arch/arm/mach-imx/cpuidle-imx6sx.c
> > index 3c6672b..41cdce6 100644
> > --- a/arch/arm/mach-imx/cpuidle-imx6sx.c
> > +++ b/arch/arm/mach-imx/cpuidle-imx6sx.c
> > @@ -90,6 +90,7 @@ static struct cpuidle_driver imx6sx_cpuidle_driver =
> > {
> >
> >  int __init imx6sx_cpuidle_init(void)
> >  {
> > +	imx6q_set_int_mem_clk_lpm(true);
> 
> It might be the time to rename the function to imx6_set_int_mem_clk_lpm()
> with a beforehand patch.
> 
> Shawn

Agree, already send out a V2 patch set to rename the function firstly, thanks.

Anson.

> 
> >  	imx6_enable_rbc(false);
> >  	/*
> >  	 * set ARM power up/down timing to the fastest,
> > --
> > 1.9.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
