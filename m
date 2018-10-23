From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 23 Oct 2018 14:41:37 +0200
Subject: [PATCH V2 4/8] gpio: vf610: add optional clock support
In-Reply-To: <AM0PR04MB42119A454DD2F53590BCE7FF80F50@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1540295058-26090-1-git-send-email-aisheng.dong@nxp.com>
 <1540295058-26090-5-git-send-email-aisheng.dong@nxp.com>
 <20181023120401.GO30658@n2100.armlinux.org.uk>
 <AM0PR04MB42119A454DD2F53590BCE7FF80F50@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <20181023124137.wivishetiasdytfr@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 23, 2018 at 12:23:12PM +0000, A.s. Dong wrote:
> Hi Russell,
> 
> > -----Original Message-----
> > From: Russell King - ARM Linux [mailto:linux at armlinux.org.uk]
> > Sent: Tuesday, October 23, 2018 8:04 PM
> [...]
> > On Tue, Oct 23, 2018 at 11:49:17AM +0000, A.s. Dong wrote:
> > > +	clk_gpio = devm_clk_get(&pdev->dev, "gpio");
> > > +	clk_port = devm_clk_get(&pdev->dev, "port");
> > > +	if ((PTR_ERR(clk_gpio) == -EPROBE_DEFER) ||
> > > +	    (PTR_ERR(clk_port) == -EPROBE_DEFER)) {
> > 
> > 	if (clk_gpio == ERR_PTR(-EPROBE_DEFER) ||
> > 	    clk_port == ERR_PTR(-EPROBE_DEFER)) {
> > 
> 
> Thanks for the suggestion. I will update it in next series.
> Before that, let's wait a moment to see if any more review comments.
> 
> BTW, as I see kernel currently is widely using PTR_ERR(ptr) to compare
> -EPROBE_DEFER, I'm not quite get the point why the new approach
> you suggested is better, is it less error-prone? Or something else?
> would you please help clarify a bit more?

See the discussion in https://lore.kernel.org/patchwork/patch/999602/.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
