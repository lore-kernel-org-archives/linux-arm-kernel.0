From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 19 Aug 2016 15:15:17 +0200
Subject: [PATCH 1/2] net: phy: Add error checks in the driver
In-Reply-To: <1471610891-13353-1-git-send-email-appanad@xilinx.com>
References: <1471610891-13353-1-git-send-email-appanad@xilinx.com>
Message-ID: <20160819131517.GB7343@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -	mdiobus_write(phydev->mdio.bus, priv->addr, XILINX_GMII2RGMII_REG, val);
> +	err = mdiobus_write(phydev->mdio.bus, priv->addr, XILINX_GMII2RGMII_REG,
> +			    val);
> +	if (err < 0)
> +		return err;
>  
>  	return 0;

Do you need to assign err? Why not just

   return mdiobus_write(phydev->mdio.bus, priv->addr, XILINX_GMII2RGMII_REG,
			val);
