From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 1 Jun 2016 15:02:07 +0200
Subject: [PATCH v2 1/7] mdio:mux: Enhanced MDIO mux framework for
 integrated multiplexers
In-Reply-To: <1464701801-17243-2-git-send-email-pramod.kumar@broadcom.com>
References: <1464701801-17243-1-git-send-email-pramod.kumar@broadcom.com>
 <1464701801-17243-2-git-send-email-pramod.kumar@broadcom.com>
Message-ID: <20160601130207.GE31982@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
> index 8453f08..cf40e7a 100644
> --- a/drivers/of/of_mdio.c
> +++ b/drivers/of/of_mdio.c
> @@ -225,6 +225,9 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
>  	if (rc)
>  		return rc;
>  
> +	if (of_property_read_bool(np, "mdio-integrated-mux"))
> +		return 0;
> +

Hi

Rather than doing this, did you try setting bus->phy_mask = 0 and
calling mdiobus_register(), rather than of_mdiobus_regsiter() for the
parent bus?

	Andrew
