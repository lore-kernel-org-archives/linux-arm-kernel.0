From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 30 Sep 2014 16:28:50 +0200
Subject: [PATCH v5 02/10] net: pxa168_eth: add device tree support
In-Reply-To: <20140929.160436.1932620234954504510.davem@davemloft.net>
References: <1411742036-23520-1-git-send-email-antoine.tenart@free-electrons.com>
 <1411742036-23520-3-git-send-email-antoine.tenart@free-electrons.com>
 <20140929.160436.1932620234954504510.davem@davemloft.net>
Message-ID: <20140930142850.GA30288@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David,

On Mon, Sep 29, 2014 at 04:04:36PM -0400, David Miller wrote:
> From: Antoine Tenart <antoine.tenart@free-electrons.com>
> Date: Fri, 26 Sep 2014 16:33:48 +0200
> 
> > @@ -1603,6 +1620,12 @@ static int pxa168_eth_suspend(struct platform_device *pdev, pm_message_t state)
> >  #define pxa168_eth_suspend NULL
> >  #endif
> >  
> > +static const struct of_device_id pxa168_eth_of_match[] = {
> > +	{ .compatible = "marvell,pxa168-eth" },
> > +	{ },
> > +};
> > +MODULE_DEVICE_TABLE(of, pxa168_eth_of_match)
> > +
> >  static struct platform_driver pxa168_eth_driver = {
> 
> You didn't even compile test this change with module support enabled.
> 
> drivers/net/ethernet/marvell/pxa168_eth.c:1670:1: error: expected ?,? or ?;? before ?static?
> 
> MODULE_DEVICE_TABLE() must be completed with a trailing ';'

Oops, thanks for spotting this!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
