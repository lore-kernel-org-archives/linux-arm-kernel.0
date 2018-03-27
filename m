From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 27 Mar 2018 19:35:09 +0200
Subject: [net-next PATCH v2 08/10] net: netcp: ethss: use
 of_get_phy_mode() to support different RGMII modes
In-Reply-To: <1522168309-12338-9-git-send-email-m-karicheri2@ti.com>
References: <1522168309-12338-1-git-send-email-m-karicheri2@ti.com>
 <1522168309-12338-9-git-send-email-m-karicheri2@ti.com>
Message-ID: <20180327173509.GQ5862@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +	} else if (slave->link_interface == RGMII_LINK_MAC_PHY) {
> +		has_phy = true;
> +		phy_mode = of_get_phy_mode(slave->node);
> +		/* if phy-mode is not present, default to
> +		 * PHY_INTERFACE_MODE_RGMII
> +		 */
> +		if (phy_mode < 0)
> +			phy_mode = PHY_INTERFACE_MODE_RGMII;

Can only do RGMII? Maybe add a call here to
phy_interface_mode_is_rgmii() and return -EINVAL if DT contains
something which is not RGMII?

	  Andrew
