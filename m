From: aisheng.dong@nxp.com (A.s. Dong)
Date: Tue, 23 Oct 2018 12:23:12 +0000
Subject: [PATCH V2 4/8] gpio: vf610: add optional clock support
In-Reply-To: <20181023120401.GO30658@n2100.armlinux.org.uk>
References: <1540295058-26090-1-git-send-email-aisheng.dong@nxp.com>
 <1540295058-26090-5-git-send-email-aisheng.dong@nxp.com>
 <20181023120401.GO30658@n2100.armlinux.org.uk>
Message-ID: <AM0PR04MB42119A454DD2F53590BCE7FF80F50@AM0PR04MB4211.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> -----Original Message-----
> From: Russell King - ARM Linux [mailto:linux at armlinux.org.uk]
> Sent: Tuesday, October 23, 2018 8:04 PM
[...]
> On Tue, Oct 23, 2018 at 11:49:17AM +0000, A.s. Dong wrote:
> > +	clk_gpio = devm_clk_get(&pdev->dev, "gpio");
> > +	clk_port = devm_clk_get(&pdev->dev, "port");
> > +	if ((PTR_ERR(clk_gpio) == -EPROBE_DEFER) ||
> > +	    (PTR_ERR(clk_port) == -EPROBE_DEFER)) {
> 
> 	if (clk_gpio == ERR_PTR(-EPROBE_DEFER) ||
> 	    clk_port == ERR_PTR(-EPROBE_DEFER)) {
> 

Thanks for the suggestion. I will update it in next series.
Before that, let's wait a moment to see if any more review comments.

BTW, as I see kernel currently is widely using PTR_ERR(ptr) to compare
-EPROBE_DEFER, I'm not quite get the point why the new approach
you suggested is better, is it less error-prone? Or something else?
would you please help clarify a bit more?

Regards
Dong Aisheng

> --
> RMK's Patch system:
> https://emea01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.
> armlinux.org.uk%2Fdeveloper%2Fpatches%2F&amp;data=02%7C01%7Caishen
> g.dong%40nxp.com%7C34fcfce2f5d042efd0b808d638dfaaed%7C686ea1d3bc
> 2b4c6fa92cd99c5c301635%7C0%7C0%7C636758930627945785&amp;sdata=
> PME05RkmX0mxRmhO%2Bj%2FofV3VN2VMx3FWU9bbqFr3XAg%3D&amp;res
> erved=0
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps
> up According to speedtest.net: 11.9Mbps down 500kbps up
