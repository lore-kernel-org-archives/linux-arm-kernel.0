From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 13 Nov 2012 16:46:58 +0100
Subject: [PATCH v6 2/7] net: mvneta: driver for Marvell Armada 370/XP
 network unit
In-Reply-To: <1352820622.24230.31.camel@joe-AO722>
References: <1352818843-4457-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1352818843-4457-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <1352820622.24230.31.camel@joe-AO722>
Message-ID: <20121113164658.03ae12f8@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Joe,

On Tue, 13 Nov 2012 07:30:22 -0800, Joe Perches wrote:
> On Tue, 2012-11-13 at 16:00 +0100, Thomas Petazzoni wrote:
> > This patch contains a new network driver for the network unit of the
> > ARM Marvell Armada 370 and the Armada XP. Both SoCs use the PJ4B
> > processor, a Marvell-developed ARM core that implements the ARMv7
> > instruction set.
> 
> This looks very clean to me.

Thanks!

With the below fixes, may I get your formal Acked-by on the driver
patch?

> trivial:
> some of the logging doesn't use terminating newlines.
> 
> > +static int mvneta_check_mtu_valid(struct net_device *dev, int mtu)
> > +{
> []
> > +       if (mtu > 9676) {
> > +               netdev_info(dev, "Illegal MTU value %d, round to 9676", mtu);
> []
> > +	if (!IS_ALIGNED(MVNETA_RX_PKT_SIZE(mtu), 8)) {
> > +		netdev_info(dev, "Illegal MTU value %d, rounding to %d",
> 
> missing newlines
> 
> > +static int __devinit mvneta_probe(struct platform_device *pdev)
> []
> > +	if (register_netdev(dev)) {
> > +		dev_err(&pdev->dev, "failed to register\n");
> > +		err = ENOMEM;
> > +		goto err_base;
> > +	}
> []
> > +	dev_info(&pdev->dev, "%s, mac: %pM\n", dev->name,
> > +		 dev->dev_addr);
> 
> You could use netdev_info here
> 
> 	netdev_info(dev, "mac: %pM\n", dev->dev_addr);

Thanks for those comments, I'll wait a bit to see if any other comment
shows up before tomorrow, and I'll send a v7 with those issues fixed.

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
