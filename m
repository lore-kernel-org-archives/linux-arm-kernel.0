From: pramod.kumar@broadcom.com (Pramod Kumar)
Date: Fri, 3 Jun 2016 16:53:51 +0530
Subject: [PATCH v2 7/7] phy: Add Northstar2 PCI Phy support
In-Reply-To: <20160601131228.GF31982@lunn.ch>
References: <1464701801-17243-1-git-send-email-pramod.kumar@broadcom.com>
 <1464701801-17243-8-git-send-email-pramod.kumar@broadcom.com>
 <20160601131228.GF31982@lunn.ch>
Message-ID: <a8b5b6ef2c80b534eca1812caeacde57@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

> -----Original Message-----
> From: Andrew Lunn [mailto:andrew at lunn.ch]
> Sent: 01 June 2016 18:42
> To: Pramod Kumar
> Cc: Rob Herring; Pawel Moll; Mark Rutland; Ian Campbell; Kumar Gala;
Catalin
> Marinas; Will Deacon; Kishon Vijay Abraham I; David S. Miller;
> devicetree at vger.kernel.org; Jon Mason; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; bcm-kernel-feedback-list at broadcom.com;
linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v2 7/7] phy: Add Northstar2 PCI Phy support
>
> > +static int ns2_pci_phy_probe(struct mdio_device *mdiodev) {
> > +	struct device *dev = &mdiodev->dev;
> > +	struct phy_provider *provider;
> > +	struct ns2_pci_phy *p;
> > +	struct phy *phy;
> > +
> > +	phy = devm_phy_create(dev, dev->of_node, &ns2_pci_phy_ops);
> > +	if (IS_ERR_OR_NULL(phy)) {
> > +		dev_err(dev, "failed to create Phy\n");
> > +		return PTR_ERR(phy);
> > +	}
>
> https://www.mail-archive.com/linux-omap at vger.kernel.org/msg78030.html
>

I've explored inside this API and see it never returning NULL. I'll
replace IS_ERR_OR_NULL to IS_ERR.
Thanks for pointing this out.

> 	Andrew

Regards,
Pramod
