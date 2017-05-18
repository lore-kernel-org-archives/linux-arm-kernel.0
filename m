From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 18 May 2017 15:02:20 +0200
Subject: [PATCH net-next] drivers: net: xgene: Check all RGMII phy mode
 variants
In-Reply-To: <CAFopSPTP07TFcgc8pACQDF4ZXHOftUMBqBCgF4hVpAmUt0cCWw@mail.gmail.com>
References: <1495051550-28961-1-git-send-email-isubramanian@apm.com>
 <20170517202633.GA14413@lunn.ch>
 <CAFopSPTP07TFcgc8pACQDF4ZXHOftUMBqBCgF4hVpAmUt0cCWw@mail.gmail.com>
Message-ID: <20170518130220.GA32503@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi Andrew,
> 
> Our purpose is to handle our internal pdata->phy_mode, so
> phy_interface_is_rgmii(phydev) seems not to fit.
> Instead, we're working on the below:
> 
> +bool is_xgene_enet_phy_mode_rgmii(struct net_device *ndev)
> +{
> +       struct xgene_enet_pdata *pdata = netdev_priv(ndev);
> +
> +       return pdata->phy_mode >= PHY_INTERFACE_MODE_RGMII &&
> +              pdata->phy_mode <= PHY_INTERFACE_MODE_RGMII_TXID;
> +}
> +

This is very generic, can could be used by other drivers. I prefer
what Florian suggested, have a generic helper which takes phy_mode as
a parameters. And then modify phy_interface_is_rgmii() to use this
helper.

	Andrew
