From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 23 Oct 2018 13:39:54 +0000
Subject: [PATCH V2 4/8] gpio: vf610: add optional clock support
In-Reply-To: <20181023124137.wivishetiasdytfr@pengutronix.de>
References: <1540295058-26090-1-git-send-email-aisheng.dong@nxp.com>
 <1540295058-26090-5-git-send-email-aisheng.dong@nxp.com>
 <20181023120401.GO30658@n2100.armlinux.org.uk>
 <AM0PR04MB42119A454DD2F53590BCE7FF80F50@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181023124137.wivishetiasdytfr@pengutronix.de>
Message-ID: <AM0PR04MB4211BBD3A3D883320F8D06EB80F50@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Uwe Kleine-K?nig [mailto:u.kleine-koenig at pengutronix.de]
> Sent: Tuesday, October 23, 2018 8:42 PM
> To: A.s. Dong <aisheng.dong@nxp.com>
> Cc: Russell King - ARM Linux <linux@armlinux.org.uk>; dongas86 at gmail.com;
> Linus Walleij <linus.walleij@linaro.org>; Stefan Agner <stefan@agner.ch>;
> linux-gpio at vger.kernel.org; robh+dt at kernel.org; dl-linux-imx
> <linux-imx@nxp.com>; kernel at pengutronix.de; Fabio Estevam
> <fabio.estevam@nxp.com>; shawnguo at kernel.org;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH V2 4/8] gpio: vf610: add optional clock support
> 
> On Tue, Oct 23, 2018 at 12:23:12PM +0000, A.s. Dong wrote:
> > Hi Russell,
> >
> > > -----Original Message-----
> > > From: Russell King - ARM Linux [mailto:linux at armlinux.org.uk]
> > > Sent: Tuesday, October 23, 2018 8:04 PM
> > [...]
> > > On Tue, Oct 23, 2018 at 11:49:17AM +0000, A.s. Dong wrote:
> > > > +	clk_gpio = devm_clk_get(&pdev->dev, "gpio");
> > > > +	clk_port = devm_clk_get(&pdev->dev, "port");
> > > > +	if ((PTR_ERR(clk_gpio) == -EPROBE_DEFER) ||
> > > > +	    (PTR_ERR(clk_port) == -EPROBE_DEFER)) {
> > >
> > > 	if (clk_gpio == ERR_PTR(-EPROBE_DEFER) ||
> > > 	    clk_port == ERR_PTR(-EPROBE_DEFER)) {
> > >
> >
> > Thanks for the suggestion. I will update it in next series.
> > Before that, let's wait a moment to see if any more review comments.
> >
> > BTW, as I see kernel currently is widely using PTR_ERR(ptr) to compare
> > -EPROBE_DEFER, I'm not quite get the point why the new approach you
> > suggested is better, is it less error-prone? Or something else?
> > would you please help clarify a bit more?
> 
> See the discussion in
> https://lore.kernel.org/patchwork/patch/999602/ 
>

Thanks for sharing the info.
It does help.

Regards
Dong Aisheng
 
> Best regards
> Uwe
> 
> --
> Pengutronix e.K.                           | Uwe Kleine-K?nig
> |
> Industrial Linux Solutions                 |
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=02%7C01%7Caisheng.dong%40nxp.com%7C06
> 5f26466899474bf61a08d638e4e308%7C686ea1d3bc2b4c6fa92cd99c5c3016
> 35%7C0%7C0%7C636758953039817883&amp;sdata=hSgiadfyiFoK4AVTF2BR
> guOU5H8C77%2BY2bdjViC4Sfw%3D&amp;reserved=0  |
