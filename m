From: anson.huang@nxp.com (Anson Huang)
Date: Sun, 3 Jun 2018 01:36:13 +0000
Subject: [PATCH 1/2] clk: imx6ul: add GPIO clock gates
In-Reply-To: <152792036327.225090.14543251343485084840@swboyd.mtv.corp.google.com>
References: <1526959560-6014-1-git-send-email-Anson.Huang@nxp.com>
 <1439344955.9677.1526991935718@email.1und1.de>
 <152792036327.225090.14543251343485084840@swboyd.mtv.corp.google.com>
Message-ID: <AM3PR04MB1315BD8947467077B61BB2E6F5600@AM3PR04MB1315.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Stephen

Anson Huang
Best Regards!


> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd at kernel.org]
> Sent: Saturday, June 2, 2018 2:19 PM
> To: Anson Huang <anson.huang@nxp.com>; Stefan Wahren
> <stefan.wahren@i2se.com>; Fabio Estevam <fabio.estevam@nxp.com>;
> kernel at pengutronix.de; mark.rutland at arm.com; matteo.lisi at engicam.com;
> michael at amarulasolutions.com; mturquette at baylibre.com;
> robh+dt at kernel.org; shawnguo at kernel.org
> Cc: linux-clk at vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH 1/2] clk: imx6ul: add GPIO clock gates
> 
> Quoting Stefan Wahren (2018-05-22 05:25:35)
> > > +++ b/include/dt-bindings/clock/imx6ul-clock.h
> > > @@ -242,20 +242,25 @@
> > >  #define IMX6UL_CLK_CKO2_PODF         229
> > >  #define IMX6UL_CLK_CKO2                      230
> > >  #define IMX6UL_CLK_CKO                       231
> > > +#define IMX6UL_CLK_GPIO1             232
> > > +#define IMX6UL_CLK_GPIO2             233
> > > +#define IMX6UL_CLK_GPIO3             234
> > > +#define IMX6UL_CLK_GPIO4             235
> > > +#define IMX6UL_CLK_GPIO5             236
> >
> > this change looks like a breakage of devicetree ABI. You are changing the
> mean of the existing clock IDs on i.MX6ULL, which probably regress the
> combination of older DTBs with newer kernel.
> >
> 
> Agreed. Why can't we just tack on more numbers at the end?
 
Ah, yes, I saw 6ULL are at the end of 6UL, so added them in 6UL, but did NOT consider the old dtb support.

Will send out a V2 patch to fix it, and I saw Fabio also sent a patch to fix the clko1/2 definition, I will do the
V2 patch based on his patch.

Anson.

> 
> > >
> > >  /* For i.MX6ULL */
> > > -#define IMX6ULL_CLK_ESAI_PRED                232
