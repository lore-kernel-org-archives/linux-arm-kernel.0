From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Apr 2013 21:02:20 +0200
Subject: [PATCH 18/21] usb: phy: tegra: don't call into tegra-ehci directly
In-Reply-To: <Pine.LNX.4.44L0.1304231239220.1679-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1304231239220.1679-100000@iolanthe.rowland.org>
Message-ID: <201304232102.20573.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 April 2013, Alan Stern wrote:
> On Tue, 23 Apr 2013, Arnd Bergmann wrote:

> > @@ -733,7 +731,9 @@ static int tegra_ehci_probe(struct platform_device *pdev)
> >  
> >  	tegra->phy = tegra_usb_phy_open(&pdev->dev, instance, hcd->regs,
> >  					pdata->phy_config,
> > -					TEGRA_USB_PHY_MODE_HOST);
> > +					TEGRA_USB_PHY_MODE_HOST,
> > +					&tegra_ehci_set_pts,
> > +					tegra_ehci_set_phcd);
> 
> Does the compiler warn about the unnecessary '&'? 

No, AFAIK, both variants are equally acceptable C.

> In any case, it
> looks strange to have one function pointer with an '&' and another
> without.

Yes, that was certainly not intentional. I've removed the '&' now.

> Aside from that minor detail, the ehci-tegra.c changes are fine.

Ok, thanks for the feedback.

	Arnd
