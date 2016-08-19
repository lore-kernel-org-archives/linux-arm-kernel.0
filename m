From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Fri, 19 Aug 2016 13:18:12 +0000
Subject: [PATCH 1/2] net: phy: Add error checks in the driver
In-Reply-To: <20160819131517.GB7343@lunn.ch>
References: <1471610891-13353-1-git-send-email-appanad@xilinx.com>
 <20160819131517.GB7343@lunn.ch>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A5E4A7C@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

	Thanks for the review...

> > -	mdiobus_write(phydev->mdio.bus, priv->addr,
> XILINX_GMII2RGMII_REG, val);
> > +	err = mdiobus_write(phydev->mdio.bus, priv->addr,
> XILINX_GMII2RGMII_REG,
> > +			    val);
> > +	if (err < 0)
> > +		return err;
> >
> >  	return 0;
> 
> Do you need to assign err? Why not just

Ok will fix in the next version....

Regards,
Kedar.

> 
>    return mdiobus_write(phydev->mdio.bus, priv->addr,
> XILINX_GMII2RGMII_REG,
> 			val);
