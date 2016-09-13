From: clabbe.montjoie@gmail.com (LABBE Corentin)
Date: Tue, 13 Sep 2016 15:33:01 +0200
Subject: [PATCH v3 1/9] ethernet: add sun8i-emac driver
In-Reply-To: <20160909141527.GE30871@lunn.ch>
References: <1473425117-18645-1-git-send-email-clabbe.montjoie@gmail.com>
 <1473425117-18645-2-git-send-email-clabbe.montjoie@gmail.com>
 <20160909141527.GE30871@lunn.ch>
Message-ID: <20160913133301.GB31990@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 09, 2016 at 04:15:27PM +0200, Andrew Lunn wrote:
> Hi Corentin
> 
> > +static int sun8i_emac_mdio_register(struct net_device *ndev)
> > +{
> > +	struct sun8i_emac_priv *priv = netdev_priv(ndev);
> > +	struct mii_bus *bus;
> > +	int ret;
> > +
> > +	bus = mdiobus_alloc();
> 
> You can use devm_mdiobus_alloc() which will simplify your error
> handling and unregister code.
> 
> 	 Andrew

Hello

Since the mdio bus is allocated on ndev/open, it need to be removed when ndev/stop is called.
So devm_mdiobus_alloc cannot be used.

Regards

Corentin Labbe
