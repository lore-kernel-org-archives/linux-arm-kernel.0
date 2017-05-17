From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 17 May 2017 22:26:33 +0200
Subject: [PATCH net-next] drivers: net: xgene: Check all RGMII phy mode
 variants
In-Reply-To: <1495051550-28961-1-git-send-email-isubramanian@apm.com>
References: <1495051550-28961-1-git-send-email-isubramanian@apm.com>
Message-ID: <20170517202633.GA14413@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +bool is_xgene_enet_phy_mode_rgmii(struct net_device *ndev)
> +{
> +	struct xgene_enet_pdata *pdata = netdev_priv(ndev);
> +	int phy_mode = pdata->phy_mode;
> +	bool ret;
> +
> +	ret = phy_mode == PHY_INTERFACE_MODE_RGMII ||
> +	      phy_mode == PHY_INTERFACE_MODE_RGMII_ID ||
> +	      phy_mode == PHY_INTERFACE_MODE_RGMII_RXID ||
> +	      phy_mode == PHY_INTERFACE_MODE_RGMII_TXID;
> +
> +	return ret;
> +}

include/linux/phy.h:

/**
 * phy_interface_is_rgmii - Convenience function for testing if a PHY interface
 * is RGMII (all variants)
 * @phydev: the phy_device struct
 */
static inline bool phy_interface_is_rgmii(struct phy_device *phydev)
{
        return phydev->interface >= PHY_INTERFACE_MODE_RGMII &&
                phydev->interface <= PHY_INTERFACE_MODE_RGMII_TXID;
};

	Andrew
