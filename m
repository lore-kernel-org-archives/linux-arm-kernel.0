From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 9 Sep 2016 16:15:27 +0200
Subject: [PATCH v3 1/9] ethernet: add sun8i-emac driver
In-Reply-To: <1473425117-18645-2-git-send-email-clabbe.montjoie@gmail.com>
References: <1473425117-18645-1-git-send-email-clabbe.montjoie@gmail.com>
 <1473425117-18645-2-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20160909141527.GE30871@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Corentin

> +static int sun8i_emac_mdio_register(struct net_device *ndev)
> +{
> +	struct sun8i_emac_priv *priv = netdev_priv(ndev);
> +	struct mii_bus *bus;
> +	int ret;
> +
> +	bus = mdiobus_alloc();

You can use devm_mdiobus_alloc() which will simplify your error
handling and unregister code.

	 Andrew
