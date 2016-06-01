From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 1 Jun 2016 15:12:28 +0200
Subject: [PATCH v2 7/7] phy: Add Northstar2 PCI Phy support
In-Reply-To: <1464701801-17243-8-git-send-email-pramod.kumar@broadcom.com>
References: <1464701801-17243-1-git-send-email-pramod.kumar@broadcom.com>
 <1464701801-17243-8-git-send-email-pramod.kumar@broadcom.com>
Message-ID: <20160601131228.GF31982@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static int ns2_pci_phy_probe(struct mdio_device *mdiodev)
> +{
> +	struct device *dev = &mdiodev->dev;
> +	struct phy_provider *provider;
> +	struct ns2_pci_phy *p;
> +	struct phy *phy;
> +
> +	phy = devm_phy_create(dev, dev->of_node, &ns2_pci_phy_ops);
> +	if (IS_ERR_OR_NULL(phy)) {
> +		dev_err(dev, "failed to create Phy\n");
> +		return PTR_ERR(phy);
> +	}

https://www.mail-archive.com/linux-omap at vger.kernel.org/msg78030.html

	Andrew
